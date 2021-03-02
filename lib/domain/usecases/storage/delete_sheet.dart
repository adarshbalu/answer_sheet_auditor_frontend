import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/repositories/remote_storage_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAnswerSheet implements UseCase<void, Params> {
  DeleteAnswerSheet(this.repository);
  final RemoteStorageRepository repository;

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.deleteAnswerSheetFromStorage(
        params.examName, params.name, params.uid);
  }
}
