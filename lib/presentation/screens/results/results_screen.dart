import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:answer_sheet_auditor/data/models/exam_params_model.dart';
import 'package:answer_sheet_auditor/presentation/providers/exam_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                const ExamParamsModel exam = ExamParamsModel(
                    answerkey: 'http://answer1.com',
                    name: 'ajsd',
                    sheets: [
                      AnswerSheetModel(
                          studentid: 'asdghasd', paperurl: 'http://jhgsad.com')
                    ]);
                await context.read<ExamProvider>().createNewExam(exam);
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
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) => ListTile(
                        title: Text(provider.exams[index].name),
                      ),
                      itemCount: provider.exams.length,
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
