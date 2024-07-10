import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Api.dart';
import 'Food.dart';
import 'package:pie_chart/pie_chart.dart';

class SearchFoodCalories extends StatefulWidget {
  @override
  _ContentViewState createState() => _ContentViewState();
}

class _ContentViewState extends State<SearchFoodCalories> {
  List<Food> foods = [];
  String query = '';
  bool show = false;
  bool showChart = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getNutrition() async {
    setState(() {
      isLoading = true;
    });
    try {
      final List<Food> fetchedFoods = await ApiService.fetchData(query);
      setState(() {
        foods = fetchedFoods;
        show = true;
        showChart = true;
        isLoading = false;
      });
      // Print the fetched data to console for verification
      print('Data fetched: ${foods.length}');
      for (var food in foods) {
        print(food.name);
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("home");
              },
              icon: Icon(
                Icons.navigate_before_outlined,
                size: 30,
              ),
              color: Colors.white,
            ),
            SizedBox(width: 40),
            Text(
              'Food Calories',
              style: GoogleFonts.alike(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        elevation: 20,
        shadowColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 70, right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                labelText: "Search Food Calories",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black54),
                ),
                labelStyle: TextStyle(color: Colors.blueGrey.shade200),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 60,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  getNutrition();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Get',
                  style: GoogleFonts.alike(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            if (isLoading)
              Center(child: CircularProgressIndicator()),
            if (show && !isLoading)
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 650,
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  if (showChart)
                                    PieChart(
                                      dataMap: {
                                        'Calories': foods[index].calories,
                                        'Fat': foods[index].fatTotalG,
                                        'Protein': foods[index].proteinG,
                                        'Sodium': foods[index].sodiumMg,
                                        'Potassium': foods[index].potassiumMg,
                                        'Cholesterol': foods[index].cholesterolMg,
                                        'Carbohydrates': foods[index].carbohydratesTotalG,
                                        'Fiber': foods[index].fiberG,
                                        'Sugar': foods[index].sugarG,
                                      },
                                      colorList: [
                                        Colors.grey,
                                        CupertinoColors.destructiveRed,
                                        Colors.deepPurple,
                                        Colors.blue,
                                        Colors.yellow,
                                        Colors.deepOrange,
                                        Colors.brown,
                                        Colors.lightGreen,
                                        Colors.blueGrey,
                                      ],
                                      chartRadius: 800,
                                      animationDuration: Duration(milliseconds: 1200),
                                      chartValuesOptions: ChartValuesOptions(
                                        showChartValueBackground: false,
                                        showChartValues: false,
                                      ),
                                      chartType: ChartType.ring,
                                    ),
                                  SizedBox(height: 40),
                                  buildNutritionRow('Food : ', foods[index].name),
                                  buildNutritionRow('Calories : ', '${foods[index].calories}'),
                                  buildNutritionRow('Serving Size : ', '${foods[index].servingSizeG} g'),
                                  buildNutritionRow('Total Fat : ', '${foods[index].fatTotalG} g'),
                                  buildNutritionRow('Protein : ', '${foods[index].proteinG} g'),
                                  buildNutritionRow('Sodium : ', '${foods[index].sodiumMg} mg'),
                                  buildNutritionRow('Potassium : ', '${foods[index].potassiumMg} mg'),
                                  buildNutritionRow('Cholesterol : ', '${foods[index].cholesterolMg} mg'),
                                  buildNutritionRow('Total Carbohydrates : ', '${foods[index].carbohydratesTotalG} g'),
                                  buildNutritionRow('Fiber : ', '${foods[index].fiberG} g'),
                                  buildNutritionRow('Sugar : ', '${foods[index].sugarG} g'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildNutritionRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.alike(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 3),
        Text(
          value,
          style: GoogleFonts.alike(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
