import 'package:answer_sheet_auditor/core/presentation/screens/splash/splash_screen.dart';
import 'package:answer_sheet_auditor/presentation/screens/auth/login_screen.dart';
import 'package:answer_sheet_auditor/presentation/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      if (userSnapshot.hasData) {
        return HomeScreen();
      } else {
        return LoginScreen();
      }
    } else {
      return const SplashScreen();
    }
  }
}
