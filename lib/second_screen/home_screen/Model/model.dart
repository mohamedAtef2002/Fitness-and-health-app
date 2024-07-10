import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness_and_healty_app/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../firestore_service.dart';
import '../../../first_screen/button.dart';
import '../../../network_service.dart';

class ModelScreen extends StatefulWidget {
  const ModelScreen({Key? key}) : super(key: key);

  @override
  State<ModelScreen> createState() => _ModelScreenState();
}

class _ModelScreenState extends State<ModelScreen> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form
  String age = '';
  String weight = '';
  String height = '';
  String gender = '';
  String bodyFat = '';
  String selectedOption = '';
  bool _isButtonDisabled = false;

  final UserData _userData = UserData();
  late AlertDialog _loadingDialog; // Declare AlertDialog variable

  @override
  void initState() {
    super.initState();
    _loadingDialog = AlertDialog(
      title: Text('Fetching Data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Please wait...'),
        ],
      ),
    );
  }

  void _disableButtonForSomeTime() {
    setState(() {
      _isButtonDisabled = true;
    });

    // Set a timer for 5 seconds
    Timer(Duration(seconds: 5), () {
      setState(() {
        _isButtonDisabled = false;
      });
    });
  }

  Future<void> _saveUserData() async {
    await _userData.loadUserData(); // Load current data first
    _userData.gender = gender.isNotEmpty ? gender : _userData.gender;
    _userData.weight = weight.isNotEmpty ? weight : _userData.weight;
    _userData.height = height.isNotEmpty ? height : _userData.height;
    _userData.age = age.isNotEmpty ? age : _userData.age;
    _userData.activity = selectedOption.isNotEmpty ? selectedOption : _userData.activity;
    _userData.bodyfat = (bodyFat.isNotEmpty ? double.tryParse(bodyFat) : _userData.bodyfat)!;

    await _userData.saveUserData(
      gender: _userData.gender,
      weight: _userData.weight,
      height: _userData.height,
      age: _userData.age,
      activity: _userData.activity,
      bodyfat: _userData.bodyfat,
    );

    // Show confirmation or navigate away
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully')),
    );
  }

  Future<void> _findBestSystem() async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog
      builder: (BuildContext context) {
        return _loadingDialog;
      },
    );

    final networkService = NetworkService();
    try {
      final response = await networkService.createPost(
        'http://52.90.222.65:8000/predict/',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "weight": _userData.weight,
          "age": _userData.age,
          "gender": _userData.gender,
          "height": _userData.height,
          "activity": _userData.activity,
          "body_fat": _userData.bodyfat,
        }),
      );

      // Close loading dialog after 15 seconds
      Future.delayed(Duration(seconds: 12), () {
        Navigator.of(context).pop();
      });

      if (response.statusCode == 200) {
        print('Post created successfully!');
        print('Response Body: ${response.body}');
        final responseData = jsonDecode(response.body);

        final foodSystemId = responseData['food_system'];
        final exerciseId = responseData['exercises'];

        final firestoreService = FirestoreService();
        final dietPlan = await firestoreService.fetchDietPlan(foodSystemId);
        final exercisePlan = await firestoreService.fetchExercisePlan(exerciseId);
        print(dietPlan);
        print(exercisePlan);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('diet_plan', jsonEncode(dietPlan));
        await prefs.setString('exercise_plan', jsonEncode(exercisePlan));

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Plan fetched and saved successfully'),
            duration: Duration(seconds: 2), // Set duration of SnackBar
          ),
        );
      } else {
        print('Failed to create post.');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch plan. Please try again later.')),
        );
      }
    } catch (e) {
      print('An error occurred: ${e.toString()}');
      // Close loading dialog
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }

  void _handleButtonPress() async {
    // Save user data
    await _saveUserData();

    // Wait for 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      // Find the best system
      _findBestSystem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Text(
                      "Model",
                      style: GoogleFonts.alike(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  cursorColor: Colors.purple,
                  onChanged: (value) => setState(() => weight = value),
                  validator: (value) =>
                  value!.isEmpty ? "Enter your weight (kg)" : null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Weight (kg)",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    labelStyle: TextStyle(color: Colors.blueGrey.shade200),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.purple,
                  onChanged: (value) => setState(() => height = value),
                  validator: (value) =>
                  value!.isEmpty ? "Enter your height (cm)" : null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Height (cm)",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    labelStyle: TextStyle(color: Colors.blueGrey.shade200),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.purple,
                  onChanged: (value) => setState(() => age = value),
                  validator: (value) =>
                  value!.isEmpty ? "Enter your age (years)" : null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Age (years)",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    labelStyle: TextStyle(color: Colors.blueGrey.shade200),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.purple,
                  onChanged: (value) => setState(() => gender = value),
                  validator: (value) =>
                  value!.isEmpty ? "Enter your gender (male/female)" : null,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Gender (male/female)",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    labelStyle: TextStyle(color: Colors.blueGrey.shade200),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.purple,
                  onChanged: (value) => setState(() => bodyFat = value),
                  validator: (value) =>
                  value!.isEmpty ? "Enter your body fat percentage" : null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Body Fat",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    labelStyle: TextStyle(color: Colors.blueGrey.shade200),
                  ),
                ),
                SizedBox(height: 20),
                DropdownMenu(
                  width: 340,
                  label: Text("Select your activity"),
                  onSelected: (value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 'Less Active', label: 'Less Active'),
                    DropdownMenuEntry(value: 'Normal Active', label: 'Normal Active'),
                    DropdownMenuEntry(value: 'Very Active', label: 'Very Active'),
                  ],
                ),
                SizedBox(height: 35),
                Button(
                  text: 'Find Best System',
                  textColor: Colors.white,
                  bgColor: Colors.purple,
                  fontsize: 18,
                  fontWeight: FontWeight.w700,
                  onPressed: _handleButtonPress,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
