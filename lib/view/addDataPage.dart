import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data Page')
      ),
      body: Center(child: Text('Add Data Page'),),
    );
  }
}

