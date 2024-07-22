import 'driver_model.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? profileImage;
  String? role;
  Driver? driverDetails;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profileImage,
    this.role,
    this.driverDetails,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
      role: json['role'],
      driverDetails: json['driverDetails'] != null ? Driver.fromJson(json['driverDetails']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['profileImage'] = profileImage;
    data['role'] = role;
    if (driverDetails != null) {
      data['driverDetails'] = driverDetails!.toJson();
    }
    return data;
  }
}

class UserModel {
  String? message;
  String? token;
  User? user;

  UserModel({this.message, this.token, this.user});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
