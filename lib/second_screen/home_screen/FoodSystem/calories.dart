import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../first_screen/button.dart';

class Calories extends StatefulWidget {
  const Calories({Key? key}) : super(key: key);

  @override
  State<Calories> createState() => _CaloriesState();
}

class _CaloriesState extends State<Calories> {
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmr = 0;
  double tdee = 0;
  bool showResult = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("home");
              },
              icon: Icon(
                Icons.navigate_before_outlined,
                size: 30,
              ),
              color: Colors.white,
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              'Calories Calculator',
              style: GoogleFonts.alike(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        elevation: 20,
        shadowColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60, right: 12, left: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                cursorColor: Colors.black54,
                controller: ageController,
                validator: (value) =>
                    value!.length < 3 ? "enter your age (years)" : null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: "Age (years)",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  labelStyle: TextStyle(color: Colors.blueGrey.shade200),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                cursorColor: Colors.black54,
                controller: weightController,
                validator: (value) =>
                    value!.length < 3 ? "enter your weight (kg)" : null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: "Weight (kg)",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  labelStyle: TextStyle(color: Colors.blueGrey.shade200),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                cursorColor: Colors.black54,
                controller: heightController,
                validator: (value) =>
                    value!.length < 3 ? "enter your height (cm)" : null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: "Height (cm)",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  labelStyle: TextStyle(color: Colors.blueGrey.shade200),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Button(
                    text: 'Calculate ',
                    textColor: Colors.white,
                    bgColor: Colors.black87,
                    fontsize: 22,
                    fontWeight: FontWeight.w700,
                    onPressed: () {
                      calculateBMR();
                      calculateTDEE();
                      showResult = true;
                    }),
              ),
              SizedBox(height: 35),
              if (showResult == true)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Basal Metabolic Rate (BMR):'
                      ' \n $bmr calories',
                      style: GoogleFonts.alike(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Total Daily Energy Expenditure (TDEE):'
                      '\n $tdee calories',
                      style: GoogleFonts.alike(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to calculate BMR
  void calculateBMR() {
    int age = int.tryParse(ageController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;
    // Calculate BMR using Mifflin-St Jeor Equation
    if (age > 0 && weight > 0 && height > 0) {
      if (ageController.text.isNotEmpty &&
          weightController.text.isNotEmpty &&
          heightController.text.isNotEmpty) {
        setState(() {
          if (ageController.text.isNotEmpty &&
              weightController.text.isNotEmpty &&
              heightController.text.isNotEmpty) {
            bmr = 10 * weight + 6.25 * height - 5 * age + 5;
          }
        });
      }
    }
  }

  // Function to calculate TDEE
  void calculateTDEE() {
    if (bmr > 0) {
      // You can adjust TDEE based on activity level
      setState(() {
        tdee = bmr * 1.2; // Assuming first_screen sedentary activity level
      });
    }
  }
}
