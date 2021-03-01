import 'package:answer_sheet_auditor/core/utils/assets.dart';
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {},
          child: SvgPicture.asset(
            Assets.UPLOAD_FILES,
            height: 200,
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
      ],
    );
  }
}
