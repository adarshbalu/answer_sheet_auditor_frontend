import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/data/models/exam_details_model.dart';
import 'package:answer_sheet_auditor/domain/repositories/exam_repository.dart';
import 'package:dartz/dartz.dart';

class ViewExamDetails implements UseCase<ExamDetails, Params> {
  ViewExamDetails(this.repository);
  final ExamRepository repository;

  @override
  Future<Either<Failure, ExamDetails>> call(Params params) {
    return repository.viewExamDetails(params.id);
  }
}
