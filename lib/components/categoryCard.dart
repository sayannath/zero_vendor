import 'package:flutter/material.dart';
import 'package:zero_vendor/common/ui_constants.dart';
import 'package:zero_vendor/models/Categories.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  CategoryCard({this.category});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        height: UIConstants.fitToHeight(100, context),
        width: UIConstants.fitToWidth(200, context),
        child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children:[
      
      Text('${category.categoryName}')
    ]
        ),
      );
  }
}
