import 'dart:io';

import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/data/datasources/ml_kit_datasource.dart';
import 'package:answer_sheet_auditor/domain/repositories/text_recognizer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class TextRecognizerRepositoryImpl extends TextRecognizerRepository {
  TextRecognizerRepositoryImpl(this.dataSource);
  final MLKitDataSource dataSource;

  @override
  Future<Either<Failure, FirebaseVisionImage>> getVisionImageFromFile(
      File file) async {
    try {
      final FirebaseVisionImage visionImage =
          await dataSource.getVisionImageFromFile(file);
      return Right(visionImage);
    } catch (e) {
      return Left(VisionImageFailure());
    }
  }

  @override
  Future<Either<Failure, VisionText>> getTextFromImage(
      FirebaseVisionImage visionImage) async {
    try {
      final VisionText visionText =
          await dataSource.getTextFromVisionImage(visionImage);
      return Right(visionText);
    } catch (e) {
      return Left(VisionTextFailure());
    }
  }
}
