import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Third_Screen extends StatelessWidget {
  const Third_Screen({super.key});

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          width: double.infinity,
          height: double.infinity,
          child: const Image(
            image: AssetImage("assets/images/third.png"),
            filterQuality: FilterQuality.low,
            fit: BoxFit.cover,
          )),
       Padding(
        padding: EdgeInsets.only(top: 320.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                "  Regular physical activity can improve your \n"
                "  muscle strength and boost your endurance.\n"
                "  Exercise delivers oxygen and nutrients to \n"
                "  you tissues and helps your cardiovascular \n"
                "           system work more efficiently.",
                style: GoogleFonts.akayaKanadaka(
                    color: Colors.white70,
                    fontWeight: FontWeight.w800,
                    fontSize: 19.0),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
        child: IconButton(
          iconSize: 35.0,
          color: Colors.purple,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed("secound_screen");
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 280.0, top: 20.0),
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
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 130.0, top: 587.0),
                child: Container(
                  child: IconButton(
                    iconSize: 10.0,
                    color: Colors.white,
                    icon: const Icon(Icons.circle),
                    onPressed: () {
                      Navigator.of(context).pushNamed("secound_screen");
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 587.0),
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
            SizedBox(height: 15,),
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, top: 0,bottom: 5.0,),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  color: Colors.purple,
                ),
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("login");
                  },
                  child: Text(
                    "Next",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]));
  }
}
