import 'package:answer_sheet_auditor/core/presentation/theme/theme.dart';
import 'package:answer_sheet_auditor/core/presentation/widgets/buttons/blue_button.dart';
import 'package:answer_sheet_auditor/presentation/providers/storage_provider.dart';
import 'package:answer_sheet_auditor/presentation/screens/upload/add_new_sheet.dart';
import 'package:answer_sheet_auditor/presentation/screens/upload/add_new_upload.dart';
import 'package:answer_sheet_auditor/presentation/widgets/answer_key_not_added.dart';
import 'package:answer_sheet_auditor/presentation/widgets/upload_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Consumer<StorageProvider>(
          builder: (_, provider, child) {
            if (provider.keyUploadStatus == UploadStatus.UPLOADED) {
              return buildAnswerSheetList(context);
            } else {
              return child;
            }
          },
          child: const AnswerKeyNotAdded(),
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
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNewUpload()));
          },
          child: const Icon(
            Icons.post_add_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildAnswerSheetList(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: BlueButton(
                label: 'Finish',
                onPressed: () async {},
              ),
            )
          ],
        ),
      );
    } else {
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
}
