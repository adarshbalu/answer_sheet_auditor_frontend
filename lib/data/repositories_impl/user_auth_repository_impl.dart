import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/utils/strings_manager.dart';
import 'package:answer_sheet_auditor/data/datasources/local_datasouce.dart';
import 'package:answer_sheet_auditor/data/datasources/user_auth_remote_datasource.dart';
import 'package:answer_sheet_auditor/domain/repositories/user_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/error/exceptions.dart' as exc;

class UserAuthRepositoryImpl implements UserAuthRepository {
  UserAuthRepositoryImpl(this.remoteDataSource, this.localDataSource);
  final UserAuthRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final result = await remoteDataSource.getCurrentUser();
      return Right(result);
    } catch (e) {
      return _mapExceptionToFailure(e);
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmail(
      String email, String password) async {
    try {
      final result =
          await remoteDataSource.signInWithEmailOnFirebase(email, password);
      if (result != null) {
        final String jwt = await remoteDataSource.signInUser(email, password);
        await localDataSource.saveString(StringsManager.JWT_TOKEN, jwt);
      }
      return Right(result);
    } catch (e) {
      return _mapExceptionToFailure(e);
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    await localDataSource.removeData(StringsManager.JWT_TOKEN);
    return Right(await remoteDataSource.signOut());
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail(
      String email, String password) async {
    try {
      final result =
          await remoteDataSource.signUpWithEmailOnFirebase(email, password);
      if (result != null) {
        final String jwt =
            await remoteDataSource.signUpUser(email, password, result.uid);
        await localDataSource.saveString(StringsManager.JWT_TOKEN, jwt);
      }
      return Right(result);
    } catch (e) {
      return _mapExceptionToFailure(e);
    }
  }

  Left<AuthFailure, User> _mapExceptionToFailure(dynamic exception) {
    if (exception is exc.AuthException) {
      return Left(AuthFailure(message: exception.message));
    } else {
      return Left(AuthFailure());
    }
  }
}
