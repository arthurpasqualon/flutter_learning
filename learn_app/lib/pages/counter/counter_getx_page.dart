import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:learn_app/controllers/counter_getx_controller.dart';

class CounterGetxPage extends StatefulWidget {
  const CounterGetxPage({super.key});

  @override
  State<CounterGetxPage> createState() => _CounterGetxPageState();
}

class _CounterGetxPageState extends State<CounterGetxPage> {
  var counterController = Get.put(CounterGetXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter GetX'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  'Counter: ${counterController.count.value}',
                  style: const TextStyle(fontSize: 24),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                counterController.increment();
              },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
