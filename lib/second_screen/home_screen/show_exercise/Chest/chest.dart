import 'package:fitness_and_healty_app/second_screen/home_screen/show_exercise/exercises_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chest extends StatefulWidget {
  const Chest({Key? key}) : super(key: key);

  @override
  State<Chest> createState() => _ChestState();
}

class _ChestState extends State<Chest> {
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
            Text('Chest',style: GoogleFonts.alike(
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
              ExercisesCard(image: "assets/images/chest/chest_1.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/chest/chest_2.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/chest/chest_3.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/chest/chest_8.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/chest/chest_5.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/chest/chest_6.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/chest/chest_7.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/chest/chest_4.gif"),
              SizedBox(height: 25,),
              ExercisesCard(image: "assets/images/chest/chest_9.gif"),
            ],
          ),
        ),
      ]),
    );
  }
}
