import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WaterReminder extends StatefulWidget {
  const WaterReminder({Key? key}) : super(key: key);

  @override
  State<WaterReminder> createState() => _WaterReminderState();
}

class _WaterReminderState extends State<WaterReminder> with SingleTickerProviderStateMixin {
  int _waterIntake = 0;
  List<int> _waterIntakeList = [];
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    loadWaterIntake();

    // Circular Animation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
    _animation = Tween(begin: 0.0, end: 2 * 3.14159).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadWaterIntake() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          setState(() {
            _waterIntake = doc['waterIntake'] ?? 0;
            _waterIntakeList = (doc['waterIntakeList'] as List<dynamic>?)
                ?.map((e) => e as int)
                .toList() ?? [];
          });
        }
      } catch (e) {
        print('Error loading water intake data: $e');
        // Optionally, handle error by showing a message to the user
      }
    }
  }

  Future<void> _saveWaterIntake() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'waterIntake': _waterIntake,
          'waterIntakeList': _waterIntakeList,
        });
      } catch (e) {
        print('Error saving water intake data: $e');
        // Optionally, handle error by showing a message to the user
      }
    }
  }

  void _incrementWaterIntake() {
    setState(() {
      _waterIntake += 200;
      _waterIntakeList.add(200);
      _saveWaterIntake();
    });
  }

  void _resetWaterIntake() {
    setState(() {
      _waterIntake = 0;
      _waterIntakeList.clear();
      _saveWaterIntake();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildWaterIntakeIndicator(),
              SizedBox(height: 20),
              _buildWaterIntakeList(),
              SizedBox(height: 20),
              _buildResetButton(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
            width: 35,
          ),
          Text(
            'Water Reminder',
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
    );
  }

  Widget _buildWaterIntakeIndicator() {
    return Container(
      width: 335,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: _incrementWaterIntake,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: CircularProgressIndicator(
                value: _waterIntake / 2500, // Adjust max value as needed
                strokeWidth: 20,
                color: Colors.purple,
                backgroundColor: Colors.black12,
              ),
            ),
            Container(
              width: 200,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Column(
                  children: [
                    Text(
                      '   Daily Drink Goal\n              2500\n-----------------',
                      style: GoogleFonts.alike(
                          fontSize: 21, color: Colors.purple),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Text(
                      '   $_waterIntake ml ',
                      style: GoogleFonts.alike(
                          fontSize: 27,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterIntakeList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _waterIntakeList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              child: Container(
                height: 60,
                width: 330,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    " +200 ml ",
                    style: GoogleFonts.alike(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  _waterIntake -= _waterIntakeList[index];
                  _waterIntakeList.removeAt(index);
                  _saveWaterIntake();
                });
              },
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.purple,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResetButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 50,
        width: 150,
        child: ElevatedButton(
          onPressed: _resetWaterIntake,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            "Reset",
            style: GoogleFonts.alike(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
