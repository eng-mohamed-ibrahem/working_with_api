import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final connectivityProvider =
    StateNotifierProvider<_ConnectivityProviderState, ConnectivityResult>(
        (ref) {
  return _ConnectivityProviderState(ConnectivityResult.none);
});

class _ConnectivityProviderState extends StateNotifier<ConnectivityResult> {
  _ConnectivityProviderState(super.state);

  /// check if connected or not
  bool isConnected() {
    if (state == ConnectivityResult.bluetooth ||
        state == ConnectivityResult.none) {
      return false;
    } else if (state == ConnectivityResult.wifi ||
        state == ConnectivityResult.mobile) {
      return true;
    }
    return false;
  }

  Future<ConnectivityResult> checkConnection() async {
    log('1');
    state = await Connectivity().checkConnectivity();
    return state;
  }
}
