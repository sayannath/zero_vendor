import 'package:flutter/material.dart';
import 'package:zero_vendor/view/loginPage.dart';
import 'package:zero_vendor/view/profilePage.dart';
import 'package:zero_vendor/view/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}
