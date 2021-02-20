import 'package:answer_sheet_auditor/presentation/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: context.read<AuthProvider>().streamFirebaseUser(),
      builder: (context, snapshot) {
        final User user = snapshot.data;
        if (user != null) {
          return Builder(builder: (context) => builder(context, snapshot));
        }
        return builder(context, snapshot);
      },
    );
  }
}
