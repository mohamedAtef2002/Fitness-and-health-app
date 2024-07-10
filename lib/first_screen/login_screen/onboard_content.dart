import 'dart:convert';
import 'package:fitness_and_healty_app/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network_service.dart';
import '../../second_screen/home_screen/home.dart';
import '../../userData.dart';
import 'landed_content.dart';

class OnboardContent extends StatefulWidget {
  const OnboardContent({super.key});

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}
 UserData _userData = UserData();
class _OnboardContentState extends State<OnboardContent> {
  late PageController _pageController;
  bool visible = true;
  String _email = '', _password = '';
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  @override
  void initState() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _userData.loadUserData();
    setState(() {});
  }

  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      visible = !visible;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _onLoginButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final userCredential = await signInWithEmailPassword(_email, _password);

        // Handle successful authentication
        if (userCredential != null) {
          // Fetch user data
          await _loadData();

          // Make network request
          final response = await NetworkService().createPost(
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

          if (response.statusCode == 200) {
            // Handle successful response
            final responseData = jsonDecode(response.body);
            final foodSystemId = responseData['food_system'];
            final exerciseId = responseData['exercises'];

            // Fetch diet plan and exercise plan from Firestore
            final firestoreService = FirestoreService();
            final dietPlan = await firestoreService.fetchDietPlan(foodSystemId);
            final exercisePlan = await firestoreService.fetchExercisePlan(exerciseId);

            // Save diet and exercise plans to SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('diet_plan', jsonEncode(dietPlan));
            await prefs.setString('exercise_plan', jsonEncode(exercisePlan));

            // Show success message
            _showSnackBar('Diet and Exercise Plans saved successfully');

            // Navigate to home screen
            SharedPreferences prefss =
            await SharedPreferences
                .getInstance();
            await prefss.setBool('isLoggedIn', true);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    home(),
              ),
                  (route) => false,
            );
          } else {
            // Handle failed network request
            throw Exception('Failed to create post. Status code: ${response.statusCode}');
          }
        }
      } on FirebaseAuthException catch (e) {
        // Handle FirebaseAuth exceptions
        if (e.code == 'user-not-found') {
          _showSnackBar('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          _showSnackBar('Wrong password provided for that user.');
        } else {
          _showSnackBar('Authentication failed. ${e.message}');
        }
      } catch (e) {
        // Handle other exceptions
        _showSnackBar('An error occurred: ${e.toString()}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final double progress = _pageController.hasClients ? (_pageController.page ?? 0) : 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(235),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SizedBox(
        height: 400 + progress * 140,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      LandingContent(),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Login",
                                style: GoogleFonts.alike(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 32),
                              _buildLoginForm(),
                              const SizedBox(height: 140),
                              Row(
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blueGrey.shade200),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('signin');
                                    },
                                    child: Text(
                                      "Sign in.",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              height: 56,
              bottom: 42 + progress * 102,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  if (_pageController.page == 0) {
                    _pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.4, 0.8],
                      colors: [Colors.purple, Color.fromARGB(200, 150, 40, 100)],
                    ),
                  ),
                  child: DefaultTextStyle(
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 92 + progress * 32,
                          child: Stack(
                            fit: StackFit.passthrough,
                            children: [
                              Opacity(
                                opacity: 1 - progress,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Text("Get Started"),
                                ),
                              ),
                              Opacity(
                                opacity: progress,
                                child: TextButton(
                                  onPressed: _isLoading ? null : _onLoginButtonPressed,
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.alike(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 24,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            cursorColor: Colors.purple,
            onChanged: (value) => _email = value,
            style: TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: "test@gmail.com",
              hintStyle: TextStyle(color: Colors.blueGrey.shade100),
              labelText: "Enter Your Email Address",
              labelStyle: TextStyle(color: Colors.blueGrey.shade100),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            cursorColor: Colors.purple,
            onChanged: (value) => _password = value,
            style: TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
            keyboardType: TextInputType.visiblePassword,
            obscureText: visible,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: "Enter Your Password",
              labelStyle: TextStyle(color: Colors.blueGrey.shade100),
              suffixIcon: IconButton(
                onPressed: _togglePasswordVisibility,
                icon: visible
                    ? Icon(Icons.visibility_outlined, color: Colors.white)
                    : Icon(Icons.visibility_off_outlined, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('reset password');
              },
              child: Text(
                "Forgot password?",
                style: GoogleFonts.alike(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
