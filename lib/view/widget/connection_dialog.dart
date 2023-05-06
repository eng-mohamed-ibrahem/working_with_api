import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controller/provider/connectivity_provider.dart';

class ConnectionDialog extends ConsumerWidget {
  const ConnectionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: const Color.fromRGBO(247, 247, 247, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no_internet_connection.jpg',
            fit: BoxFit.cover,
          ),
          
          TextButton(
              onPressed: () {
                ref.watch(connectivityProvider.notifier).checkConnection();
              },
              child: const Text('try again'))
        ],
      ),
    );
  }
}
