import 'package:flutter/material.dart';
import 'package:mynul_test/src/constants/Keys.dart';
import 'package:mynul_test/src/helpers/NavHelper.dart';
import 'package:mynul_test/src/views/splash-screen/SplashScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavHelper.navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,

      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
