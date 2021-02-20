import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/data/datasources/user_auth_remote_datasource.dart';
import 'package:answer_sheet_auditor/domain/repositories/user_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/error/exceptions.dart' as exc;

class UserAuthRepositoryImpl implements UserAuthRepository {
  UserAuthRepositoryImpl(this.remoteDataSource);
  final UserAuthRemoteDataSource remoteDataSource;

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
      final result = await remoteDataSource.signInWithEmail(email, password);
      return Right(result);
    } catch (e) {
      return _mapExceptionToFailure(e);
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return Right(await remoteDataSource.signOut());
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail(
      String email, String password) async {
    try {
      final result = await remoteDataSource.signUpWithEmail(email, password);
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

  @override
  Future<Either<Failure, User>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
