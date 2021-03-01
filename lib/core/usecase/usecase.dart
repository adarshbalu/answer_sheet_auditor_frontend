import 'dart:io';

import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

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
      this.visionImage,
      this.uid});
  final String name;
  final String uid;
  final String email;
  final String password;
  final File file;
  final FirebaseVisionImage visionImage;
  @override
  List<Object> get props =>
      <Object>[name, email, password, file, visionImage, uid];
}
