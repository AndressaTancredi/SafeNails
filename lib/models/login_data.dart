import 'dart:convert';

class LoginData {
  LoginData({
    required this.email,
    required this.password,
    required this.deviceType,
  });

  String email;
  String password;
  String deviceType;

  factory LoginData.fromJson(String str) => LoginData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginData.fromMap(Map<String, dynamic> json) => LoginData(
        email: json["email"],
        password: json["password"],
        deviceType: json["deviceType"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };
}
