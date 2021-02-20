import 'package:answer_sheet_auditor/di/injection_container.dart' as di;
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
