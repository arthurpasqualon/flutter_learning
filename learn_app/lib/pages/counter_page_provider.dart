import 'package:flutter/material.dart';
import 'package:learn_app/services/counter_service.dart';
import 'package:provider/provider.dart';

class CounterPageProvider extends StatefulWidget {
  const CounterPageProvider({super.key});

  @override
  State<CounterPageProvider> createState() => _CounterPageProviderState();
}

class _CounterPageProviderState extends State<CounterPageProvider> {
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
