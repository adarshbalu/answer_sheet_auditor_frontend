import 'package:answer_sheet_auditor/domain/entities/exam.dart';
import 'package:flutter/material.dart';

class ExamAllInfoScreen extends StatefulWidget {
  const ExamAllInfoScreen({Key key, this.exam}) : super(key: key);
  final Exams exam;

  @override
  _ExamAllInfoScreenState createState() => _ExamAllInfoScreenState();
}

class _ExamAllInfoScreenState extends State<ExamAllInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              '${widget.exam.name} Details',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(
              height: 16,
            ),
            ExamEvaluationIncomplete(
              exams: widget.exam,
            ),
          ],
        ),
      ),
    );
  }
}

class ExamEvaluationIncomplete extends StatelessWidget {
  const ExamEvaluationIncomplete({Key key, this.exams}) : super(key: key);
  final Exams exams;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              'More info',
              style: Theme.of(context).textTheme.headline6,
            ),
            ListTile(
              title: const Text('Queued'),
              subtitle: Text(exams.evaluationDetails.queued.toString()),
            ),
            ListTile(
              title: const Text('Processing'),
              subtitle: Text(exams.evaluationDetails.processing.toString()),
            ),
            ListTile(
              title: const Text('Success'),
              subtitle: Text(exams.evaluationDetails.success.toString()),
            ),
            ListTile(
              title: const Text('Failure'),
              subtitle: Text(exams.evaluationDetails.failure.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
