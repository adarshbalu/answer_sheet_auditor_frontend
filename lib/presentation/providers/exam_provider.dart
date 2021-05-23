import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/data/models/exam_details_model.dart';
import 'package:answer_sheet_auditor/data/models/exam_params_model.dart';
import 'package:answer_sheet_auditor/domain/entities/exam.dart';
import 'package:answer_sheet_auditor/domain/usecases/exams/create_exam.dart';
import 'package:answer_sheet_auditor/domain/usecases/exams/get_all_exams.dart';
import 'package:answer_sheet_auditor/domain/usecases/exams/view_exam_details.dart';
import 'package:flutter/cupertino.dart';

enum DataLoadStatus { NONE, LOADING, LOADED, ERROR }

class ExamProvider extends ChangeNotifier {
  ExamProvider(this._getAllExams, this._createExams, this._viewExamDetails);
  final GetAllExams _getAllExams;
  final CreateExams _createExams;
  final ViewExamDetails _viewExamDetails;
  DataLoadStatus _createExamStatus, _getAllExamsStatus, _viewExamDetailsStatus;

  DataLoadStatus get viewExamDetailsStatus => _viewExamDetailsStatus;

  DataLoadStatus get createExamStatus => _createExamStatus;
  DataLoadStatus get getAllExamsStatus => _getAllExamsStatus;
  List<Exams> _exams;
  ExamDetails _examDetails;

  ExamDetails get examDetails => _examDetails;

  List<Exams> get exams => _exams;

  Future<void> createNewExam(ExamParamsModel params) async {
    _createExamStatus = DataLoadStatus.LOADING;
    notifyListeners();
    final failureOrCreateExam = await _createExams(params);
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
    final failureOrExamList = await _getAllExams(NoParams());
    failureOrExamList.fold((failure) {
      _getAllExamsStatus = DataLoadStatus.ERROR;
      notifyListeners();
    }, (list) {
      _exams = list;
      _getAllExamsStatus = DataLoadStatus.LOADED;
      notifyListeners();
    });
  }

  Future<void> getExamDetails(int id) async {
    _viewExamDetailsStatus = DataLoadStatus.LOADING;
    notifyListeners();
    final failureOrExamList = await _viewExamDetails(Params(id: id));
    failureOrExamList.fold((failure) {
      _viewExamDetailsStatus = DataLoadStatus.ERROR;
      notifyListeners();
    }, (exam) {
      _examDetails = exam;
      _viewExamDetailsStatus = DataLoadStatus.LOADED;
      notifyListeners();
    });
  }

  void resetExam() {
    _exams = [];
    _getAllExamsStatus = DataLoadStatus.NONE;
    _createExamStatus = DataLoadStatus.NONE;
    notifyListeners();
  }
}
