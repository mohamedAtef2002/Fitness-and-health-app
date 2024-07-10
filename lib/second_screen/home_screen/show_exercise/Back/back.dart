import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../exercises_card.dart';

class Back extends StatefulWidget {
  const Back({Key? key}) : super(key: key);

  @override
  State<Back> createState() => _BackState();
}

class _BackState extends State<Back> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed("home");
                },
                icon: Icon(Icons.navigate_before_outlined,size: 30,),color: Colors.white,),
            ),SizedBox(width: 80,),
            Text('Back',style: GoogleFonts.alike(
              fontWeight: FontWeight.w600,
              fontSize: 30,
              color: Colors.white,
              //fontStyle: FontStyle.italic,
            ),)
          ],
        ),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ExercisesCard(image: "assets/images/back/back_1.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/back/back_2.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/back/back_3.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/back/back_4.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/back/back_5.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/back/back_6.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/back/back_7.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/back/back_8.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/back/back_9.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/back/back_10.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/back/back_11.gif"),
            ],
          ),
        ),
      ]),
    );
  }
}
