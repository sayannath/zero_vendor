import 'dart:convert';

Category CategoryFromJson(String str) => Category.fromJson(json.decode(str));

String CategoryToJson(Category data) => json.encode(data.toJson());

class Category {
    Category({
        this.categoryId,
        this.categoryName,
    });

    String categoryId;
    String categoryName;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["CategoryId"],
        categoryName: json["CategoryName"],
    );

    Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "CategoryName": categoryName,
    };
}
