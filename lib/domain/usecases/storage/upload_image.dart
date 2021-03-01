import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:answer_sheet_auditor/domain/repositories/remote_storage_repository.dart';
import 'package:dartz/dartz.dart';

class UploadImageToStorage implements UseCase<AnswerSheet, Params> {
  UploadImageToStorage(this.repository);
  final RemoteStorageRepository repository;

  @override
  Future<Either<Failure, AnswerSheet>> call(Params params) {
    return repository.uploadAnswerSheetToStorage(
        params.file, params.name, params.uid);
  }
}
