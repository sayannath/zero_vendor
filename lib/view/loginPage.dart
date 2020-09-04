import 'package:flutter/material.dart';
import 'package:zero_vendor/common/ui_constants.dart';
import 'package:zero_vendor/models/User.dart';
import 'package:zero_vendor/services/authService.dart';
import 'package:zero_vendor/services/userService.dart';
import 'package:zero_vendor/view/addDataPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  bool _loggingIn = false;
  final formkey = new GlobalKey<FormState>();
  final scaffkey = new GlobalKey<ScaffoldState>();

  checkFields() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState(() {
      _loggingIn = false;
    });
    return false;
  }

  login() async {
    setState(() {
      _loggingIn = true;
    });
    if (checkFields()) {
      bool authenticated = await AuthService.authenticate(_email, _password);

      if (authenticated) {
        var auth = await AuthService.getSavedAuth();
        if (auth['role'] == '1') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return AddDataPage();
          }), (Route<dynamic> route) => false);
        } else {
          scaffkey.currentState.showSnackBar(new SnackBar(
            content: new Text("Authentication denied !! Please retry."),
          ));
        }
      } else {
        setState(() {
          _loggingIn = false;
        });
        scaffkey.currentState.showSnackBar(new SnackBar(
          content: new Text("Authentication failure !! Please retry."),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffkey,
        body: Container(
          height: UIConstants.fitToHeight(640, context),
          width: UIConstants.fitToWidth(360, context),
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: ListView(
              children: <Widget>[
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.01),
                Image.asset(
                  "assets/images/splashScreenLogo.png",
                  height: 150,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 58.0, top: 50),
                      child: Container(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 10.0,
                ),
                Container(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(52.0, 0.0, 52.0, 0.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: <Widget>[
                            _input(
                              "Please enter Email",
                              false,
                              "Email",
                              'Email',
                              (value) {
                                _email = value;
                              },
                              Icon(Icons.email),
                            ),
                            Container(
                              height: 16.0,
                            ),
                            _input(
                              "Please enter password",
                              true,
                              "Password",
                              'Password',
                              (value) {
                                _password = value;
                              },
                              Icon(Icons.lock),
                            ),
                            Container(
                              height: 54.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: UIConstants.fitToHeight(45, context),
                                  width: UIConstants.fitToWidth(116, context),
                                  child: RaisedButton(
                                    color: Color(0xff1386F0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    onPressed: login,
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: UIConstants.fitToHeight(45, context),
                                  width: UIConstants.fitToWidth(116, context),
                                  child: RaisedButton(
                                    color: Color(0xff1386F0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddDataPage()));
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ));
  }

  Widget _input(
      String validation, bool, String label, String hint, save, Icon i) {
    return new TextFormField(
      decoration: InputDecoration(
        prefixIcon: i,
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
        labelText: label,
        labelStyle: TextStyle(fontSize: 15, color: Colors.black),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffA2A7B5)),
            borderRadius: BorderRadius.circular(25.0)),
      ),
      obscureText: bool,
      validator: (value) => value.isEmpty ? validation : null,
      onSaved: save,
    );
  }
}
