import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Female extends StatefulWidget {
  const Female({super.key});

  @override
  State<Female> createState() => _FemaleState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

class _FemaleState extends State<Female> {
  Color ontap = Colors.white10;
  bool select = false;
  bool select_1 = false;
  String gender = "";
  String profileImageUrl = "";
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 50.0),
                    child: Container(
                      child: IconButton(
                        iconSize: 10.0,
                        color: Colors.purple,
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
                        color: Colors.white,
                        icon: const Icon(Icons.circle),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Your Gender",
                style: GoogleFonts.alike(fontSize: 32, color: Colors.white),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      select = !select;
                      select_1 = false;
                      gender = "male";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          select == false ? Colors.white10 : Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Image(
                          image: AssetImage('assets/images/male.png'),
                          height: 100,
                          width: 50,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Male",
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      select_1 = !select_1;
                      select = false;
                      gender = "female";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          select_1 == false ? Colors.white10 : Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Image(
                          image: AssetImage('assets/images/Female (2).png'),
                          width: 100,
                          height: 110,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Female",
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 50.0, right: 50.0, top: 70.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    color: Colors.purple,
                  ),
                  width: double.infinity,
                  child: SizedBox(
                      child: MaterialButton(
                    onPressed: () async {
                      if (select == true || select_1 == true) {
                        Navigator.of(context).pushNamed("age");
                      }
                      ;
                      print(gender);
                      await addGenderToFirestore(gender,profileImageUrl);
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 30.0),
                    ),
                    textColor: Colors.white,
                  )),
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }

  Future<void> addGenderToFirestore(String gender , String profileImageUrl) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await usersCollection.doc(user.uid).set({
          'gender': gender,
                    'profileImageUrl': profileImageUrl,

        }, SetOptions(merge: true));
        print('Gender added to Firestore: $gender');
      } else {
        print('User is not logged in!');
      }
    } catch (e) {
      print('Error adding gender to Firestore: $e');
    }
  }
}
