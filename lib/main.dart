import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:zero_vendor/view/homePage.dart';
import 'package:zero_vendor/view/loginPage.dart';
>>>>>>> Stashed changes
import 'package:zero_vendor/view/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< Updated upstream
      home: SplashScreen(),
      // home: AddDataPage(),
=======
      home: HomePage(),
>>>>>>> Stashed changes
    );
  }
}
