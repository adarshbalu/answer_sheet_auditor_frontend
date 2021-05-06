import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:answer_sheet_auditor/presentation/screens/upload/add_new_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnswerKeyNotAdded extends StatelessWidget {
  const AnswerKeyNotAdded({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Welcome to Answer Sheet Auditor',
            style: textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNewUpload()));
          },
          child: SvgPicture.asset(
            Assets.UPLOAD_FILES,
            height: 220,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          'Add new exam',
          textAlign: TextAlign.center,
          style: textTheme.subtitle1,
        ),
        const Spacer(),
      ],
    );
  }
}
