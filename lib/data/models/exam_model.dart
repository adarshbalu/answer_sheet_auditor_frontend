import 'dart:convert';

import 'package:answer_sheet_auditor/domain/entities/exam.dart';
import 'package:meta/meta.dart';

List<ExamsModel> examsModelFromJson(String str) {
  final data = jsonDecode(str) as List<dynamic>;
  final List<Map<String, dynamic>> examData =
      List<Map<String, dynamic>>.from(data.map((e) {
    return e as Map<String, dynamic>;
  }));
  return List<ExamsModel>.from(examData.map((e) {
    final ExamsModel examsModel = ExamsModel.fromJson(e);
    return examsModel;
  }));
}

class ExamsModel extends Exams {
  const ExamsModel({
    @required this.id,
    @required this.evaluationStatus,
    @required this.maxScore,
    @required this.name,
    @required this.evaluationDetailsModel,
  }) : super(
            id: id,
            name: name,
            evaluationStatus: evaluationStatus,
            maxScore: maxScore,
            evaluationDetails: evaluationDetailsModel);
  factory ExamsModel.fromJson(Map<String, dynamic> json) => ExamsModel(
        id: json['id'] as int,
        maxScore: json['maxscore'] as double,
        name: json['name'] as String,
        evaluationStatus: json['status'] as bool,
        evaluationDetailsModel: EvaluationDetailsModel.fromJson(
            json['details'] as Map<String, dynamic>),
      );
  final int id;
  final String name;
  final bool evaluationStatus;
  final EvaluationDetailsModel evaluationDetailsModel;
  final double maxScore;
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'evaluation_status': evaluationStatus,
        'evaluation_details': evaluationDetailsModel.toJson(),
      };
}

class EvaluationDetailsModel extends EvaluationDetails {
  const EvaluationDetailsModel({
    @required this.queued,
    @required this.processing,
    @required this.success,
    @required this.failure,
  }) : super(
            queued: queued,
            processing: processing,
            success: success,
            failure: failure);
  factory EvaluationDetailsModel.fromJson(Map<String, dynamic> json) =>
      EvaluationDetailsModel(
        queued: json['queued'] as int,
        processing: json['processing'] as int,
        success: json['success'] as int,
        failure: json['failure'] as int,
      );
  final int queued;
  final int processing;
  final int success;
  final int failure;

  Map<String, dynamic> toJson() => {
        'queued': queued,
        'processing': processing,
        'success': success,
        'failure': failure,
      };
}
