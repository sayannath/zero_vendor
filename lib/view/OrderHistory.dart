import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Order History",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DefaultTabController(
            length: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar(
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.blueAccent,
                    indicatorColor: Colors.blueAccent,
                    tabs: <Widget>[
                      Tab(
                        text: "All",
                      ),
                      Tab(
                        text: "Today",
                      ),
                      Tab(
                        text: "This Month",
                      ),
                      Tab(
                        text: "Last Month",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, index) => ProductItem(),
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Order Id: 190293",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "ITEMS",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Berries x1, ToothPaste x1",
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Recieved On",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "01 June 2020 at 4:17 pm",
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
          SizedBox(
            width: 150,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              MaterialButton(
                color: Colors.blueAccent,
                child: Text(
                  "Completed",
                  style: TextStyle(
                    color: Color(0xFF5EC3F6),
                    backgroundColor: Color(0xFFD1EEFD),
                  ),
                ),
              ),
              Text(
                "COD",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Rs 550.56",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          )
        ],
      ),
    );
  }
}
