import 'dart:async';

import 'package:connectivity/connectivity.dart';

enum NetworkStatus { Online, Offline, Loading }

class NetworkStatusService {
  NetworkStatusService(this.connectivity) {
    connectivity.onConnectivityChanged.listen((status) {
      _getNetworkStatus(status);
    });
  }
  final Connectivity connectivity;

  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatus networkStatus = NetworkStatus.Loading;

  void _getNetworkStatus(ConnectivityResult status) {
    if (status == ConnectivityResult.mobile ||
        status == ConnectivityResult.wifi) {
      networkStatusController.add(NetworkStatus.Online);
    } else {
      networkStatusController.add(NetworkStatus.Offline);
    }
  }
}
