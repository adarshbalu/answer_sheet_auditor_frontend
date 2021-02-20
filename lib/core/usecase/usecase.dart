import 'dart:io';

import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class NoFutureUseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => <Object>[];
}

class Params extends Equatable {
  const Params({
    this.email,
    this.password,
    this.keyword,
    this.file,
    this.sms,
    this.verificationID,
    this.onPhoneVerified,
  });
  final String keyword;
  final String email;
  final String password;
  final File file;
  final String sms;
  final String verificationID;
  final Function(String, bool) onPhoneVerified;

  @override
  List<Object> get props => <Object>[keyword, email, password, file];
}
