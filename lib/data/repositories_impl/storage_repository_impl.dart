import 'dart:io';

import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/data/datasources/storage_datasource.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:answer_sheet_auditor/domain/repositories/storage_repository.dart';
import 'package:dartz/dartz.dart';

class StorageRepositoryImpl extends StorageRepository {
  StorageRepositoryImpl(this.storageRemoteDataSource);
  final StorageRemoteDataSource storageRemoteDataSource;

  @override
  Future<Either<Failure, AnswerSheet>> uploadAnswerSheetToStorage(
      File file, String name) async {
    try {
      final result =
          await storageRemoteDataSource.uploadAnswerSheet(file, name);

      return Right(result);
    } catch (e) {
      return Left(UploadFailure());
    }
  }
}
