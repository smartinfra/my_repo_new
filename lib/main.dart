import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'route_generator.dart';
import 'package:screen/screen.dart';
import 'data/my_colors.dart';
import 'data/img.dart';
import 'data/sqlite_db.dart';
import 'widget/my_text.dart';
import 'repository/user_repository.dart' as userRepo;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: [
      const Locale('en', 'US'),
      const Locale('ko', 'KO'),
    ],
    theme: ThemeData(
        primaryColor: MyColors.primary,
        accentColor: MyColors.accent,
        primaryColorDark: MyColors.primaryDark,
        primaryColorLight: MyColors.primaryLight,
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent)),
    home: SplashScreen(),
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() {
    // Prevent screen from going into sleep mode: (테스트용)
    if (kReleaseMode) {
      print('realease');
    } else {
      print('dev');
      Screen.keepOn(true);
    }

    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigationPage);
  }

  // https://www.youtube.com/watch?v=PrnxksGQ210
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  void navigationPage() {
    // Navigator.of(context).pushReplacementNamed('/MenuRoute');
    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/DashboardPage');
    } else {
      Navigator.of(context).pushReplacementNamed('/LoginPage');
    }
  }

  @override
  void initState() {
    // User 정보 체크
    userRepo.getCurrentUser();

    super.initState();
    SQLiteDb dbHelper = SQLiteDb();
    dbHelper.init();
    startTime();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Align(
        child: Container(
          child: Image.asset(Img.get('loading.jpg'), fit: BoxFit.cover),
          width: double.infinity,
          // height: double.infinity,
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
