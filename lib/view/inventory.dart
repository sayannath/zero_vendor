import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zero_vendor/models/Category.dart';
import 'package:zero_vendor/services/categoryService.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {

  List<dynamic> data;
  Category category;
  bool _isLoading = false;

  @override
  void initState() { 
    super.initState();
    getAllCategoriesInfo();
  }
  getAllCategoriesInfo() async {
    http.Response response = await CategoryService.getAllCategoriesRequest();
    print(response.body);
    setState(() {
      data = jsonDecode(response.body);
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left:20, top:30,),
            child: Text(
              'Inventory',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height-110,
            alignment: Alignment.center,
            child: Text(
              '$data',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
              size: 40,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Colors.blue[700], Colors.cyan],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft),
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
