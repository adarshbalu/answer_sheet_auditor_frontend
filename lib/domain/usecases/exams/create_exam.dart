import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/data/models/exam_params_model.dart';
import 'package:answer_sheet_auditor/domain/repositories/exam_repository.dart';
import 'package:dartz/dartz.dart';

class CreateExams implements UseCase<void, ExamParamsModel> {
  CreateExams(this.repository);
  final ExamRepository repository;

  @override
  Future<Either<Failure, void>> call(ExamParamsModel params) {
    return repository.createExam(params.toJson());
  }
}
