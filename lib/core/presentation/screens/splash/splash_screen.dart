import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffEEA080),
            Color(0xffF7A7C8),
          ],
        )),
        child: const Center(
          child: Text('Loading'),
        ),
      ),
    );
  }
}
