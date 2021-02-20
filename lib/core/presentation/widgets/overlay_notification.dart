import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class OverlayNotification {
  static void showTopSnackBar(BuildContext context,
          {@required String message,
          @required Color color,
          @required String title}) =>
      showSimpleNotification(
        Text(title),
        slideDismiss: true,
        subtitle: Text(message),
        background: color,
      );

  static void showBottomSnackBar(BuildContext context,
          {@required String message,
          @required Color color,
          @required String title}) =>
      showSimpleNotification(Text(title),
          slideDismiss: true,
          subtitle: Text(message),
          background: color,
          position: NotificationPosition.bottom);

  static void showBottomCallNotification(BuildContext context,
          {@required String message,
          @required Widget trailing,
          @required String title}) =>
      showSimpleNotification(
        Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        autoDismiss: false,
        trailing: LimitedBox(child: trailing),
        position: NotificationPosition.bottom,
        subtitle: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
        background: Colors.white,
      );
}
