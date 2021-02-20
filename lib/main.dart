import 'package:answer_sheet_auditor/core/presentation/theme/theme.dart';
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
      theme: ThemeData(
        primaryColor: AppTheme.PRIMARY_COLOR,
        primaryColorBrightness: Brightness.light,
        accentColor: AppTheme.ACCENT_COLOR,
        canvasColor: AppTheme.CANVAS_COLOR,
        scaffoldBackgroundColor: AppTheme.CANVAS_COLOR,
        textTheme: AppTheme.FIXX_TEXT_THEME,
        buttonTheme: AppTheme.BUTTON_THEME_DATA,
        iconTheme: AppTheme.ICON_THEME_DATA,
      ),
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
