import 'dart:io';

import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:dartz/dartz.dart';

abstract class StorageRepository {
  Future<Either<Failure, AnswerSheet>> uploadAnswerSheetToStorage(
      File file, String name);
  Future<Either<Failure, AnswerSheet>> uploadAnswerKeyToStorage(
      File file, String name);
  Future<Either<Failure, File>> pickImageFile();
  Future<Either<Failure, File>> pickTextFile();
}
