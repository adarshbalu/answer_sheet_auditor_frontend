import 'package:answer_sheet_auditor/data/models/exam_details_model.dart';
import 'package:answer_sheet_auditor/domain/entities/exam.dart';

abstract class ExamAPIRemoteDataSource {
  Future<void> createExam(Map<String, dynamic> data, String token);
  Future<List<Exams>> getAllExams(String token);
  Future<ExamDetails> getExamsDetails(String token, int id);
}
