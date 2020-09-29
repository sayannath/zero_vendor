import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:zero_vendor/common/ui_constants.dart';
import 'package:http/http.dart' as http;
import 'package:zero_vendor/models/User.dart';
import 'package:zero_vendor/services/userService.dart';
import 'package:zero_vendor/view/landingPage.dart';

class Step2Reg extends StatefulWidget {
  @override
  _Step2RegState createState() => _Step2RegState();
}

class _Step2RegState extends State<Step2Reg> {
  final formkey = new GlobalKey<FormState>();
  final scaffkey = new GlobalKey<ScaffoldState>();

  checkFields() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
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
                      'Upload Documents',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 35.0,
                        ),
                        Container(
                          height: 35.0,
                          child: Text(
                            'Vendor ID: PUN001',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Container(
                          height: 150.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '1. Business Address Proof \n (Electricity Bill)'),
                              Text('2. GST Number + GST Proof '),
                              Text('3. FSSAI Certificate'),
                              Text('4. Latest ITR'),
                              Text('5. Fire Safety License'),
                              Text('6. TIN Number'),
                              Text('7. Muncipal Health License'),
                            ],
                          ),
                        ),
                        FormBuilderFilePicker(
                          attribute: "doc",
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          maxFiles: 7,
                          multiple: false,
                          previewImages: false,
                          onChanged: (val) => print(val),
                          fileType: FileType.any,
                          onFileLoading: (va) {
                            print(va);
                            //TODO:implement loader animation
                          },
                          selector: Row(
                            children: <Widget>[
                              Icon(Icons.file_upload),
                              Text('Upload'),
                            ],
                          ),
                        ),
                        Container(
                          height: 16.0,
                        ),
                        Container(
                          height: 54.0,
                        ),
                        Container(
                          height: UIConstants.fitToHeight(45, context),
                          width: UIConstants.fitToWidth(116, context),
                          child: RaisedButton(
                            onPressed: () {
                              //TODO:upload data to aws s2
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return Home();
                              }));
                            },
                            color: Color(0xff1386F0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
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
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
