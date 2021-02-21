import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:answer_sheet_auditor/domain/repositories/storage_repository.dart';
import 'package:dartz/dartz.dart';

class UploadTextToStorage implements UseCase<AnswerSheet, Params> {
  UploadTextToStorage(this.repository);
  final StorageRepository repository;

  @override
  Future<Either<Failure, AnswerSheet>> call(Params params) {
    return repository.uploadAnswerKeyToStorage(params.file, params.name);
  }
}
