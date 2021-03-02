import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/entities/exam.dart';
import 'package:answer_sheet_auditor/domain/repositories/exam_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllExams implements UseCase<List<Exams>, NoParams> {
  GetAllExams(this.repository);
  final ExamRepository repository;

  @override
  Future<Either<Failure, List<Exams>>> call(NoParams noParams) {
    return repository.listAllExams();
  }
}
