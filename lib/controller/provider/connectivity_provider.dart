import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final connectivityProvider =
    StateNotifierProvider<_ConnectivityProviderState, ConnectivityResult>(
        (ref) {
  return _ConnectivityProviderState(ConnectivityResult.none);
});

class _ConnectivityProviderState extends StateNotifier<ConnectivityResult> {
  _ConnectivityProviderState(super.state) {
    isConnected();
  }

  /// check if connected or not
  Future<bool> isConnected() async {
    state = await Connectivity().checkConnectivity();
    debugPrint('$state');
    if (state == ConnectivityResult.bluetooth ||
        state == ConnectivityResult.none) {
      return false;
    } else if (state == ConnectivityResult.wifi ||
        state == ConnectivityResult.mobile) {
      return true;
    }
    return false;
  }

  /// update checking
  bool updateConnectivity() {
    bool updated = false;
    isConnected().then((value) => updated = value);
    return updated;
  }
}
