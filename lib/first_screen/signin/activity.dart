import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Goal extends StatefulWidget {
  const Goal({Key? key}) : super(key: key);

  @override
  State<Goal> createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  bool select = false;
  bool select_1 = false;
  bool select_2 = false;
  String activity = "";

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
                ]),
              ),
              // Add more icons as needed for the number of choices
            ]),
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 10),
              child: Text(
                "Your Activity ",
                style: GoogleFonts.alike(fontSize: 40.0, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: SizedBox(
                height: 75,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      select = true;
                      select_1 = false;
                      select_2 = false;
                      activity = "less active";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        select == false ? Colors.white10 : Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Less Active',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SizedBox(
                height: 75,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      select = false;
                      select_1 = true;
                      select_2 = false;
                      activity = "normal active";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        select_1 == false ? Colors.white10 : Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Normal Active',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SizedBox(
                height: 75,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      select = false;
                      select_1 = false;
                      select_2 = true;
                      activity = "very active";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        select_2 == false ? Colors.white10 : Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Very Active',
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 80.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          color: Colors.purple,
                        ),
                        width: 130.0,
                        child: SizedBox(
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
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
                    padding: const EdgeInsets.only(right: 18.0, top: 80.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        color: Colors.purple,
                      ),
                      width: 130.0,
                      child: SizedBox(
                        child: MaterialButton(
                          onPressed: () async {
                            if (select || select_1 || select_2) {
                              await addActivityToFirestore(activity);
                              Navigator.of(context).pushNamed("body_fat");
                            }
                          },
                          child: const Text(
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addActivityToFirestore(String activity) async {
    try {
      // Get current user
      User? user = _auth.currentUser;
      if (user != null) {
        // Add activity along with user ID to Firestore
        await usersCollection.doc(user.uid).set(
            {
              'activity': activity,
            },
            SetOptions(
                merge:
                    true)); // Merge option to avoid overwriting existing data
        print('Activity added to Firestore: $activity');
      } else {
        print('User is not logged in!');
      }
    } catch (e) {
      print('Error adding activity to Firestore: $e');
    }
  }
}
