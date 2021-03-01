import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
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
            Center(
              child: SvgPicture.asset(
                Assets.DASHBOARD,
                height: 150,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
