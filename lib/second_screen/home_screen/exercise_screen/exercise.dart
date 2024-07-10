import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/exercise_screen/step_counter.dart';
import 'package:fitness_and_healty_app/userData.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'exercise_listview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<double> currentWeights = [90, 85, 80, 82, 75, 71, 68];
  UserData _userData = UserData();
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '', _steps = '0';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      await _userData.loadUserData();
      setState(() {});
    } catch (e) {
      print('Error loading user data: $e');
      // Optionally, handle error by showing a message to the user
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Handler for step count updates
  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
      _updateStepCountInFirestore(event.steps);
    });
  }

  // Function to update step count in Firestore
  Future<void> _updateStepCountInFirestore(int steps) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'steps': steps});
        print('User data successfully updated');
      } else {
        print('User not logged in');
      }
    } catch (e) {
      print('Error updating step count in Firestore: $e');
      // Handle error as needed
    }
  }

  // Handler for pedestrian status updates
  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  // Error handler for pedestrian status stream
  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  // Error handler for step count stream
  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  // Initialize pedometer streams
  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream.listen(onPedestrianStatusChanged, onError: onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount, onError: onStepCountError);

    if (!mounted) return;
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');

      // Navigate back to the login screen and remove all other routes
      Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to logout: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 260,
      width: double.infinity,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderRow(),
            SizedBox(height: 58),
            _buildHeaderTitle(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildProfilePicture(),
          SizedBox(width: 50),
          Text(
            "Exercise",
            style: GoogleFonts.alike(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 40),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await _logout(context);
            },
            icon: Icon(
              Icons.logout,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("profile");
      },
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            image: _userData.imageUrl.isNotEmpty
                ? NetworkImage(_userData.imageUrl)
                : AssetImage('assets/images/profile1.png') as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Find Your",
          style: GoogleFonts.roboto(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 2),
        Text(
          "Best Exercise",
          style: GoogleFonts.roboto(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 15),
          _status.isEmpty ? StepCounter() : _buildStepCounter(),
          SizedBox(height: 20),
          _buildHorizontalScrollSection(),
          SizedBox(height: 30),
          Exercise_listview(), // Use the ExerciseListView widget
          SizedBox(height: 40),
          Text(
            "Weight Chart",
            style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 15),
          _buildWeightChart(),
        ],
      ),
    );
  }

  Widget _buildStepCounter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 400,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Steps Taken',
                    style: GoogleFonts.alike(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _steps,
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(width: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pedestrian Status',
                    style: GoogleFonts.alike(fontSize: 17, color: Colors.white),
                  ),
                  Icon(
                    _status == 'walking'
                        ? Icons.directions_walk
                        : _status == 'stopped'
                        ? Icons.accessibility_new
                        : Icons.error,
                    size: 90,
                    color: Colors.white,
                  ),
                  Text(
                    _status,
                    style: _status == 'walking' || _status == 'stopped'
                        ? TextStyle(fontSize: 20)
                        : TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalScrollSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            _buildCard("bmi", "assets/images/bmi_2.jpg"),
            SizedBox(width: 15),
            _buildCard("water_reminder", "assets/images/water_reminder.png"),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String routeName, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Container(
        height: 150,
        width: 330,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            filterQuality: FilterQuality.low,
            image: AssetImage(imagePath),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildWeightChart() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 300,
        width: 330,
        color: Colors.white,
        child: Center(
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: _getSpots(currentWeights),
                  isCurved: true,
                  colors: [Colors.purple],
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
              minY: 40,
              titlesData: FlTitlesData(
                leftTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(show: true),
              gridData: FlGridData(show: false),
            ),
          ),
        ),
      ),
    );
  }

  // Function to convert weights to FlSpot
  List<FlSpot> _getSpots(List<double> weights) {
    List<FlSpot> spots = [];
    for (int i = 0; i < weights.length; i++) {
      spots.add(FlSpot(i.toDouble(), weights[i]));
    }
    return spots;
  }
}
