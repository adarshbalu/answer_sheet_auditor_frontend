import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:answer_sheet_auditor/domain/entities/exam.dart';
import 'package:answer_sheet_auditor/presentation/providers/exam_provider.dart';
import 'package:answer_sheet_auditor/presentation/screens/results/exam_all_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ExamProvider>().getExamsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            //header space
            SizedBox(
              height: screenSize.height * 0.06,
            ),
            //heading text
            SizedBox(
              width: screenSize.width * 0.4,
              child: FittedBox(
                child: Text(
                  'Results',
                  style: textTheme.headline3,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () async {
                context.read<ExamProvider>().getExamsList();
              },
              child: Center(
                child: SvgPicture.asset(
                  Assets.DASHBOARD,
                  height: 150,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Consumer<ExamProvider>(
              builder: (_, provider, child) {
                if (provider.getAllExamsStatus == DataLoadStatus.LOADED) {
                  if (provider.exams.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (_, index) => ExamCard(
                          exam: provider.exams[index],
                        ),
                        itemCount: provider.exams.length,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No exams added',
                        style: textTheme.headline4,
                      ),
                    );
                  }
                } else if (provider.getAllExamsStatus ==
                    DataLoadStatus.LOADING) {
                  return const CircularProgressIndicator();
                } else if (provider.getAllExamsStatus == DataLoadStatus.ERROR) {
                  Fluttertoast.showToast(
                      msg: 'Error Fetching data',
                      toastLength: Toast.LENGTH_SHORT);
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Error fetching data'),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExamCard extends StatelessWidget {
  const ExamCard({
    Key key,
    this.exam,
  }) : super(key: key);
  final Exams exam;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: exam.evaluationStatus
            ? const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              )
            : const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              ),
        onTap: () {
          context.read<ExamProvider>().getExamDetails(exam.id);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ExamAllInfoScreen(
                        exam: exam,
                      )));
        },
        title: Text(exam.name),
        subtitle: !exam.evaluationStatus
            ? const Text('Processing')
            : const Text('Completed'),
      ),
    );
  }
}
