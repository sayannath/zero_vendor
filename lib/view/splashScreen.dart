import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zero_vendor/common/ui_constants.dart';
import 'package:zero_vendor/services/authService.dart';
import 'package:zero_vendor/view/addDataPage.dart';
import 'package:zero_vendor/view/loginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTime();
    super.initState();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigate);
  }

  void navigate() async {
    var auth = await AuthService.getSavedAuth();

    print(auth == null ? 'Token is null' : auth['token']);
    print(auth == null ? 'Token is null' : auth['role']);

    if (auth != null) {
      var user = await AuthService.getSavedAuth();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return AddDataPage();
      }));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: UIConstants.fitToHeight(250, context),
          width: UIConstants.fitToWidth(250, context),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(UIConstants.splashScreenLogo),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
