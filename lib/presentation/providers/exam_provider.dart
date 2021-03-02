import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/data/models/exam_params_model.dart';
import 'package:answer_sheet_auditor/domain/entities/exam.dart';
import 'package:answer_sheet_auditor/domain/usecases/exams/create_exam.dart';
import 'package:answer_sheet_auditor/domain/usecases/exams/get_all_exams.dart';
import 'package:flutter/cupertino.dart';

enum DataLoadStatus { NONE, LOADING, LOADED, ERROR }

class ExamProvider extends ChangeNotifier {
  ExamProvider(this.getAllExams, this.createExams);
  final GetAllExams getAllExams;
  final CreateExams createExams;
  DataLoadStatus _createExamStatus, _getAllExamsStatus;
  DataLoadStatus get createExamStatus => _createExamStatus;
  DataLoadStatus get getAllExamsStatus => _getAllExamsStatus;
  List<Exams> _exams;

  List<Exams> get exams => _exams;

  Future<void> createNewExam(ExamParamsModel params) async {
    _createExamStatus = DataLoadStatus.LOADING;
    notifyListeners();
    final failureOrCreateExam = await createExams(params);
    failureOrCreateExam.fold((failure) {
      _createExamStatus = DataLoadStatus.ERROR;
      notifyListeners();
    }, (_) {
      _createExamStatus = DataLoadStatus.LOADED;
      notifyListeners();
    });
  }

  Future<void> getExamsList() async {
    _getAllExamsStatus = DataLoadStatus.LOADING;
    notifyListeners();
    final failureOrExamList = await getAllExams(NoParams());
    failureOrExamList.fold((failure) {
      _getAllExamsStatus = DataLoadStatus.ERROR;
      notifyListeners();
    }, (list) {
      _exams = list;
      _getAllExamsStatus = DataLoadStatus.LOADED;
      notifyListeners();
    });
  }
}
