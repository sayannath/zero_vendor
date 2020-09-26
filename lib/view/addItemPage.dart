// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:zero_vendor/models/Categories.dart';
// import 'package:zero_vendor/models/product.dart';
// import 'package:zero_vendor/services/authService.dart';
// import 'package:zero_vendor/services/categoryService.dart';
// import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';
// import 'package:zero_vendor/services/ProductService.dart';
// import 'package:zero_vendor/models/User.dart';
// import 'package:zero_vendor/services/userService.dart';
// // name:
// //   description:
// //   price:
// //   user :
// //   category:
// //   stock:
// //   photo:

// class AddItem extends StatefulWidget {
//   @override
//   _AddItemState createState() => _AddItemState();
// }

// class _AddItemState extends State<AddItem> {
//   List<dynamic> data;
//   Category category;
//   bool _isLoading = true;
//   List<Category> categoryList = [];
//   List<DropdownMenuItem> cdl = [];
//   bool load = false;
//   String id;
//   Map<String, dynamic> userdata;

//   TextEditingController name = TextEditingController();
//   TextEditingController desc = TextEditingController();
//   TextEditingController price = TextEditingController();
//   TextEditingController stock = TextEditingController();
//   String catType = '5f4f4ac8fa2ecb66ff4b3d0f';

//   @override
//   void initState() {
//     super.initState();
//     getUserInfo();
//     // getAllCategoriesInfo();
//   }

//   getUserInfo() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       id = prefs.getString('id');
//     });
//   }

//   getAllCategoriesInfo() async {
//     http.Response response = await CategoryService.getAllCategoriesRequest();
//     setState(() {
//       data = jsonDecode(response.body);
//     });
//     data.forEach((element) {
//       Category cat = new Category.fromJson(element);
//       setState(() {
//         categoryList.add(cat);
//       });
//     });
//     categoryList.forEach((element) {
//       setState(() {
//         cdl.add(DropdownMenuItem(
//           child: Text(element.name),
//           value: element.id.toString(),
//         ));
//       });
//     });
//     setState(() {
//       catType = categoryList[0].name;
//     });
//     _isLoading = true;
//   }

//   File file;

//   ddcat() {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 20.0,
//         right: 20.0,
//       ),
//       child: DropdownButton(
//         value: catType,
//         isExpanded: true,
//         hint: Text(
//           "Choose product category",
//           style: TextStyle(color: Colors.black, fontSize: 15),
//         ),
//         items: cdl,
//         onChanged: (val) {
//           setState(() {
//             catType = val;
//           });
//           print(catType);
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           child: ListView(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(
//                   left: 20,
//                   top: 30,
//                 ),
//                 child: Text(
//                   'Add Item',
//                   style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               _isLoading
//                   ? Container(
//                       width: 250,
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                         color: Colors.black,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               height: 25,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               height: 100,
//                               width: 100,
//                               child: InkWell(
//                                 child: load
//                                     ? Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           image: DecorationImage(
//                                               image: FileImage(file),
//                                               fit: BoxFit.cover),
//                                         ),
//                                       )
//                                     : Icon(
//                                         Icons.add,
//                                         size: 45,
//                                       ),
//                                 onTap: () {
//                                   setState(() {
//                                     FilePicker.getFile(
//                                             type: FileType.image,
//                                             allowCompression: true)
//                                         .then((value) {
//                                       setState(() {
//                                         file = value;
//                                         load = true;
//                                       });
//                                     });
//                                   });

//                                   print(file.path);
//                                 },
//                               ),
//                             ),
//                             Container(),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             tff('Enter Name of Product', 1, name,
//                                 TextInputType.name),
//                             tff('Enter Description of Product', 4, desc,
//                                 TextInputType.text),
//                             tff('Enter Price of Product', 1, price,
//                                 TextInputType.number),
//                             tff('Enter Stock of Product', 1, stock,
//                                 TextInputType.number),
//                             // Padding(
//                             //   padding: EdgeInsets.symmetric(
//                             //       vertical: 8.0, horizontal: 15),
//                             //   child: Container(
//                             //     decoration: BoxDecoration(
//                             //         borderRadius: BorderRadius.circular(10.0),
//                             //         color: Colors.white),
//                             //     child: ddcat(),
//                             //   ),
//                             // ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             MaterialButton(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12)),
//                               onPressed: () async {
//                                 // print(name.text);
//                                 // print(desc.text);
//                                 // print(price.text);
//                                 // print(stock.text);
//                                 // print(file.absolute.path);
//                                 // print(catType);

//                                 // Product product = Product(
//                                 //   description: desc.text,
//                                 //   name: name.text,
//                                 //   price: double.parse(price.text),
//                                 //   stock: int.parse(stock.text),
//                                 //   category: catType,
//                                 //   photo: file.absolute.path,
//                                 //   user: id,
//                                 // );
//                                 //print(product.user);
//                                 http.Response response = await http.post(
//                                     'http://192.168.1.5:3000/api/product/create/5f49572dd72fc8a8acf710c5',
//                                     headers: {
//                                       "Content-Type": "application/form-data",
//                                       "Authorization":
//                                           "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjQ5NTcyZGQ3MmZjOGE4YWNmNzEwYzUiLCJpYXQiOjE1OTkxMzEwMTd9.MZZzGipQPLiI2JfXqla3eJbCjkh59FUy-7UuG-32iro"
//                                     },
//                                     body: json.encode({
//                                       "name": "Condom",
//                                       "description": "Good for having sex",
//                                       "price": "13",
//                                       "stock": "100",
//                                       "category": "5f4c779ff98a660b4b7b97af",
//                                       "user": "5f49572dd72fc8a8acf710c5"
//                                     }));
//                                 print(response.body);
//                               },
//                               color: Colors.green,
//                               child: Text(
//                                 'Add',
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   : Center(
//                       child: CircularProgressIndicator(),
//                     )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget tff(String hint, int m, TextEditingController tc, TextInputType ty) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
//     child: TextFormField(
//       keyboardType: ty,
//       controller: tc,
//       textAlign: TextAlign.start,
//       maxLines: m,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         hintText: hint,
//         hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
//         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
//         border: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.black),
//             borderRadius: BorderRadius.circular(10.0)),
//       ),
//     ),
//   );
// }
