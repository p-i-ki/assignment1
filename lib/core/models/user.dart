import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String name;
  String email;
  String phone;
  String gender;
  String country;
  String state;
  String city;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.country,
    required this.state,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["Name"],
        email: json["Email"],
        phone: json["Phone"],
        gender: json["Gender"],
        country: json["Country"],
        state: json["State"],
        city: json["City"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Email": email,
        "Phone": phone,
        "Gender": gender,
        "Country": country,
        "State": state,
        "City": city,
      };
}
