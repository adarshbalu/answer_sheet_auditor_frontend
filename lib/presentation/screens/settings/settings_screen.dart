import 'package:answer_sheet_auditor/core/presentation/widgets/buttons/red_button.dart';
import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:answer_sheet_auditor/presentation/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                  'Settings',
                  style: textTheme.headline3,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: SvgPicture.asset(
                Assets.USER,
                height: 150,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(context.read<User>().email),
                subtitle: const Text('Email '),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                subtitle: const Text('Account created at'),
                title: Text(DateFormat.yMMMMd('en_US')
                    .add_jm()
                    .format(context.read<User>().metadata.creationTime)),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                subtitle: const Text('Last sign in at'),
                title: Text(DateFormat.yMMMMd('en_US')
                    .add_jm()
                    .format(context.read<User>().metadata.lastSignInTime)),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                subtitle: const Text('User ID'),
                title: Text(context.read<User>().uid),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            RedButton(
              label: 'Logout',
              onPressed: () async {
                await context.read<AuthProvider>().signOutUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
