import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:answer_sheet_auditor/presentation/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadCard extends StatelessWidget {
  const UploadCard({
    Key key,
    this.answerSheet,
  }) : super(key: key);

  final AnswerSheet answerSheet;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          answerSheet?.name,
          style: textTheme.headline4,
        ),
        trailing: InkWell(
          onTap: () =>
              context.read<StorageProvider>().removeAnswerSheet(answerSheet.id),
          child: const Icon(
            Icons.delete_outline,
            color: Colors.red,
            size: 25,
          ),
        ),
      ),
    );
  }
}
