import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String data;
  HomePage({
    Key key,
    @required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HOME'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Home Page',
                style: TextStyle(fontSize: 50),
              ),
              Text(
                data,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ));
  }
}
