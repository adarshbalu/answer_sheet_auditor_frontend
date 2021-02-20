import 'package:answer_sheet_auditor/core/presentation/screens/auth/auth_widget_builder.dart';
import 'package:answer_sheet_auditor/core/presentation/theme/theme.dart';
import 'package:answer_sheet_auditor/core/utils/routes.dart';
import 'package:answer_sheet_auditor/di/injection_container.dart' as di;
import 'package:answer_sheet_auditor/presentation/providers/auth_provider.dart';
import 'package:answer_sheet_auditor/presentation/screens/auth/login_screen.dart';
import 'package:answer_sheet_auditor/presentation/screens/auth/sign_up.dart';
import 'package:answer_sheet_auditor/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/presentation/screens/auth/auth_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<AuthProvider>()),
      ],
      child: MateApp(),
    );
  }
}

class MateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthWidgetBuilder(
      builder: (context, userSnapshot) => MaterialApp(
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
        home: AuthWidget(userSnapshot: userSnapshot),
        routes: {
          Routes.LOGIN_SCREEN: (_) => LoginScreen(),
          Routes.SIGNUP_SCREEN: (_) => SignupScreen(),
          Routes.HOME_SCREEN: (_) => HomeScreen(),
        },
      ),
    );
  }
}
