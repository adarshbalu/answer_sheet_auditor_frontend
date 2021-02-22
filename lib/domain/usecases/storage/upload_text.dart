import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:answer_sheet_auditor/domain/repositories/remote_storage_repository.dart';
import 'package:dartz/dartz.dart';

class UploadTextToStorage implements UseCase<AnswerSheet, Params> {
  UploadTextToStorage(this.repository);
  final RemoteStorageRepository repository;

  @override
  Future<Either<Failure, AnswerSheet>> call(Params params) {
    return repository.uploadAnswerKeyToStorage(params.file, params.name);
  }
}
