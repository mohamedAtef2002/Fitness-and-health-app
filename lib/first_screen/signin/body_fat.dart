import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../login_screen/login_screen.dart';

class BodyFat extends StatefulWidget {
  const BodyFat({Key? key}) : super(key: key);

  @override
  State<BodyFat> createState() => _BodyFatState();
}

class _BodyFatState extends State<BodyFat> {
  int _integerValue = 0;
  int _decimalValue = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

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
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 50.0),
                    child: Container(
                      child: IconButton(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      child: IconButton(
                        iconSize: 10.0,
                        color: Colors.purple,
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
              padding: EdgeInsets.only(top: 40.0),
              child: Text(
                "Your Body Fat ",
                style: GoogleFonts.alike(fontSize: 40.0, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 140),
              child: Container(
                  width: 230,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
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
                                bottom: BorderSide(
                                  color: Colors.white,
                                ),
                                top: BorderSide(
                                  color: Colors.white,
                                ),
                                left: BorderSide(
                                  color: Colors.white,
                                ),
                              )),
                          textStyle:
                              TextStyle(fontSize: 25, color: Colors.black),
                          selectedTextStyle:
                              TextStyle(color: Colors.white, fontSize: 40),
                          minValue: 0,
                          maxValue: 999,
                          onChanged: (newValue) {
                            setState(() {
                              _integerValue = newValue;
                            });
                          },
                        ),
                        //SizedBox(width: 10),
                        Container(
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                              ),
                              top: BorderSide(
                                color: Colors.white,
                              ),
                            )),
                            child: Text('.',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white))),

                        NumberPicker(
                          value: _decimalValue,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                ),
                                top: BorderSide(
                                  color: Colors.white,
                                ),
                                right: BorderSide(
                                  color: Colors.white,
                                ),
                              )),
                          textStyle:
                              TextStyle(fontSize: 25, color: Colors.black),
                          selectedTextStyle:
                              TextStyle(color: Colors.white, fontSize: 40),
                          minValue: 0,
                          maxValue: 99,
                          onChanged: (newValue) {
                            setState(() {
                              _decimalValue = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  )),
            ),
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 200.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        color: Colors.purple,
                      ),
                      width: 130.0,
                      child: SizedBox(
                          child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("activity");
                        },
                        child: const Text(
                          "Back",
                          style: TextStyle(fontSize: 25.0),
                        ),
                        textColor: Colors.white,
                      )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 62,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0, top: 200.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      color: Colors.purple,
                    ),
                    width: 130.0,
                    child: SizedBox(
                        child: MaterialButton(
                      onPressed: () async {
                        double finalValue =
                            _integerValue + (_decimalValue / 100);
                        if (finalValue > 0) {
                          await addBodyFatToFirestore(finalValue);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  login_screen(),
                            ),
                                (route) => false,
                          );
                        }
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      textColor: Colors.white,
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addBodyFatToFirestore(double bodyFat) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await usersCollection.doc(user.uid).set({
          'bodyFat': bodyFat,
        }, SetOptions(merge: true));
        print('Body fat added to Firestore: $bodyFat');
      } else {
        print('User is not logged in!');
      }
    } catch (e) {
      print('Error adding body fat to Firestore: $e');
    }
  }
}
