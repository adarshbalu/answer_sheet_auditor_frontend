import 'dart:io';

import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/data/datasources/file_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources/remote_storage_datasource.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:answer_sheet_auditor/domain/repositories/remote_storage_repository.dart';
import 'package:dartz/dartz.dart';

class RemoteStorageRepositoryImpl extends RemoteStorageRepository {
  RemoteStorageRepositoryImpl(
      this.storageRemoteDataSource, this.fileDataSource);
  final RemoteStorageDataSource storageRemoteDataSource;
  final FileDataSource fileDataSource;

  @override
  Future<Either<Failure, AnswerSheet>> uploadAnswerSheetToStorage(
      File file, String name, String uid) async {
    try {
      final result =
          await storageRemoteDataSource.uploadAnswerSheet(file, name, uid);

      return Right(result);
    } catch (e) {
      return Left(UploadFailure());
    }
  }

  @override
  Future<Either<Failure, File>> pickImageFile() async {
    try {
      return Right(await fileDataSource.getImageFromStorage());
    } catch (e) {
      return Left(FilePickerFailure());
    }
  }

  @override
  Future<Either<Failure, File>> pickTextFile() async {
    try {
      return Right(await fileDataSource.getTextFromStorage());
    } catch (e) {
      return Left(FilePickerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadAnswerKeyToStorage(
      File file, String name, String uid) async {
    try {
      final result =
          await storageRemoteDataSource.uploadAnswerkey(file, name, uid);

      return Right(result);
    } catch (e) {
      return Left(UploadFailure());
    }
  }
}
