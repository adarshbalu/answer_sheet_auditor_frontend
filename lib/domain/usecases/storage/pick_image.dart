import 'dart:io';

import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/repositories/storage_repository.dart';
import 'package:dartz/dartz.dart';

class PickImageFile implements UseCase<File, NoParams> {
  PickImageFile(this.repository);
  final StorageRepository repository;

  @override
  Future<Either<Failure, File>> call(NoParams noParams) {
    return repository.pickImageFile();
  }
}
