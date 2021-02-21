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
        return LoggedUserBuilder();
      } else {
        return LoginScreen();
      }
    } else {
      return const SplashScreen();
    }
  }
}

class LoggedUserBuilder extends StatefulWidget {
  @override
  _LoggedUserBuilderState createState() => _LoggedUserBuilderState();
}

class _LoggedUserBuilderState extends State<LoggedUserBuilder> {
  PageController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static List<Widget> children = [HomeScreen(), const Scaffold()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          elevation: 0,
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: 'Results', icon: Icon(Icons.description)),
            BottomNavigationBarItem(
                label: 'Settings', icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: PageView(
        physics: const ClampingScrollPhysics(),
        controller: _controller,
        children: children,
      ),
    );
  }
}
