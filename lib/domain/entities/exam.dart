import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Exams extends Equatable {
  const Exams({
    @required this.id,
    @required this.name,
    @required this.evaluationDetails,
    @required this.evaluationStatus,
  });
  final bool evaluationStatus;
  final int id;
  final String name;
  final EvaluationDetails evaluationDetails;

  @override
  List<Object> get props => [evaluationDetails, evaluationStatus, id, name];
}

class EvaluationDetails extends Equatable {
  const EvaluationDetails({
    @required this.submitted,
    @required this.processed,
    @required this.remaining,
  });

  final int submitted;
  final int processed;
  final int remaining;

  @override
  List<Object> get props => [submitted, processed, remaining];
}
