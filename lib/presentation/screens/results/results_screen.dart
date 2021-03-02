import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:answer_sheet_auditor/presentation/providers/exam_provider.dart';
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
                        itemBuilder: (_, index) => Card(
                          margin: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(provider.exams[index].name),
                          ),
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
