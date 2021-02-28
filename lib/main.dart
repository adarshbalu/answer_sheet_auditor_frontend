import 'package:answer_sheet_auditor/core/presentation/screens/auth/auth_widget_builder.dart';
import 'package:answer_sheet_auditor/core/presentation/screens/splash/no_connection.dart';
import 'package:answer_sheet_auditor/core/presentation/theme/theme.dart';
import 'package:answer_sheet_auditor/core/presentation/widgets/network_aware_widget.dart';
import 'package:answer_sheet_auditor/di/injection_container.dart' as di;
import 'package:answer_sheet_auditor/presentation/providers/auth_provider.dart';
import 'package:answer_sheet_auditor/presentation/providers/storage_provider.dart';
import 'package:answer_sheet_auditor/presentation/providers/text_recognizer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'core/presentation/screens/auth/auth_widget.dart';
import 'core/utils/network_status.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<StorageProvider>()),
        ChangeNotifierProvider(
            create: (_) => di.locator<TextRecognizerProvider>()),
        StreamProvider<NetworkStatus>(
          initialData: NetworkStatus.Loading,
          create: (_) =>
              di.locator<NetworkStatusService>().networkStatusController.stream,
        ),
      ],
      child: MateApp(),
    );
  }
}

class MateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthWidgetBuilder(
      builder: (context, userSnapshot) => OverlaySupport(
        child: MaterialApp(
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: AppTheme.PRIMARY_COLOR,
            primaryColorBrightness: Brightness.light,
            accentColor: AppTheme.ACCENT_COLOR,
            canvasColor: AppTheme.CANVAS_COLOR,
            scaffoldBackgroundColor: AppTheme.CANVAS_COLOR,
            textTheme: AppTheme.TEXT_THEME,
            buttonTheme: AppTheme.BUTTON_THEME_DATA,
            iconTheme: AppTheme.ICON_THEME_DATA,
          ),
          title: 'Answer sheet Auditor',
          home: NetworkAwareWidget(
            onlineChild: AuthWidget(userSnapshot: userSnapshot),
            offlineChild: const NoConnectionScreen(),
          ),

          // routes: {
          //   Routes.LOGIN_SCREEN: (_) => LoginScreen(),
          //   Routes.SIGNUP_SCREEN: (_) => SignupScreen(),
          //   Routes.HOME_SCREEN: (_) => HomeScreen(),
          // },
        ),
      ),
    );
  }
}
