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
  bool firstTime = true;
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatus networkStatus = NetworkStatus.Loading;

  void _getNetworkStatus(ConnectivityResult status) {
    NetworkStatus newStatus = NetworkStatus.Loading;
    if (status == ConnectivityResult.mobile ||
        status == ConnectivityResult.wifi) {
      newStatus = NetworkStatus.Online;
    } else {
      newStatus = NetworkStatus.Offline;
    }
    if (newStatus != networkStatus) {
      networkStatus = newStatus;
      networkStatusController.add(newStatus);
    }
  }
}
