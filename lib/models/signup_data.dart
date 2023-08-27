import 'dart:convert';

class SignUpData {
  SignUpData({
    required this.name,
    required this.email,
    required this.password,
    required this.deviceType,
  });

  String name;
  String email;
  String password;
  String deviceType;

  factory SignUpData.fromJson(String str) =>
      SignUpData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignUpData.fromMap(Map<String, dynamic> json) => SignUpData(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        deviceType: json["deviceType"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };
}
