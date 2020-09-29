import 'package:flutter/material.dart';
import 'package:zero_vendor/view/addItemPage.dart';

class SubCategorySelect extends StatefulWidget {
  @override
  _SubCategorySelectState createState() => _SubCategorySelectState();
}

class _SubCategorySelectState extends State<SubCategorySelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            alignment: Alignment.topLeft,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: 25),
              alignment: Alignment.topLeft,
              child: Text(
                'Select Sub-Category',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 160,
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 2,
                children: List.generate(
                  15,
                  (index) {
                    return Container(
                      height: 80,
                      width: 80,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Image.asset(
                            'assets/images/food.jpg',
                            height: 75,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(colors: [
                  Color(0xff0061EB),
                  Color(0xff00B7F8),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItem(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 100),
                  child: Text(
                    'Add item',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
