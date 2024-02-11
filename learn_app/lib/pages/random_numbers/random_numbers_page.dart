import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RandomNumbersPage extends StatefulWidget {
  const RandomNumbersPage({super.key});

  @override
  State<RandomNumbersPage> createState() => _RandomNumbersPageState();
}

class _RandomNumbersPageState extends State<RandomNumbersPage> {
  late Box boxRandomNumbers;

  int randomNumber = 0;
  int clickCount = 0;

  loadData() async {
    if (!Hive.isBoxOpen('app_storage')) {
      boxRandomNumbers = await Hive.openBox('app_storage');
    } else {
      boxRandomNumbers = Hive.box('app_storage');
    }
    randomNumber = boxRandomNumbers.get('randomNumber', defaultValue: 0);
    clickCount = boxRandomNumbers.get('clickCount', defaultValue: 0);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Random Numbers'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var random = Random().nextInt(1000);
            await boxRandomNumbers.put('randomNumber', random);
            await boxRandomNumbers.put('clickCount', clickCount + 1);
            await loadData();
          },
          child: const Icon(Icons.shuffle),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(children: [
            Text('Random Number: $randomNumber',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            Text('Click Count: $clickCount',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ]),
        ),
      ),
    );
  }
}
