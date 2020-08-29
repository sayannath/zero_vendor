import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zero_vendor/services/userService.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String data = "";
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    http.Response response = await UserService.getUserInfoRequest();
    print(response.body);
    data = jsonDecode(response.body).toString();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
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
                    backgroundImage: AssetImage('assets/images/avatar.png'),
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
            Text(
              'Name',
              style: kTitleTextStyle,
            ),
            SizedBox(height: kSpacingUnit.w * 0.5),
            Text(
              'user@email.com',
              style: kCaptionTextStyle,
            ),
            SizedBox(height: kSpacingUnit.w * 0.5),
            Text(
              'phone number',
              style: kCaptionTextStyle,
            ),
            SizedBox(height: kSpacingUnit.w * 0.5),
            Text(
              'address',
              style: kCaptionTextStyle,
            ),
            SizedBox(height: kSpacingUnit.w * 0.5),
            Container(
              alignment: Alignment.center,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () => {},
                color: Colors.blueAccent,
                minWidth: 150,
                child: Text(
                  'Edit User',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
