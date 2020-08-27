import 'package:flutter/material.dart';
import 'package:zero_vendor/common/ui_constants.dart';
import 'package:zero_vendor/services/authService.dart';
import 'package:zero_vendor/view/addDataPage.dart';
import 'package:zero_vendor/view/homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  bool _logging_in = false;
  final formkey = new GlobalKey<FormState>();
  final scaffkey = new GlobalKey<ScaffoldState>();

  checkFields() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState(() {
      _logging_in = false;
    });
    return false;
  }

  login() async {
    setState(() {
      _logging_in = true;
    });
    if (checkFields()) {
      bool authenticated = await AuthService.authenticate(_email, _password);

      if (authenticated) {
        var user = await AuthService.getSavedAuth();
        if (user['role'] == '1') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return HomePage();
          }), (Route<dynamic> route) => false);
        } else {
          scaffkey.currentState.showSnackBar(new SnackBar(
            content: new Text("Authentication denied !! Please retry."),
          ));
        }
      } else {
        setState(() {
          _logging_in = false;
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
            child: ListView(children: <Widget>[
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: MediaQuery.of(context).size.width * 0.01),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 58.0, top: 100),
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
                          _input("Please enter Email", false, "Email", 'Email',
                              (value) {
                            _email = value;
                          }),
                          Container(
                            height: 16.0,
                          ),
                          _input("Please enter password", true, "Password",
                              'Password', (value) {
                            _password = value;
                          }),
                          Container(
                            height: 54.0,
                          ),
                          Container(
                            height: UIConstants.fitToHeight(45, context),
                            width: UIConstants.fitToWidth(116, context),
                            child: RaisedButton(
                              color: Color(0xff0D4971),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: login,
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ]),
          ),
        ));
  }

  Widget _input(String validation, bool, String label, String hint, save) {
    return new TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 15.0, color: Colors.black),
        //labelText: label,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0)),
      ),
      obscureText: bool,
      validator: (value) => value.isEmpty ? validation : null,
      onSaved: save,
    );
  }
}
