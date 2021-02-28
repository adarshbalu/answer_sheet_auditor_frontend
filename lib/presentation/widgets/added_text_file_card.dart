import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddedTextFileCard extends StatelessWidget {
  const AddedTextFileCard({
    Key key,
    @required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: Card(
        margin: const EdgeInsets.only(bottom: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 16,
            ),
            SvgPicture.asset(
              Assets.DOCUMENT_ADDED,
              height: 200,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
