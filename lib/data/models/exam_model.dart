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
    @required this.name,
    @required this.evaluationDetailsModel,
  }) : super(
            id: id,
            name: name,
            evaluationStatus: evaluationStatus,
            evaluationDetails: evaluationDetailsModel);
  factory ExamsModel.fromJson(Map<String, dynamic> json) => ExamsModel(
        id: json['id'] as int,
        name: json['name'] as String,
        evaluationStatus: json['evaluation_status'] as bool,
        evaluationDetailsModel: EvaluationDetailsModel.fromJson(
            json['evaluation_details'] as Map<String, dynamic>),
      );
  final int id;
  final String name;
  final bool evaluationStatus;
  final EvaluationDetailsModel evaluationDetailsModel;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'evaluation_status': evaluationStatus,
        'evaluation_details': evaluationDetailsModel.toJson(),
      };
}

class EvaluationDetailsModel extends EvaluationDetails {
  const EvaluationDetailsModel({
    @required this.submitted,
    @required this.processed,
    @required this.remaining,
  }) : super(submitted: submitted, processed: processed, remaining: remaining);
  factory EvaluationDetailsModel.fromJson(Map<String, dynamic> json) =>
      EvaluationDetailsModel(
        submitted: json['submitted'] as int,
        processed: json['processed'] as int,
        remaining: json['remaining'] as int,
      );
  final int submitted;
  final int processed;
  final int remaining;

  Map<String, dynamic> toJson() => {
        'submitted': submitted,
        'processed': processed,
        'remaining': remaining,
      };
}
