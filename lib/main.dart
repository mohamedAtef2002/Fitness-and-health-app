import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_and_healty_app/firebase_options.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/FoodSystem/search_foodCalories.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/FoodSystem/calories.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/Profile/calender.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/Profile/profile.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/exercise_screen/bmi.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/exercise_screen/exercise.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/exercise_screen/water_reminder.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/home.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/show_exercise/Arm/arm.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/show_exercise/Back/back.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/show_exercise/Chest/chest.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/show_exercise/Legs/legs.dart';
import 'package:fitness_and_healty_app/second_screen/home_screen/show_exercise/Shoulder/sholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'first_screen/First_screen.dart';
import 'first_screen/Secound_Screen.dart';
import 'first_screen/Third_Screen.dart';
import 'first_screen/login_screen/Forget Passward.dart';
import 'first_screen/login_screen/login_screen.dart';
import 'first_screen/signin/Age.dart';
import 'first_screen/signin/Height.dart';
import 'first_screen/signin/Weight.dart';
import 'first_screen/signin/activity.dart';
import 'first_screen/signin/body_fat.dart';
import 'first_screen/signin/gender.dart';
import 'first_screen/signin/signin_screen.dart';
import 'first_screen/welcome_screen.dart';

// The callback function that will be called periodically
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeating_channel_id',
      'repeating_channel_name',
      channelDescription: 'repeating_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Water Reminder',
      'Drink water is the best thing',
      platformChannelSpecifics,
    );

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Workmanager().registerPeriodicTask(
    '1',
    'simplePeriodicTask',
    frequency: Duration(hours: 2), // Change this to set the interval in hours
  );

  PushNotificationService pushNotificationService = PushNotificationService();
  await pushNotificationService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        'welcome': (context) => welcome(),
        'first_screen': (context) => First_screen(),
        'secound_screen': (context) => Secound_Screen(),
        'third_screen': (context) => Third_Screen(),
        'login': (context) => login_screen(),
        'signin': (context) => LoginScreen(),
        'gender': (context) => Female(),
        'age': (context) => Age(),
        'weight': (context) => Weight(),
        'height': (context) => Height(),
        'activity': (context) => Goal(),
        'body_fat': (context) => BodyFat(),
        'home': (context) => home(),
        'exercise': (context) => HomeScreen(),
        'bmi': (context) => BMIScreen(),
        'calories': (context) => Calories(),
        'chest': (context) => Chest(),
        'back': (context) => Back(),
        'legs': (context) => Legs(),
        'shoulder': (context) => Shoulder(),
        'arm': (context) => Arm(),
        'water_reminder': (context) => WaterReminder(),
        'calender': (context) => Calender(),
        'SearchFoodSystem': (context) => SearchFoodCalories(),
        'profile': (context) => Profile(),
        'reset password': (context) => ResetPasswordPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('home');
    } else {
      Navigator.of(context).pushReplacementNamed('welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class PushNotificationService {
  PushNotificationService._internal();
  static final PushNotificationService _instance = PushNotificationService._internal();
  factory PushNotificationService() => _instance;

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _showNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          payload: message.data['water_reminder'],
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
  }

  void _showNotification({required String? title, required String? body, required payload}) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('Token: $token');
    return token;
  }
}
