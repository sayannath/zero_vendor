import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zero_vendor/services/userService.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    http.Response response = await UserService.getUserInfoRequest();
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'), centerTitle: true),
      body: Container(),
    );
  }
}
