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
          color: Colors.white,
        ),
        child: const Center(
          child: Text('Loading'),
        ),
      ),
    );
  }
}
