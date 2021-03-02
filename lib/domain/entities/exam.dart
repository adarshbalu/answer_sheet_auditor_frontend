import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Exams extends Equatable {
  const Exams({
    @required this.id,
    @required this.name,
    @required this.evaluationStatus,
  });

  final int id;
  final String name;
  final EvaluationStatus evaluationStatus;

  @override
  List<Object> get props => [];
}

class EvaluationStatus extends Equatable {
  const EvaluationStatus({
    @required this.submitted,
    @required this.processed,
    @required this.remaining,
  });

  final int submitted;
  final int processed;
  final int remaining;

  @override
  List<Object> get props => [];
}
