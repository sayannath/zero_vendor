import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zero_vendor/models/User.dart';
import 'package:zero_vendor/services/authService.dart';
import 'package:zero_vendor/services/userService.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zero_vendor/view/addDataPage.dart';
import 'package:zero_vendor/constants.dart';
import 'package:zero_vendor/view/loginPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> data;
  User currentUser;
  bool load = false;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  signOut() async {
    await AuthService.clearAuth();

    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) {
      return LoginPage();
    }), (Route<dynamic> route) => false);
  }

  getUserInfo() async {
    http.Response response = await UserService.getUserInfoRequest();
    print(response.body);
    setState(() {
      data = jsonDecode(response.body);
      currentUser = User.fromJson(data);
      load = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 500,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 499,
                      decoration: BoxDecoration(
                        color: Color(0xFF1386F0),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(27.0),
                          bottomRight: Radius.circular(27.0),
                          topRight: Radius.circular(0.0),
                        ),
                      ),
                    ),
                    Container(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Color(0xFF1386F0),
                        child: Opacity(
                          opacity: 0.8,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage('assets/images/avatar.png'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 240,
                      child: Text(
                        'Remove',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 345,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Shyam Singh',
                            style: TextStyle(color: Colors.white, fontSize: 32),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 395,
                      child: Text(
                        'Vendor',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.call),
                    title: Text(
                      'Phone Number',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('+ 91 0000000000'),
                    trailing: Icon(Icons.edit),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
