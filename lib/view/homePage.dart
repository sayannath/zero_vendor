import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zero_vendor/services/authService.dart';
import 'package:zero_vendor/view/loginPage.dart';
import 'package:zero_vendor/view/profilePage.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  signOut() async {
    await AuthService.clearAuth();

    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) {
      return LoginPage();
    }), (Route<dynamic> route) => false);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.account_circle), onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
              return ProfilePage();
            }));
          })
        ],
        title: Text('Home Page'), centerTitle: true),
      body: Center(child: Text('Home Page')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: (){
        signOut();
      }),
    );
  }
}
