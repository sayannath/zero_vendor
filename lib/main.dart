import 'package:flutter/material.dart';
import 'package:zero_vendor/view/addDataPage.dart';
import 'package:zero_vendor/view/loginPage.dart';
import 'package:zero_vendor/view/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: AddDataPage(),
    );
  }
}
