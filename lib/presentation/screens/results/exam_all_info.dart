import 'package:answer_sheet_auditor/data/models/exam_details_model.dart';
import 'package:answer_sheet_auditor/domain/entities/exam.dart';
import 'package:answer_sheet_auditor/presentation/providers/exam_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        child: Consumer<ExamProvider>(
          builder: (_, provider, child) {
            if (provider.viewExamDetailsStatus == DataLoadStatus.LOADING) {
              return const CircularProgressIndicator();
            } else if (provider.viewExamDetailsStatus ==
                DataLoadStatus.LOADED) {
              return Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    '${widget.exam.name} (${widget.exam.maxScore})',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ExamEvaluationIncomplete(
                    exams: widget.exam,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'All marks info',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Flexible(
                    child: ListView.builder(
                        itemCount: provider.examDetails.sheets.length,
                        itemBuilder: (_, index) => ExamResultDetails(
                              sheet: provider.examDetails.sheets[index],
                            )),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Error occurred'),
              );
            }
          },
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

class ExamResultDetails extends StatelessWidget {
  const ExamResultDetails({Key key, this.sheet}) : super(key: key);
  final Sheet sheet;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(sheet.score.toString()),
        subtitle: const Text('Marks'),
        leading: CircleAvatar(
          child: Text(sheet.studentid.toString()),
        ),
      ),
    );
  }
}
