import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_app/services/app_storage_service.dart';

class RandomNumbers extends StatefulWidget {
  const RandomNumbers({super.key});

  @override
  State<RandomNumbers> createState() => _RandomNumbersState();
}

class _RandomNumbersState extends State<RandomNumbers> {
  AppStorageService storage = AppStorageService();

  int randomNumber = 0;
  int clickCount = 0;

  loadData() async {
    randomNumber = await storage.randomNumber;
    clickCount = await storage.clickCount;
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
            await storage.setRandomNumber(random);
            await storage.setClickCount(clickCount + 1);
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
