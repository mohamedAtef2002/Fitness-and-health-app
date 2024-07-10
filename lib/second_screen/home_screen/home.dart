import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/Community/community.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/FoodSystem/food_system.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/Model/model.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/show_exercise/show_exercise.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'exercise_screen/exercise.dart';
import 'package:firebase_auth/firebase_auth.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int currentIndex = 0;
  String _pageData = '';
  late PageController _pageController;
  List<Widget> screens = [
    HomeScreen(),
    FoodSystem(),
    ShowExercise(),
    ModelScreen(),
    Community(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
    _loadPageData();
    
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  void _loadPageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pageData = prefs.getString('page_$currentIndex') ?? '';
    });
  }

  void _savePageData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('page_$currentIndex', data);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: PageView(
        controller: _pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        animationDuration: Duration(milliseconds: 500),
        backgroundColor: Colors.black12,
        color: Colors.white,
        index: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            _savePageData('Data for Page $currentIndex');
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 100),
              curve: Curves.ease,
            );
          });
        },
        items: [
          const ImageIcon(
            AssetImage("assets/images/home_icon.png"),
            size: 30,
            color: Colors.black,
          ),
          const ImageIcon(
            AssetImage("assets/images/foodsystemicon.png"),
            size: 31,
          ),
          const ImageIcon(AssetImage("assets/images/exercise_icon.png"),
              size: 40),
          const Icon(
            Icons.model_training_outlined,
            size: 30,
          ),
          const Icon(
            Icons.groups,
            size: 29,
          ),
        ],
      ),
    );
  }
}
