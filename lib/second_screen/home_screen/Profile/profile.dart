import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness_and_healty_app/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

UserData _userData = UserData();

class _ProfileState extends State<Profile> {
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _userData.loadUserData();
    setState(() {});
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');

      await storageRef.putFile(_image!);

      final imageUrl = await storageRef.getDownloadURL();

      setState(() {
        _userData.imageUrl = imageUrl;
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'profileImageUrl': imageUrl});
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');

      // إعادة التوجيه إلى شاشة تسجيل الدخول
      Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to logout: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('home');
                    },
                    icon: Icon(
                      Icons.navigate_before_outlined,
                      size: 30,
                    ),
                    color: Colors.purple,
                  ),
                ),
                SizedBox(width: 70),
                Text(
                  'Profile',
                  style: GoogleFonts.alike(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 90),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('calender');
                  },
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Center(
              child: Container(
                height: 200,
                width: 200,
                child: Stack(children: [
                  Container(
                    height: 600,
                    width: 700,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: _userData.imageUrl.isNotEmpty
                            ? NetworkImage(_userData.imageUrl,)
                            : AssetImage(
                            'assets/images/profile_icon.jpg')
                        as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    right: 3,
                    bottom: -3,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () async {
                        await _pickImageFromGallery();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image(
                          image: AssetImage('assets/images/camera.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
          SizedBox(height: 40),
          _buildProfileInfo('Name : ', _userData.name),
          SizedBox(height: 12),
          _buildProfileInfo('Email : ', _userData.email),
          SizedBox(height: 12),
          _buildProfileInfo('Gender : ', _userData.gender),
          SizedBox(height: 12),
          _buildProfileInfo('Weight : ', _userData.weight),
          SizedBox(height: 12),
          _buildProfileInfo('Height : ', _userData.height),
          SizedBox(height: 12),
          SizedBox(
            height: 55,
            width: 250,
            child: ElevatedButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                await _logout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  'Log out',
                  style: GoogleFonts.alike(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Container(
      height: 55,
      width: 330,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.black87,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Row(
          children: [
            Text(
              label,
              style: GoogleFonts.alike(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, top: 2),
              child: Text(
                value,
                style: GoogleFonts.actor(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
