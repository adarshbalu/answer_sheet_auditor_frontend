import 'dart:io';

import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/data/datasources/storage_datasource.dart';
import 'package:answer_sheet_auditor/domain/repositories/storage_repository.dart';
import 'package:dartz/dartz.dart';

class StorageRepositoryImpl extends StorageRepository {
  StorageRepositoryImpl(this.storageRemoteDataSource);
  final StorageRemoteDataSource storageRemoteDataSource;

  @override
  Future<Either<Failure, String>> uploadFileToStorage(File file) async {
    try {
      final result = await storageRemoteDataSource.uploadFile(file);

      return Right(result);
    } catch (e) {
      return Left(UploadFailure());
    }
  }
}
