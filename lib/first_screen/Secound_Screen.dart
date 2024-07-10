import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Secound_Screen extends StatelessWidget {
  const Secound_Screen({super.key});

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Image.asset(
          height: double.infinity,
          width: double.infinity,
          "assets/images/Secound.png",
          filterQuality: FilterQuality.low,
          fit: BoxFit.cover,
        ),
      ),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 270.0, top: 15.0),
            child: TextButton(
              child: const Text(
                "Skip",
                style: TextStyle(fontSize: 25.0, color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("login");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 65),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 480.0,
                      alignment: Alignment.center,
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "  Eating well is fundamental to good health\n"
                          "    and well-being. Healthy eating helps us \n"
                          "   to maintain healthy weight and "
                              "reduces \n"
                          "                our risk of type 2 diabetes.",
                          style: GoogleFonts.akayaKanadaka(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                              fontSize: 19.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 130.0, top: 40.0),
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
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                child: IconButton(
                  iconSize: 10.0,
                  color: Colors.white,
                  icon: const Icon(Icons.circle),
                  onPressed: () {
                    Navigator.of(context).pushNamed("third_screen");
                  },
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 15,
              bottom: 10.0,
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                color: Colors.purple,
              ),
              width: double.infinity,

              child: MaterialButton(
                              onPressed: () {
              Navigator.of(context).pushNamed("third_screen");
                              },
                child: Text(
                  "Next",

              style: TextStyle(

                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
                              ),
                            ),
            ),
          ),
        ],
      ),
    ]));
  }
}
