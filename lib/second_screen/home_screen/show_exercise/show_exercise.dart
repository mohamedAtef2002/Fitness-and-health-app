import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowExercise extends StatefulWidget {
  const ShowExercise({Key? key}) : super(key: key);

  @override
  State<ShowExercise> createState() => _ShowExerciseState();
}

class _ShowExerciseState extends State<ShowExercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("chest");
                  },
                  child: Container(
                    height: 140,
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage("assets/images/chest/chest.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Chest",
                        style: GoogleFonts.alike(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("back");
                  },
                  child: Container(
                    height: 140,
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage("assets/images/back/back.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Back",
                        style: GoogleFonts.alike(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("shoulder");
                  },
                  child: Container(
                    height: 140,
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage("assets/images/shoulder/shoulder.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Shoulder",
                        style: GoogleFonts.alike(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("arm");
                  },
                  child: Container(
                    height: 140,
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage("assets/images/arm/arm.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Arm",
                        style: GoogleFonts.alike(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("legs");
                  },
                  child: Container(
                    height: 140,
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage("assets/images/legs/legs.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Legs",
                        style: GoogleFonts.alike(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
