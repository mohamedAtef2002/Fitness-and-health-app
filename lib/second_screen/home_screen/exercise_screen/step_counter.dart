import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepCounter extends StatefulWidget {
  const StepCounter({Key? key}) : super(key: key);

  @override
  State<StepCounter> createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  int _stepCount = 0;
  bool _isStepDetected = false;
  double _accelerometerThreshold = 14;
  double _gyroscopeThreshold = 15;
  List<double> _accelerometerValues = [0, 0, 0];
  List<double> _gyroscopeValues = [0, 0, 0];
  List<double> _filteredAccelerometerValues = [0, 0, 0];
  List<double> _filteredGyroscopeValues = [0, 0, 0];
  final int _filterSize = 15;

  @override
  void initState() {
    super.initState();
    _loadStepCount();

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
        _filteredAccelerometerValues =
            _applyMovingAverageFilter(_accelerometerValues);
        _detectStep();
      });
    });

    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
        _filteredGyroscopeValues = _applyMovingAverageFilter(_gyroscopeValues);
        _detectStep();
      });
    });
  }

  Future<void> _loadStepCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _stepCount = prefs.getInt('stepCount') ?? 0;
    });
  }

  List<double> _applyMovingAverageFilter(List<double> values) {
    if (values.isEmpty) {
      return values;
    }
    if (values.length != _filterSize) {
      return values;
    }
    List<double> filteredValues = List<double>.filled(values.length, 0);
    for (int i = 0; i < values.length; i++) {
      filteredValues[i] = values.sublist(0, i + 1).reduce((a, b) => a + b) /
          (i + 1);
    }
    return filteredValues;
  }

  void _detectStep() async {
    double accelerometerMagnitude = _calculateMagnitude(_filteredAccelerometerValues);
    double gyroscopeMagnitude = _calculateMagnitude(_filteredGyroscopeValues);

    if (!_isStepDetected &&
        accelerometerMagnitude > _accelerometerThreshold &&
        gyroscopeMagnitude > _gyroscopeThreshold) {
      setState(() async {
        _isStepDetected = true;
        _stepCount++;
        await _saveStepCount();
      });
    } else if (_isStepDetected &&
        (accelerometerMagnitude < _accelerometerThreshold ||
            gyroscopeMagnitude < _gyroscopeThreshold)) {
      setState(() {
        _isStepDetected = false;
      });
    }
  }

  Future<void> _saveStepCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('stepCount', _stepCount);

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'stepCount': _stepCount});
    }
  }

  double _calculateMagnitude(List<double> values) {
    return values.fold(0, (previous, current) => previous + current.abs());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 400,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Step Count:',
                      style: GoogleFonts.alike(
                          fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '$_stepCount',
                      style: GoogleFonts.alike(
                        fontSize: 50, color: Colors.white,),
                    ),
                  ],
                ),
                SizedBox(width: 70),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pedestrian Status',
                      style: GoogleFonts.alike(
                          fontSize: 17, color: Colors.white),
                    ),
                    SizedBox(height: 6,),
                    Icon(
                      _isStepDetected ? Icons.directions_walk : Icons.accessibility_new,
                      size: 90,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6,),
                    Text(
                      _isStepDetected ? "walking" : "stopped",
                      style: GoogleFonts.alike(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
