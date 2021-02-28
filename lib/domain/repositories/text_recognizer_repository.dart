import 'dart:io';

import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

abstract class TextRecognizerRepository {
  Future<Either<Failure, FirebaseVisionImage>> getVisionImageFromFile(
      File file);
}
