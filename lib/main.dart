import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const CreativeCounterApp());
}

class CreativeCounterApp extends StatelessWidget {
  const CreativeCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;
  Color bgColor = Colors.white;
  int shapeIndex = 0;

  // List of emojis based on counter
  final List<String> emojis = ["😐", "🙂", "😄", "🤩", "🔥"];

  // List of shapes (border radius)
  final List<BorderRadius> shapes = [
    BorderRadius.zero,                          // square
    BorderRadius.circular(20),                  // rounded rectangle
    BorderRadius.circular(1000),                // circle
  ];

  // Function to change color randomly
  void changeColor() {
    setState(() {
      counter++;
      bgColor = Color.fromARGB(
        255,
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
      );
      shapeIndex = (shapeIndex + 1) % shapes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Creative Counter with setState()"),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Counter: $counter",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Emoji Mood
            Text(
              emojis[counter % emojis.length],
              style: const TextStyle(fontSize: 60),
            ),
            const SizedBox(height: 20),

            // Shape Switcher
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: shapes[shapeIndex],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
