import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Weight extends StatefulWidget {
  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  int _integerValue = 0;
  int _decimalValue = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row( children:[


                  Padding(
                    padding:  const EdgeInsets.only(left:40.0,top:50.0),
                    child: Container(

                      child:IconButton(
                        iconSize: 10.0,
                        color: Colors.white,
                        icon: const Icon(Icons.circle),
                        onPressed: () {},

                      ),
                    ),


                  ),
                  Padding(
                    padding:  const EdgeInsets.only(top:50.0),
                    child: Container(

                      child:IconButton(
                        iconSize: 10.0,
                        color: Colors.white,
                        icon: const Icon(Icons.circle),
                        onPressed: () {},
                      ),
                    ),


                  ),
                  Padding(
                    padding:  const EdgeInsets.only(top:50.0),
                    child: Container(

                      child:IconButton(
                        iconSize: 10.0,
                        color: Colors.purple,
                        icon: const Icon(Icons.circle),
                        onPressed: () {},
                      ),
                    ),


                  ),
                  Padding(
                    padding:  const EdgeInsets.only(top:50.0),
                    child: Container(

                      child:IconButton(
                        iconSize: 10.0,
                        color: Colors.white,
                        icon: const Icon(Icons.circle),
                        onPressed: () {},
                      ),
                    ),


                  ),
                  Padding(
                    padding:  const EdgeInsets.only(top:50.0),
                    child: Container(

                      child:IconButton(
                        iconSize: 10.0,
                        color: Colors.white,
                        icon: const Icon(Icons.circle),
                        onPressed: () {},
                      ),
                    ),


                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      child: IconButton(
                        iconSize: 10.0,
                        color: Colors.white,
                        icon: const Icon(Icons.circle),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ]),
              ),
              // Add more icons as needed for the number of choices
            ]),


            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 10),
              child: Text(
                "Your Weight ",
                style: GoogleFonts.alike(fontSize: 40.0, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 140, left: 12),
              child: Container(
                width: 290,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberPicker(
                        value: _integerValue,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          border: Border(
                            bottom: BorderSide(color: Colors.white),
                            top: BorderSide(color: Colors.white),
                            left: BorderSide(color: Colors.white),
                          ),
                        ),
                        textStyle: TextStyle(fontSize: 25, color: Colors.black),
                        selectedTextStyle: TextStyle(color: Colors.white, fontSize: 40),
                        minValue: 0,
                        maxValue: 999,
                        onChanged: (newValue) {
                          setState(() {
                            _integerValue = newValue;
                          });
                        },
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border(
                            bottom: BorderSide(color: Colors.white),
                            top: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text(
                          '.',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                      NumberPicker(
                        value: _decimalValue,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          border: Border(
                            bottom: BorderSide(color: Colors.white),
                            top: BorderSide(color: Colors.white),
                            right: BorderSide(color: Colors.white),
                          ),
                        ),
                        textStyle: TextStyle(fontSize: 25, color: Colors.black),
                        selectedTextStyle: TextStyle(color: Colors.white, fontSize: 40),
                        minValue: 0,
                        maxValue: 99,
                        onChanged: (newValue) {
                          setState(() {
                            _decimalValue = newValue;
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Kg",
                        style: GoogleFonts.alike(fontSize: 27, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 200.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.purple,
                      ),
                      width: 130.0,
                      child: SizedBox(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(fontSize: 25.0),
                          ),
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 62,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0, top: 200.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.purple,
                    ),
                    width: 130.0,
                    child: SizedBox(
                      child: MaterialButton(
                        onPressed: () async {
                          double finalValue = _integerValue + (_decimalValue / 100);
                          print('Final Value: $finalValue');
                          if(finalValue > 0) {
                            // Add weight along with user ID to Firestore
                            await addWeightToFirestore(finalValue);
                            Navigator.of(context).pushNamed("height");
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 25.0),
                        ),
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Add weight along with user ID to Firestore
  Future<void> addWeightToFirestore(double weight) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await usersCollection.doc(user.uid).set({
          'weight': weight,
        }, SetOptions(merge: true)); // Merge option to avoid overwriting existing data
        print('Weight added to Firestore: $weight');
      } else {
        print('User is not logged in!');
      }
    } catch (e) {
      print('Error adding weight to Firestore: $e');
    }
  }
}
