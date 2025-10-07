import 'package:flutter/material.dart';
import 'dart:math';
import 'home_screen.dart'; // Ensure this file exists

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      // Use a consistent app theme for a polished look
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMale = true;
  double height = 170;
  int age = 25;
  int weight = 65;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Gender Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              genderCard(Icons.male, "Male", isMale),
              genderCard(Icons.female, "Female", !isMale),
            ],
          ),

          // Height Section
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1D1E33),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Height",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  "${height.toInt()} cm",
                  style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Slider(
                  value: height,
                  min: 80,
                  max: 220,
                  activeColor: Colors.pink,
                  onChanged: (value) {
                    setState(() => height = value);
                  },
                ),
              ],
            ),
          ),

          // Age & Weight Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              infoCard("Age", age, () => setState(() => age++),
                      () => setState(() => age--)),
              infoCard("Weight", weight, () => setState(() => weight++),
                      () => setState(() => weight--)),
            ],
          ),

          // Calculate Button
          GestureDetector(
            onTap: () {
              // Formula: weight / (height_in_meters)^2
              double bmi = weight / pow(height / 100, 2);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ResultScreen(bmi: bmi, isMale: isMale),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Calculate BMI",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  // Gender Card Widget
  Widget genderCard(IconData icon, String label, bool selected) {
    return GestureDetector(
      onTap: () => setState(() => isMale = (label == "Male")),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: selected ? Colors.pinkAccent : const Color(0xFF1D1E33),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 70, color: Colors.white),
            const SizedBox(height: 10),
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    );
  }

  // Info Card (Age/Weight)
  Widget infoCard(
      String label, int value, VoidCallback onPlus, VoidCallback onMinus) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 20)),
          Text('$value',
              style: const TextStyle(
                  fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              roundButton(Icons.add, onPlus),
              const SizedBox(width: 10),
              roundButton(Icons.remove, onMinus),
            ],
          )
        ],
      ),
    );
  }

  // Round Button
  Widget roundButton(IconData icon, VoidCallback onPressed) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      constraints: const BoxConstraints.tightFor(width: 45, height: 45),
      child: Icon(icon, color: Colors.white),
    );
  }
}