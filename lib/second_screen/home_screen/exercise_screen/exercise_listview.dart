import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Exercise_listview extends StatefulWidget {
  const Exercise_listview({Key? key}) : super(key: key);

  @override
  State<Exercise_listview> createState() => _Exercise_listviewState();
}

class _Exercise_listviewState extends State<Exercise_listview> {
  Map<String, dynamic> exercisePlan = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? exercisePlanString = prefs.getString('exercise_plan');

    setState(() {
      if (exercisePlanString != null) {
        exercisePlan = jsonDecode(exercisePlanString);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: exercisePlan.length, // Number of horizontal items
        itemBuilder: (context, index) {
          String dayName = exercisePlan.keys.elementAt(index);
          Map<String, dynamic> muscleGroups = exercisePlan[dayName];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80,top: 10),
                      child: Text(
                        "Today's Workout",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                dayName,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                muscleGroups.keys.elementAt(0),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        width: 320,
                        decoration: BoxDecoration(
                          color: Colors.white24.withOpacity(0.13),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount:
                          muscleGroups.values.elementAt(0).length, // Number of vertical items
                          itemBuilder: (context, exerciseIndex) {
                            String exerciseKey = muscleGroups.values
                                .elementAt(0)
                                .keys
                                .elementAt(exerciseIndex);
                            Map<String, dynamic> exerciseDetails =
                            muscleGroups.values.elementAt(0)[exerciseKey];
                            String exerciseName = exerciseDetails['Name'];
                            String description =
                            exerciseDetails['Description'];

                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.zero,
                                  leading: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(Icons.navigate_before,
                                        color: Colors.white),
                                  ),
                                  title: Text(
                                    exerciseName,
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Description: ",
                                            style: GoogleFonts.actor(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Text(
                                                description,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                                softWrap: true,
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
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
