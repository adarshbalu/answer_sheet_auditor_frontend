import 'package:answer_sheet_auditor/core/presentation/theme/theme.dart';
import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:answer_sheet_auditor/presentation/providers/storage_provider.dart';
import 'package:answer_sheet_auditor/presentation/screens/upload/add_new_upload.dart';
import 'package:answer_sheet_auditor/presentation/widgets/upload_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Consumer<StorageProvider>(
          builder: (_, provider, child) {
            if (provider.status == Status.LOADED) {
              return buildAnswerSheetList(context);
            } else {
              return child;
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(
                Assets.UPLOAD_FILES,
                height: 200,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'No files added',
                textAlign: TextAlign.center,
                style: textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.PRIMARY_COLOR,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddNewUpload()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildAnswerSheetList(BuildContext context) {
    final provider = context.read<StorageProvider>();
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
        ],
      ),
    );
  }
}
