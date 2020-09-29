import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.role,
    this.purchases,
    this.id,
    this.name,
    this.lastname,
    this.email,
    this.v,
    this.address,
    this.latitude,
    this.longitude,
    this.phone,
    this.pincode,
  });

  int role;
  List<dynamic> purchases;
  String id;
  String name;
  String lastname;
  String email;
  int v;
  String address;
  String latitude;
  String longitude;
  String phone;
  String pincode;

  factory User.fromJson(Map<String, dynamic> json) => User(
        role: json["role"],
        purchases: List<dynamic>.from(json["purchases"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        v: json["__v"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        phone: json["phone"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "purchases": List<dynamic>.from(purchases.map((x) => x)),
        "_id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "__v": v,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "phone": phone,
        "pincode": pincode,
      };
}
