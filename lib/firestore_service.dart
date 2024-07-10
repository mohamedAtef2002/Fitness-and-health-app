import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchDietPlan(int id) async {
    try {
      DocumentSnapshot docSnapshot =
          await _db.collection('diet_plans').doc(id.toString()).get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        print('Fetched Diet Plan from Firestore: $data');
        return data;
      } else {
        print('Diet Plan document with id $id does not exist.');
        return {};
      }
    } catch (e) {
      print('Error fetching diet plan: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchExercisePlan(int id) async {
    try {
      DocumentSnapshot docSnapshot =
          await _db.collection('Exercise_plans').doc(id.toString()).get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        print('Fetched Exercise Plan from Firestore: $data');
        return data;
      } else {
        print('Exercise Plan document with id $id does not exist.');
        return {};
      }
    } catch (e) {
      print('Error fetching exercise plan: $e');
      return {};
    }
  }
}
