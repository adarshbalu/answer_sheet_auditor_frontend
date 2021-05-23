import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/data/models/exam_details_model.dart';
import 'package:answer_sheet_auditor/domain/entities/exam.dart';
import 'package:dartz/dartz.dart';

abstract class ExamRepository {
  Future<Either<Failure, void>> createExam(Map<String, dynamic> data);
  Future<Either<Failure, List<Exams>>> listAllExams();
  Future<Either<Failure, ExamDetails>> viewExamDetails(int id);
}
