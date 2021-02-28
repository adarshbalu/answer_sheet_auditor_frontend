import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/repositories/text_recognizer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class GetVisionImageFromFile implements UseCase<FirebaseVisionImage, Params> {
  GetVisionImageFromFile(this.repository);
  final TextRecognizerRepository repository;

  @override
  Future<Either<Failure, FirebaseVisionImage>> call(Params params) {
    return repository.getVisionImageFromFile(params.file);
  }
}
