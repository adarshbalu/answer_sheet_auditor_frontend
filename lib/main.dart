import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Answer sheet Auditor',
      home: Scaffold(
        appBar: AppBar(
          title: const SelectableText('Answer Sheet Auditor'),
        ),
        body: const Center(child: SelectableText('Welcome')),
      ),
    );
  }
}
