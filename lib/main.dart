import 'package:flutter/material.dart';
import 'package:zero_vendor/view/CategorySelect.dart';
import 'package:zero_vendor/view/loginPage.dart';
import 'package:zero_vendor/view/signupPage.dart';
import 'package:zero_vendor/view/splashScreen.dart';
import 'package:zero_vendor/view/step2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen()
    );
  }
}
