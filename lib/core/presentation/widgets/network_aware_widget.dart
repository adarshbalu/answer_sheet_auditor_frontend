import 'package:answer_sheet_auditor/core/presentation/screens/splash/splash_screen.dart';
import 'package:answer_sheet_auditor/core/utils/network_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'overlay_notification.dart';

class NetworkAwareWidget extends StatelessWidget {
  const NetworkAwareWidget({Key key, this.onlineChild, this.offlineChild})
      : super(key: key);
  final Widget onlineChild;
  final Widget offlineChild;

  @override
  Widget build(BuildContext context) {
    final NetworkStatus networkStatus = Provider.of<NetworkStatus>(context);
    if (networkStatus == NetworkStatus.Online) {
      return onlineChild;
    } else if (networkStatus == NetworkStatus.Loading) {
      return const SplashScreen();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        OverlayNotification.showTopSnackBar(context,
            message: 'Disconnected', color: Colors.red, title: 'Notification');
      });
      return offlineChild;
    }
  }
}
