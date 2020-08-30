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
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: load
          ? Container(
              padding: EdgeInsets.all(15),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Profile',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: kSpacingUnit.w * 10,
                    width: kSpacingUnit.w * 10,
                    margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: kSpacingUnit.w * 5,
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          child: Container(
                            alignment: Alignment.bottomRight,
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                LineAwesomeIcons.pen,
                                color: kDarkPrimaryColor,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: kSpacingUnit.w * 2),
                  Text(currentUser.name + ' ' + currentUser.lastname,
                      style: kTitleTextStyle),
                  SizedBox(height: kSpacingUnit.w * 0.5),
                  Text(
                    currentUser.email,
                    style: kCaptionTextStyle,
                  ),
                  SizedBox(height: kSpacingUnit.w * 0.5),
                  Text(
                    currentUser.phone,
                    style: kCaptionTextStyle,
                  ),
                  SizedBox(height: kSpacingUnit.w * 0.5),
                  Text(
                    currentUser.address,
                    style: kCaptionTextStyle,
                  ),
                  SizedBox(height: kSpacingUnit.w * 0.5),
                  Text(
                    currentUser.pincode,
                    style: kCaptionTextStyle,
                  ),
                  SizedBox(height: kSpacingUnit.w * 0.5),
                  Container(
                    alignment: Alignment.center,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddDataPage(),
                          ),
                        )
                      },
                      color: Colors.blueAccent,
                      minWidth: 150,
                      child: Text(
                        'Edit User',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () => signOut()),
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
