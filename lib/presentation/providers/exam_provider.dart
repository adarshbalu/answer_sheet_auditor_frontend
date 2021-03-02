import 'package:answer_sheet_auditor/domain/usecases/exams/create_exam.dart';
import 'package:answer_sheet_auditor/domain/usecases/exams/get_all_exams.dart';
import 'package:flutter/cupertino.dart';

class ExamProvider extends ChangeNotifier {
  ExamProvider(this.getAllExams, this.createExams);
  final GetAllExams getAllExams;
  final CreateExams createExams;
}
