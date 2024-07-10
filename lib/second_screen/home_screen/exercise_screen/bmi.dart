
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../first_screen/button.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({Key? key}) : super(key: key);

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  String weight = '';
  String height = '';
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmiResult = 0.0;
  bool showBMI = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              width: 40,
            ),
            Text(
              'BMI Calculator',
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                cursorColor: Colors.black,
                controller: weightController,
                onChanged: (value) => weight = value,
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
                cursorColor: Colors.black,
                controller: heightController,
                onChanged: (value) => height = value,
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
              SizedBox(height: 35),
              Button(
                text: 'Calculate BMI',
                textColor: Colors.white,
                bgColor: Colors.black87,
                fontsize: 22,
                fontWeight: FontWeight.w700,
                onPressed: () {
                  double weight = double.tryParse(weightController.text) ?? 0.0;
                  double height = double.tryParse(heightController.text) ?? 0.0;
                  if (weight > 0 && height > 0) {
                    setState(() {
                      double heightInMeter = height / 100;
                      bmiResult = weight / (heightInMeter * heightInMeter);
                      showBMI = true;
                    });
                  } else {
                    showBMI = false;
                  }
                },
              ),
              SizedBox(height: 20),
              if (showBMI)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'BMI : ',
                            style: GoogleFonts.alike(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            ' ${bmiResult.toStringAsFixed(2)}',
                            style: GoogleFonts.alike(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Image(
                        image: AssetImage(
                          "assets/images/bmi-calculator1.png",
                        ),
                        height: 250,
                        width: 600,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
