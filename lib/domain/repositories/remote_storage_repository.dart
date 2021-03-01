import 'dart:io';

import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteStorageRepository {
  Future<Either<Failure, AnswerSheet>> uploadAnswerSheetToStorage(
      File file, String name, String uid, String examName);
  Future<Either<Failure, String>> uploadAnswerKeyToStorage(
      File file, String name, String uid);
  Future<Either<Failure, File>> pickImageFile();
  Future<Either<Failure, File>> pickTextFile();
}
