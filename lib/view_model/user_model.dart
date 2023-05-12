class UserModel {
  String? message;
  User? user;
  String? token;

  UserModel({this.message, this.user, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["token"] is String) {
      token = json["token"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    if (user != null) {
      data["user"] = user?.toJson();
    }
    data["token"] = token;
    return data;
  }
}

class User {
  String? id;
  // String? roleId;
  String? firstName;
  dynamic middleName;
  String? gender;
  String? lastName;
  String? phone;
  String? email;
  String? deviceToken;
  int? googleId = 0;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? name;

  User.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    // if (json["role_id"] is String) {
    //   roleId = json["role_id"];
    // }
    if (json["first_name"] is String) {
      firstName = json["first_name"];
    }
    middleName = json["middle_name"];
    if (json["last_name"] is String) {
      lastName = json["last_name"];
    }

    if (json["gender"] is String) {
      gender = json["gender"];
    }
    if (json["phone"] is String) {
      phone = json["phone"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    deviceToken = json["device_token"];

    if (json['status'] is int) {
      googleId = json["google_id"];
    }

    if (json["status"] is int) {
      status = int.parse(json["status"]);
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    // data["role_id"] = roleId;
    data["first_name"] = firstName;
    data["middle_name"] = middleName;
    data["last_name"] = lastName;
    data["phone"] = phone;
    data["email"] = email;
    data["gender"] = gender;
    data["device_token"] = deviceToken;
    data["google_id"] = googleId;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["name"] = name;
    return data;
  }
}
