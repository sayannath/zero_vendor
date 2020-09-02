import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zero_vendor/models/Category.dart';
import 'package:zero_vendor/services/categoryService.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
// name:
//   description:
//   price:
//   user :
//   category:
//   stock:
//   photo:

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  List<dynamic> data;
  Category category;
  bool _isLoading = false;
  List<Category> categoryList = [];
  List<DropdownMenuItem> cdl = [];
  bool load = false;

  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController stock = TextEditingController();
  String catType = 'sdasd';

  @override
  void initState() {
    super.initState();
    getAllCategoriesInfo();
  }

  getAllCategoriesInfo() async {
    http.Response response = await CategoryService.getAllCategoriesRequest();
    setState(() {
      data = jsonDecode(response.body);
    });
    data.forEach((element) {
      Category cat = new Category.fromJson(element);
      setState(() {
        categoryList.add(cat);
      });
    });
    categoryList.forEach((element) {
      setState(() {
        cdl.add(DropdownMenuItem(
          child: Text(element.name),
          value: element.name.toString(),
        ));
      });
    });
    setState(() {
      catType = categoryList[0].name;
    });
    _isLoading = true;
  }

  File file;

  ddcat() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: DropdownButton(
        value: catType,
        isExpanded: true,
        hint: Text(
          "Choose product category",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        items: cdl,
        onChanged: (val) {
          setState(() {
            catType = val;
          });
          print(catType);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 30,
                ),
                child: Text(
                  'Add Item',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              _isLoading
                  ? Container(
                      width: 250,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.black,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 100,
                              width: 100,
                              child: InkWell(
                                child: load
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: FileImage(file),
                                              fit: BoxFit.cover),
                                        ),
                                      )
                                    : Icon(
                                        Icons.add,
                                        size: 45,
                                      ),
                                onTap: () {
                                  setState(() {
                                    FilePicker.getFile(
                                            type: FileType.image,
                                            allowCompression: true)
                                        .then((value) {
                                      setState(() {
                                        file = value;
                                        load = true;
                                      });
                                    });
                                  });

                                  print(file.path);
                                },
                              ),
                            ),
                            Container(),
                            SizedBox(
                              height: 15,
                            ),
                            tff('Enter Name of Product', 1, name,
                                TextInputType.name),
                            tff('Enter Description of Product', 4, desc,
                                TextInputType.text),
                            tff('Enter Price of Product', 1, price,
                                TextInputType.number),
                            tff('Enter Stock of Product', 1, stock,
                                TextInputType.number),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white),
                                child: ddcat(),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              onPressed: () {
                                print(name.text);
                                print(desc.text);
                                print(price.text);
                                print(stock.text);
                                print(file.path);
                                print(catType);
                              },
                              color: Colors.green,
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

Widget tff(String hint, int m, TextEditingController tc, TextInputType ty) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
    child: TextFormField(
      keyboardType: ty,
      controller: tc,
      textAlign: TextAlign.start,
      maxLines: m,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0)),
      ),
    ),
  );
}
