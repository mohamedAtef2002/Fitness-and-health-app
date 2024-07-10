import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Age extends StatefulWidget {
  const Age({Key? key});

  @override
  State<Age> createState() => _AgeState();
}

class _AgeState extends State<Age> {
  int _integerValue = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          Container(
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
                  padding: EdgeInsets.only(top: 40.0, left: 20),
                  child: Text(
                    "Your Age ",
                    style: GoogleFonts.alike(fontSize: 40.0, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140),
                  child: Container(
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NumberPicker(
                        value: _integerValue,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border(
                            bottom: BorderSide(color: Colors.white),
                            top: BorderSide(color: Colors.white),
                            left: BorderSide(color: Colors.white),
                            right: BorderSide(color: Colors.white),
                          ),
                        ),
                        textStyle: TextStyle(fontSize: 25, color: Colors.black),
                        selectedTextStyle: TextStyle(color: Colors.white, fontSize: 40),
                        minValue: 0,
                        maxValue: 99,
                        onChanged: (newValue) {
                          setState(() {
                            _integerValue = newValue;
                          });
                        },
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
                              int finalValue = _integerValue;
                              print('Final Value: $finalValue');
                              if(finalValue > 0) {
                                // Add age along with user ID to Firestore
                                await addAgeToFirestore(finalValue);
                                Navigator.of(context).pushNamed("weight");
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
        ]),
      ),
    );
  }

  // Add age along with user ID to Firestore
  Future<void> addAgeToFirestore(int age) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await usersCollection.doc(user.uid).set({
          'age': age,
        }, SetOptions(merge: true)); // Merge option to avoid overwriting existing data
        print('Age added to Firestore: $age');
      } else {
        print('User is not logged in!');
      }
    } catch (e) {
      print('Error adding age to Firestore: $e');
    }
  }
}
