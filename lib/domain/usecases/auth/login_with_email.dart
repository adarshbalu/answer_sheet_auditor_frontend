import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/repositories/user_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUser implements UseCase<User, Params> {
  LoginUser(this.repository);
  final UserAuthRepository repository;

  @override
  Future<Either<Failure, User>> call(Params params) {
    return repository.signInWithEmail(params.email, params.password);
  }
}
