// To parse this JSON data, do
//
//     final examDetails = examDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

ExamDetails examDetailsFromJson(String str) =>
    ExamDetails.fromJson(json.decode(str) as Map<String, dynamic>);

class ExamDetails {
  ExamDetails({
    @required this.id,
    @required this.name,
    @required this.answerKey,
    @required this.sheets,
  });
  factory ExamDetails.fromJson(Map<String, dynamic> json) {
    List<Sheet> sheets;
    if (json["sheets"] != null) {
      sheets = [];
      json["sheets"].forEach((v) {
        sheets.add(Sheet.fromJson(v as Map<String, dynamic>));
      });
    }
    return ExamDetails(
        id: json['id'] as int,
        name: json['name'] as String,
        answerKey: json['answerkey'] as String,
        sheets: sheets);
  }

  final int id;
  final String name;
  final String answerKey;
  final List<Sheet> sheets;
}

class Sheet {
  Sheet({
    @required this.id,
    @required this.studentid,
    @required this.paperurl,
    @required this.score,
    @required this.status,
  });
  factory Sheet.fromJson(Map<String, dynamic> json) => Sheet(
        id: json['id'] as int,
        studentid: json['studentid'] as String,
        paperurl: json['paperurl'] as String,
        score: json['score'].toDouble() as double,
        status: json['status'] as bool,
      );
  final int id;
  final String studentid;
  final String paperurl;
  final double score;
  final bool status;
}
