import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zero_vendor/models/User.dart';
import 'package:zero_vendor/services/authService.dart';
import 'package:zero_vendor/view/loginPage.dart';
import 'package:zero_vendor/view/profilePage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, top: 16,bottom: 16,right: 10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rakib\'s Inventory',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Add / Delete/ Update Item',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ProfilePage();
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Container(
            height: 85,
            padding: EdgeInsets.only(left:16,top: 16,bottom: 16),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(right: 12),
                  child: RaisedButton.icon(
                    icon: Icon(Icons.child_care),
                    label: Text('Item $index'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () {},
                    color: Colors.pink[100],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(

            ),
          )
        ],
      ),

    );
  }
}
