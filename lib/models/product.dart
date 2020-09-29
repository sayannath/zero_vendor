import 'dart:convert';

import 'dart:io';
Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toMap());

class Product {
    Product({
        this.name,
        this.description,
        this.price,
        this.stock,
        this.user,
        this.category,
        this.photo,
    });

    String name;
    String description;
    double price;
    int stock;
    String user;
    String category;
    var photo;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        user: json["user"],
        category: json["category"],
        photo: json["photo"],
    );
    


    Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "user": user,
        "category": category,
        "photo": photo,
    };
}
