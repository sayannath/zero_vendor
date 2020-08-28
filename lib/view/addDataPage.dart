import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zero_vendor/common/ui_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zero_vendor/view/homePage.dart';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final formkey = new GlobalKey<FormState>();
  final scaffkey = new GlobalKey<ScaffoldState>();
  String lat = '';
  String long = '';
  String address = '';
  String pincode = '';
  String phone = '';
  getLoc() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((value) {
      setState(() {
        lat = value.latitude.toString();
        long = value.longitude.toString();
        print(lat);
        print(long);
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          _input(phone, "Please enter Phone Number", "Phone Number",
                              'Phone Number', (value) {
                            long = value;
                          }, TextInputType.text),
                          Container(
                            height: 16.0,
                          ),
                          _input(pincode, "Please enter Pincode", "Pincode",
                              'Pincode', (value) {
                            pincode = value;
                          }, TextInputType.number),
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
                              Text('Lat: '+lat),
                              SizedBox(width: 30,),
                              Text('Long: '+long),
                            ],
                          ),
                          Container(
                            height: 54.0,
                          ),
                          Container(
                            height: UIConstants.fitToHeight(45, context),
                            width: UIConstants.fitToWidth(116, context),
                            child: RaisedButton(
                              color: Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())),
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

Widget _input(String va, String validation, String label, String hint, save,
    TextInputType keyb) {
  return new TextFormField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      hintStyle: TextStyle(fontSize: 15.0, color: Colors.black),
      labelText: label,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0)),
    ),
    validator: (value) => value.isEmpty ? validation : null,
    onSaved: save,
    initialValue: va,
    keyboardType: keyb,
  );
}
