
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Food.dart';


class ApiService {
  static Future<List<Food>> fetchData(String query) async {
    final String apiKey = 'yNOJ1XHmOoSZbNlIt9is9ujRbHs5tjifIknzRSFu';
    final String encodedQuery = Uri.encodeQueryComponent(query);
    final String apiUrl = "https://api.api-ninjas.com/v1/nutrition?query=$encodedQuery";

    final response = await http.get(Uri.parse(apiUrl), headers: {'X-Api-Key': apiKey});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Food>.from(jsonData.map((data) => Food.fromJson(data)));
    } else {
      throw Exception('Failed to load data');
    }
  }
}