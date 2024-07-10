import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const First_screen());
}

class First_screen extends StatelessWidget {
  const First_screen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/12.png",
            filterQuality: FilterQuality.low,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 500.0, left: 30.0),
                  child: Text(
                    "Welcome To",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    "Master Coach",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 20.0, left: 30.0),
                  child: Text(
                    "the best diet & fitness app to achieve your goal",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    top: 10,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      color: Colors.purple,
                    ),
                    width: double.infinity,
                    height: 60,
                    child: SizedBox(
                        child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("secound_screen");
                      },
                      child: Text(
                        "Let's go",
                        style: GoogleFonts.alike(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w800),
                      ),
                    )),
                  ),

                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
