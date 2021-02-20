import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAuthRepository {
  Future<Either<Failure, User>> signUpWithEmail(String email, String password);
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, User>> signInWithEmail(String email, String password);
  Future<Either<Failure, void>> signOut();
}
