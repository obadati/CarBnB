import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.user,
    required this.accessToken,
  });

  User user;
  String accessToken;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "access_token": accessToken,
      };
}

class User {
  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.profilePic,
    required this.dateCreated,
  });

  int userId;
  String firstName;
  String lastName;
  String? birthdate;
  String email;
  String? phoneNumber;
  String password;
  dynamic profilePic;
  DateTime dateCreated;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userID"],
        firstName: json["firstName"],
        lastName: json["LastName"],
        birthdate: json["birthdate"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        profilePic: json["profilePic"],
        dateCreated: DateTime.parse(json["dateCreated"]),
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "firstName": firstName,
        "LastName": lastName,
        "birthdate": birthdate,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "profilePic": profilePic,
        "dateCreated": dateCreated.toIso8601String(),
      };
}
