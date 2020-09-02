import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:zero_vendor/view/OrderHistory.dart';
import 'package:zero_vendor/view/homePage.dart';
import 'package:zero_vendor/view/inventory.dart';
import 'package:zero_vendor/view/settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }
  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: PageView(
        children: [
          HomePage(),
          Inventory(),
          OrderHistory(),
          Settings(),
        ],
        controller: pageController,
        onPageChanged: (pageIndex) {
          setState(() {
            this.pageIndex = pageIndex;
          });
        },
      ),
       bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        color: Colors.black,
        backgroundColor:Color.fromRGBO(0, 0, 0, 0).withOpacity(0),
        onTap: onTap,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.redAccent,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: Colors.cyan,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
            color: Colors.amber,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: Colors.greenAccent,
          )
        ],
      ),
    );
  }
}
