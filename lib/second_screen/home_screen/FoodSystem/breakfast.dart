import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Breakfast extends StatefulWidget {
  const Breakfast({Key? key}) : super(key: key);

  @override
  State<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  Map<String, dynamic> dietPlan = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dietPlanString = prefs.getString('diet_plan');

    setState(() {
      if (dietPlanString != null) {
        dietPlan = jsonDecode(dietPlanString);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload data when the dependencies change (like when popping a route)
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (dietPlan.isEmpty || !dietPlan.containsKey('Breakfast')) {
      return Center(child: Text("No data available"));
    }

    var breakfastData = dietPlan["Breakfast"];

    return SizedBox(
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: breakfastData.length, // Number of days
        itemBuilder: (context, index) {
          String day = breakfastData.keys.elementAt(index);
          Map<String, dynamic> meals = breakfastData[day];

          return Padding(
            padding:
            const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  children: [
                    Text(
                      "Today's Food System",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 20,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              day,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 100),
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Breakfast",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                          itemCount: meals.length, // Number of meals
                          itemBuilder: (context, mealIndex) {
                            String mealKey = meals.keys.elementAt(mealIndex);
                            String meal = meals[mealKey];
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: IntrinsicHeight(
                                child: IntrinsicWidth(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.purple,
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            child: Icon(Icons.navigate_before,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 20),
                                          Expanded(
                                            child: Text(
                                              meal,
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
