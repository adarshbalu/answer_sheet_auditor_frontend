import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/repositories/storage_repository.dart';
import 'package:dartz/dartz.dart';

class UploadFileToStorage implements UseCase<String, Params> {
  UploadFileToStorage(this.repository);
  final StorageRepository repository;

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.uploadFileToStorage(params.file);
  }
}
