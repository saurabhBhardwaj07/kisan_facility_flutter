class LoggedUser {
  int id = 0;
  String? displayName;
  String? email;
  String? phoneNo;
  String? profilePic;

  LoggedUser({this.displayName, this.email, this.phoneNo, this.profilePic});

  LoggedUser.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["display_name"] is String) {
      displayName = json["display_name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["phone_no"] is String) {
      phoneNo = json["phone_no"];
    }
    if (json["profile_pic"] is String) {
      profilePic = json["profile_pic"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["display_name"] = displayName;
    data["email"] = email;
    data["phone_no"] = phoneNo;
    data["profile_pic"] = profilePic;
    return data;
  }
}
