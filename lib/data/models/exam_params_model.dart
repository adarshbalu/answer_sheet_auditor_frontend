import 'package:answer_sheet_auditor/domain/entities/exam_params.dart';
import 'package:meta/meta.dart';

class ExamParamsModel extends ExamParams {
  const ExamParamsModel({
    @required this.name,
    @required this.answerkey,
    @required this.sheets,
  }) : super(name: name, answerkey: answerkey, sheets: sheets);

  final String name;
  final String answerkey;
  final List<AnswerSheetModel> sheets;

  Map<String, dynamic> toJson() => {
        'name': name,
        'answerkey': answerkey,
        'sheets': List<dynamic>.from(sheets.map((x) => x.toJson())),
      };
}

class AnswerSheetModel extends AnswerSheets {
  const AnswerSheetModel({
    @required this.studentid,
    @required this.paperurl,
  }) : super(studentid: studentid, paperurl: paperurl);

  final String studentid;
  final String paperurl;

  Map<String, dynamic> toJson() => {
        'studentid': studentid,
        'paperurl': paperurl,
      };
}
