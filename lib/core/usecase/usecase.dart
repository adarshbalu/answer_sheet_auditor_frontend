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
  const Params(
      {this.email,
      this.password,
      this.name,
      this.file,
      this.id,
      this.examName,
      this.uid});
  final String name;
  final String uid;
  final String email;
  final String password;
  final int id;
  final File file;
  final String examName;
  @override
  List<Object> get props =>
      <Object>[name, email, password, file, uid, examName, id];
}
