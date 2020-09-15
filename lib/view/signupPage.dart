import 'package:flutter/material.dart';
import 'package:zero_vendor/common/ui_constants.dart';
import 'package:zero_vendor/services/baseService.dart';
import 'package:zero_vendor/view/landingPage.dart';
import 'package:zero_vendor/view/loginPage.dart';
import 'package:geolocator/geolocator.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email;
  String _password;
  String _name;
  String _lastName;
  String latitude = '';
  String longitude = '';
  String _phoneNumber;
  String _address;
  String _pincode;

  bool _loggingIn = false;
  @override
  void initState() {
    getLoc();
    super.initState();
  }

  final formkey = new GlobalKey<FormState>();
  final scaffkey = new GlobalKey<ScaffoldState>();
  getLoc() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((value) {
      setState(() {
        latitude = value.latitude.toString();
        longitude = value.longitude.toString();
        print(latitude);
        print(longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

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

  signup() async {
    setState(() {
      _loggingIn = true;
    });
    if (checkFields()) {
      bool authenticated =
          await BaseService.authenticate(_name, _lastName, _email, _password);
      if (authenticated) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
          return LoginPage();
        }), (Route<dynamic> route) => false);
      } else {
        setState(() {
          _loggingIn = false;
        });
        scaffkey.currentState.showSnackBar(new SnackBar(
          content: new Text("Not able to Sign Up !! Please retry."),
        ));
      }
    }
  }

  Widget _input(
      String validation, bool, String label, String hint, save, Icon icon) {
    return new TextFormField(
      decoration: InputDecoration(
        prefixIcon: icon,
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
        labelText: label,
        labelStyle: TextStyle(fontSize: 15, color: Colors.black),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffA2A7B5)),
            borderRadius: BorderRadius.circular(22.0)),
      ),
      obscureText: bool,
      validator: (value) => value.isEmpty ? validation : null,
      onSaved: save,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: UIConstants.fitToHeight(680, context),
          width: UIConstants.fitToWidth(360, context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: UIConstants.fitToWidth(100, context),
                    right: UIConstants.fitToWidth(100, context)),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: UIConstants.fitToHeight(160, context),
                  width: UIConstants.fitToWidth(160, context),
                  child: Image.asset(
                    "assets/images/splashScreenLogo.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: UIConstants.fitToWidth(40.0, context),
                    top: UIConstants.fitToHeight(10, context)),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: UIConstants.fitToHeight(10, context),
              ),
              Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: UIConstants.fitToWidth(40, context),
                          right: UIConstants.fitToWidth(40, context)),
                      child: SizedBox(
                        width: UIConstants.fitToWidth(280, context),
                        child: _input(
                          "Please enter First Name",
                          false,
                          "First Name",
                          'Fist Name',
                          (value) {
                            _name = value;
                          },
                          Icon(
                            Icons.person,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: UIConstants.fitToWidth(10, context)),
                    Padding(
                      padding: EdgeInsets.only(
                          left: UIConstants.fitToWidth(40, context),
                          right: UIConstants.fitToWidth(40, context)),
                      child: SizedBox(
                        width: UIConstants.fitToWidth(280, context),
                        child: _input(
                          "Please enter Last Name",
                          false,
                          "Last Name",
                          'last Name',
                          (value) {
                            _lastName = value;
                          },
                          Icon(Icons.person),
                        ),
                      ),
                    ),
                    SizedBox(height: UIConstants.fitToWidth(10, context)),
                    Padding(
                      padding: EdgeInsets.only(
                          left: UIConstants.fitToWidth(40, context),
                          right: UIConstants.fitToWidth(40, context)),
                      child: SizedBox(
                        width: UIConstants.fitToWidth(280, context),
                        child: _input(
                          "Please enter Email",
                          false,
                          "Email",
                          'Email',
                          (value) {
                            _email = value;
                          },
                          Icon(Icons.email),
                        ),
                      ),
                    ),
                    SizedBox(height: UIConstants.fitToWidth(10, context)),
                    Padding(
                      padding: EdgeInsets.only(
                          left: UIConstants.fitToWidth(40, context),
                          right: UIConstants.fitToWidth(40, context)),
                      child: SizedBox(
                        width: UIConstants.fitToWidth(280, context),
                        child: _input(
                          "Please enter Phone No",
                          true,
                          "Phone No",
                          'Phone No',
                          (value) {
                            _phoneNumber = value;
                          },
                          Icon(
                            Icons.phone,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: UIConstants.fitToWidth(10, context)),
                    Padding(
                      padding: EdgeInsets.only(
                          left: UIConstants.fitToWidth(40, context),
                          right: UIConstants.fitToWidth(40, context)),
                      child: SizedBox(
                        width: UIConstants.fitToWidth(280, context),
                        child: _input(
                          "Please enter Pincode",
                          true,
                          "Pincode",
                          'Pincode',
                          (value) {
                            _pincode = value;
                          },
                          Icon(
                            Icons.fiber_pin,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: UIConstants.fitToWidth(10, context)),
                    Padding(
                      padding: EdgeInsets.only(
                          left: UIConstants.fitToWidth(40, context),
                          right: UIConstants.fitToWidth(40, context)),
                      child: SizedBox(
                        width: UIConstants.fitToWidth(280, context),
                        child: _input(
                          "Please enter Address",
                          true,
                          "Address",
                          'Address',
                          (value) {
                            _address = value;
                          },
                          Icon(
                            Icons.home,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: UIConstants.fitToWidth(10, context)),
                    Padding(
                      padding: EdgeInsets.only(
                          left: UIConstants.fitToWidth(40, context),
                          right: UIConstants.fitToWidth(40, context)),
                      child: SizedBox(
                        width: UIConstants.fitToWidth(280, context),
                        child: _input(
                          "Please enter Password",
                          true,
                          "Password",
                          'Password',
                          (value) {
                            _password = value;
                          },
                          Icon(
                            Icons.lock,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: UIConstants.fitToHeight(10, context)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Lat: ' + latitude),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Text('Long: ' + longitude),
                      ],
                    ),
                    SizedBox(height: UIConstants.fitToHeight(30, context)),
                    Container(
                      height: UIConstants.fitToHeight(48, context),
                      width: UIConstants.fitToWidth(160, context),
                      child: RaisedButton(
                        color: Color(0xff1386F0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        onPressed: () => signup(),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 0.32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
