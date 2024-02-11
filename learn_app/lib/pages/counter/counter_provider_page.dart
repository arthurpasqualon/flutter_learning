import 'package:flutter/material.dart';
import 'package:learn_app/services/counter_service.dart';
import 'package:provider/provider.dart';

class CounterProviderPage extends StatefulWidget {
  const CounterProviderPage({super.key});

  @override
  State<CounterProviderPage> createState() => _CounterProviderPageState();
}

class _CounterProviderPageState extends State<CounterProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter with Provider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You have pushed the button this many times:"),
            Consumer<CounterService>(
              builder:
                  (BuildContext context, CounterService counterService, _) {
                return Text(
                  "${counterService.counter}",
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CounterService>(context, listen: false).increment();
        },
        tooltip: "Increment",
        child: const Icon(Icons.add),
      ),
    );
  }
}
