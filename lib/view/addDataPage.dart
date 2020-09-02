import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zero_vendor/common/ui_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:zero_vendor/models/User.dart';
import 'package:zero_vendor/services/userService.dart';
import 'package:zero_vendor/view/Home.dart';


class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final formkey = new GlobalKey<FormState>();
  final scaffkey = new GlobalKey<ScaffoldState>();
  String address;
  String pincode;
  String phoneNumber;
  String userId;
  String latitude = '';
  String longitude = '';
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
    return false;
  }

  _updateUserInfo() async {
    if (checkFields()) {
      http.Response response = await UserService.updateUser(
          phoneNumber, latitude, longitude, address, pincode);
      String body = response.body;
      print(body);
      if (response.statusCode == 200) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          return Home();
        }));
      } else {
        scaffkey.currentState.showSnackBar(new SnackBar(
          content: new Text("Unable to update DB!!"),
        ));
      }
    } else {
      scaffkey.currentState.showSnackBar(new SnackBar(
        content: new Text("Fill all the details properly!!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
      body: SafeArea(
        child: Container(
          height: UIConstants.fitToHeight(640, context),
          width: UIConstants.fitToWidth(360, context),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 58.0, top: 100),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add Vendor Data',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => getLoc())
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(52.0, 0.0, 52.0, 0.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 16.0,
                          ),
                          Container(
                            height: 16.0,
                          ),
                          _input(phoneNumber, "Please enter Phone Number",
                              "Phone Number", 'Phone Number', (value) {
                            phoneNumber = value;
                          }, TextInputType.text),
                          Container(
                            height: 16.0,
                          ),
                          _input(pincode, "Please enter Pincode", "Pincode",
                              'Pincode', (value) {
                            pincode = value;
                          }, TextInputType.text),
                          Container(
                            height: 16.0,
                          ),
                          _input(address, "Please enter Address", "Address",
                              'Address', (value) {
                            address = value;
                          }, TextInputType.text),
                          Container(
                            height: 14.0,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Lat: ' + latitude),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),
                              Text('Long: ' + longitude),
                            ],
                          ),
                          Container(
                            height: 54.0,
                          ),
                          Container(
                            height: UIConstants.fitToHeight(45, context),
                            width: UIConstants.fitToWidth(116, context),
                            child: RaisedButton(
                              onPressed: () {
                                _updateUserInfo();
                              },
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _input(String initalValue, String validation, String label, String hint,
    save, TextInputType keyType) {
  return new TextFormField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
      labelText: label,
      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0)),
    ),
    validator: (value) => value.isEmpty ? validation : null,
    onSaved: save,
    initialValue: initalValue,
    keyboardType: keyType,
  );
}
