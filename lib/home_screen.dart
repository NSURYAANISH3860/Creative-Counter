import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double bmi;
  final bool isMale;

  const ResultScreen({super.key, required this.bmi, required this.isMale});

  String getResultText() {
    if (bmi >= 30) return "Obese";
    if (bmi >= 25) return "Overweight";
    if (bmi > 18.5) return "Normal";
    return "Underweight";
  }

  Color getResultColor() {
    if (bmi >= 30) return Colors.red;
    if (bmi >= 25) return Colors.orange;
    if (bmi > 18.5) return Colors.green;
    return Colors.yellow;
  }

  // You would typically add a function for text interpretation here as well

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text("BMI Result"),
        backgroundColor: const Color(0xFF0A0E21),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your BMI value is",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            Text(
              bmi.toStringAsFixed(1),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              getResultText(),
              style: TextStyle(
                  color: getResultColor(),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // Gender-based image load
            Image.asset(
              isMale
                  ? 'img.png'
                  : 'female_body.png',
              height: 250,
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Calculate Again",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}