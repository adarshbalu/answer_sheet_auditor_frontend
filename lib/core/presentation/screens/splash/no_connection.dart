import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.NO_CONNECTION),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Whoops!',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: const Color(0xff8C8C8C)),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'No internet connection found. Check your connection or try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[400], fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
