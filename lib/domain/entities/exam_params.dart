import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ExamParams extends Equatable {
  const ExamParams({
    @required this.name,
    @required this.answerkey,
    @required this.sheets,
  });

  final String name;
  final String answerkey;
  final List<AnswerSheets> sheets;

  @override
  List<Object> get props => [name, answerkey, sheets];
}

class AnswerSheets extends Equatable {
  const AnswerSheets({
    @required this.studentid,
    @required this.paperurl,
  });

  final String studentid;
  final String paperurl;

  @override
  List<Object> get props => [studentid, paperurl];
}
