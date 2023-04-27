import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'fetch_data_provider.dart';

class Details extends ConsumerWidget {
  final int index;
  const Details({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<dynamic>> comments = ref.watch(commentProvider);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: comments.when(
        data: (data) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('name:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        '${data[index]['name']}',
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('email:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(child: Text('${data[index]['email']}'))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('comment:'),
                const SizedBox(
                  height: 5,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text('${data[index]['body']}')),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Text('$error');
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
