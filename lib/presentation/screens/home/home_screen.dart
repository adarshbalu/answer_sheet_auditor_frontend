import 'package:answer_sheet_auditor/core/presentation/theme/theme.dart';
import 'package:answer_sheet_auditor/core/presentation/widgets/buttons/blue_button.dart';
import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:answer_sheet_auditor/data/models/exam_params_model.dart';
import 'package:answer_sheet_auditor/presentation/providers/exam_provider.dart';
import 'package:answer_sheet_auditor/presentation/providers/storage_provider.dart';
import 'package:answer_sheet_auditor/presentation/screens/upload/add_new_sheet.dart';
import 'package:answer_sheet_auditor/presentation/screens/upload/add_new_upload.dart';
import 'package:answer_sheet_auditor/presentation/widgets/answer_key_not_added.dart';
import 'package:answer_sheet_auditor/presentation/widgets/upload_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Consumer<ExamProvider>(
          builder: (_, provider, child) {
            if (provider.createExamStatus == DataLoadStatus.LOADED) {
              return const ExamAddedSuccess();
            } else {
              return child;
            }
          },
          child: Consumer<StorageProvider>(
            builder: (_, provider, child) {
              if (provider.keyUploadStatus == UploadStatus.UPLOADED) {
                return const AnswerSheetsList();
              } else {
                return child;
              }
            },
            child: const AnswerKeyNotAdded(),
          ),
        ),
      ),
      floatingActionButton: Consumer<StorageProvider>(
        builder: (_, provider, child) {
          if (provider.sheetStatus == SheetStatus.LOADED) {
            return FloatingActionButton(
              backgroundColor: AppTheme.PRIMARY_COLOR,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddNewSheet()));
              },
              child: const Icon(
                Icons.note_add_rounded,
                color: Colors.white,
              ),
            );
          } else {
            return child;
          }
        },
        child: FloatingActionButton(
          backgroundColor: AppTheme.PRIMARY_COLOR,
          onPressed: () {
            if (context.read<ExamProvider>().createExamStatus !=
                DataLoadStatus.LOADED) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddNewUpload()));
            } else {
              context.read<ExamProvider>().resetExam();
            }
          },
          child: const Icon(
            Icons.post_add_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AnswerSheetsList extends StatelessWidget {
  const AnswerSheetsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<StorageProvider>();
    if (provider.answerSheets.isNotEmpty) {
      return SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              'Answer sheets added',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: 24,
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, index) => UploadCard(
                  answerSheet: provider.answerSheets[index],
                ),
                itemCount: provider.answerSheets.length,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Spacer(),
            if (context.read<StorageProvider>().answerSheets.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: BlueButton(
                  label: 'Finish',
                  onPressed: () async {
                    context.read<StorageProvider>().answerKeyURL;
                    List<AnswerSheetModel> answerSheets;
                    answerSheets = <AnswerSheetModel>[];
                    context
                        .read<StorageProvider>()
                        .answerSheets
                        .forEach((element) {
                      answerSheets.add(AnswerSheetModel(
                          paperurl: element.url, studentid: element.name));
                    });
                    final ExamParamsModel exam = ExamParamsModel(
                        answerkey: context.read<StorageProvider>().answerKeyURL,
                        name: context.read<StorageProvider>().examName,
                        sheets: answerSheets);
                    await context.read<ExamProvider>().createNewExam(exam);
                  },
                ),
              )
            else
              const SizedBox.shrink(),
            const SizedBox(
              height: 16,
            ),
            Consumer<ExamProvider>(builder: (_, provider, child) {
              if (provider.createExamStatus == DataLoadStatus.LOADING) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (provider.createExamStatus == DataLoadStatus.ERROR) {
                toast.Fluttertoast.showToast(
                    msg: 'Error adding exam',
                    toastLength: toast.Toast.LENGTH_SHORT);
                return const SizedBox.shrink();
              } else {
                return const SizedBox.shrink();
              }
            }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    } else {
      return const NoSheetAdded();
    }
  }
}

class NoSheetAdded extends StatelessWidget {
  const NoSheetAdded({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              'Answer sheets added',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text('No sheets added'),
          ],
        ),
      ),
    );
  }
}

class ExamAddedSuccess extends StatelessWidget {
  const ExamAddedSuccess({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Exam added successfully',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 24,
          ),
          SvgPicture.asset(
            Assets.CONFIRMED,
            height: 200,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: BlueButton(label: 'Add new', onPressed: () {}),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
