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

class User {
  String? name;
  String? email;
  String? phoneNumber;
  String? profileImage;

  User({this.name, this.email, this.phoneNumber, this.profileImage});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['profileImage'] = profileImage;
    return data;
  }
}
