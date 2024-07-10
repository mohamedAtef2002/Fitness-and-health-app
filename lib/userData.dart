import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String name = '';
  String email = '';
  String gender = '';
  String weight = '';
  String height = '';
  String age = '';
  String activity = '';
  double bodyfat = 0.0;
  String imageUrl = '';
  String stepCount = '';

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          print('Document data: ${doc.data()}');

          name = doc['name'] ?? '';
          email = doc['email'] ?? '';
          gender = doc['gender'] ?? '';
          weight = doc['weight']?.toString() ?? '';
          height = doc['height']?.toString() ?? '';
          age = doc['age']?.toString() ?? '';
          activity = doc['activity'] ?? '';
          bodyfat = (doc['bodyFat'] ?? 0.0);
          imageUrl = doc['profileImageUrl'] ?? '';
          stepCount = doc['stepCount']?.toString() ?? '';

          // Print each field for debugging
          print('Name: $name');
          print('Email: $email');
          print('Gender: $gender');
          print('Weight: $weight');
          print('Height: $height');
          print('Age: $age');
          print('Activity: $activity');
          print('Body Fat: $bodyfat');
          print('Image URL: $imageUrl');
          print('Step Count: $stepCount');
        } else {
          print('No document found');
        }
      } catch (e) {
        print('Error loading user data: $e');
        // Handle error loading data, e.g., show a snackbar or retry mechanism
      }
    } else {
      print('No user logged in');
    }
  }

  Future<void> saveUserData({
    String? name,
    String? email,
    String? gender,
    String? weight,
    String? height,
    String? age,
    String? activity,
    double? bodyfat,
    String? imageUrl,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Map<String, dynamic> updatedData = {};
      if (name != null) updatedData['name'] = name;
      if (email != null) updatedData['email'] = email;
      if (gender != null) updatedData['gender'] = gender;
      if (weight != null) updatedData['weight'] = weight;
      if (height != null) updatedData['height'] = height;
      if (age != null) updatedData['age'] = age;
      if (activity != null) updatedData['activity'] = activity;
      if (bodyfat != null) updatedData['bodyFat'] = bodyfat;
      if (imageUrl != null) updatedData['profileImageUrl'] = imageUrl;

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update(updatedData);
        print('User data successfully updated');
      } catch (e) {
        print('Error saving user data: $e');
        // Handle error saving data, e.g., show a snackbar or retry mechanism
      }
    }
  }
}
