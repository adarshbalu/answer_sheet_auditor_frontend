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
    @required this.queued,
    @required this.failure,
    @required this.processing,
    @required this.success,
  });

  final int queued;
  final int processing;
  final int success;
  final int failure;

  @override
  List<Object> get props => [queued, processing, success, failure];
}
