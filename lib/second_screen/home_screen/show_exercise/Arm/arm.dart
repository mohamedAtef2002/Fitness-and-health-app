import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../exercises_card.dart';

class Arm extends StatefulWidget {
  const Arm({Key? key}) : super(key: key);

  @override
  State<Arm> createState() => _ArmState();
}

class _ArmState extends State<Arm> {
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
            Text('Arms',style: GoogleFonts.alike(
              fontWeight: FontWeight.w600,
              fontSize: 30,
              color: Colors.white,
              //fontStyle: FontStyle.italic,
            ),)
          ],
        ),
      ),
      body: ListView(
          children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ExercisesCard(image: "assets/images/arm/arm_1.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_2.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_3.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_4.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_5.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_6.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_7.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_8.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_9.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_10.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_11.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_12.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_13.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_14.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_15.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_16.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_17.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_18.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/arm/arm_19.gif"),
            ],
          ),
        ),
      ]),
    );
  }
}
