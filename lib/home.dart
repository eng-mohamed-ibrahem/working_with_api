import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_with_api/details.dart';
import 'fetch_data_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<dynamic>> dataFromJson = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('fetch data'),
      ),
      body: dataFromJson.when(
        data: (data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: ListTile(
                  splashColor: Colors.blue,
                  minVerticalPadding: 5,
                  title: Text('${data[index]['id']}'),
                  subtitle: Text(data[index]['title']),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black45),
                      borderRadius: BorderRadius.circular(10)),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(index: index),
                        ));
                  },
                ),
              );
            },
            itemCount: data.length,
            padding: const EdgeInsets.all(10),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text('Error $error'));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
