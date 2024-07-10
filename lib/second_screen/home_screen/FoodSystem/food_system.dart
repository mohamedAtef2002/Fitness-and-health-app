import 'package:fitness_and_healty_app/second_screen/home_screen/FoodSystem/breakfast.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/FoodSystem/dinner.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/FoodSystem/lunch.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/FoodSystem/snack.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodSystem extends StatefulWidget {
  const FoodSystem({Key? key}) : super(key: key);

  @override
  State<FoodSystem> createState() => _FoodSystemState();
}

class _FoodSystemState extends State<FoodSystem> {
  List<double> currentBodyFat = [25, 22.3, 19.8, 15.8, 11.3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "Food System",
                style: GoogleFonts.alike(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 14, left: 14, top: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("calories");
                      },
                      child: Container(
                        height: 150,
                        width: 330,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            filterQuality: FilterQuality.low,
                            image: AssetImage("assets/images/calories.png"),
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("SearchFoodSystem");
                        },
                        child: Container(
                          height: 150,
                          width: 330,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.low,
                              image:
                                  AssetImage("assets/images/food_calories.png"),
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Breakfast(),
            SizedBox(
              height: 20,
            ),
            Lunch(),
            SizedBox(
              height: 20,
            ),
            Dinner(),
            SizedBox(
              height: 20,
            ),
            Snak(),
            SizedBox(
              height: 40,
            ),
            Text(
              "Body Fat Chart",
              style: GoogleFonts.aBeeZee(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 300,
                width: 330,
                color: Colors.white,
                child: Center(
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: _getSpots(currentBodyFat),
                          isCurved: true,
                          colors: [Colors.purple],
                          barWidth: 4,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                      minY: 0,
                      titlesData: FlTitlesData(
                        leftTitles: SideTitles(showTitles: false),
                        bottomTitles: SideTitles(showTitles: false),
                      ),
                      borderData: FlBorderData(show: true),
                      gridData: FlGridData(show: false),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to convert body fat to FlSpot
  List<FlSpot> _getSpots(List<double> bodyFat) {
    List<FlSpot> spots = [];
    for (int i = 0; i < bodyFat.length; i++) {
      spots.add(FlSpot(i.toDouble(), bodyFat[i]));
    }
    return spots;
  }
}
