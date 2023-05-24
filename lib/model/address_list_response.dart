class AddressListResponse {
  String? message;
  List<SingleAddress> data = [];

  AddressListResponse({this.message, required this.data});

  AddressListResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data =
          (json["data"] as List).map((e) => SingleAddress.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["data"] = data.map((e) => e.toJson()).toList();

    return _data;
  }
}

class SingleAddress {
  String? userId;
  String? name;
  String? address;
  String? country;
  String? state;
  String? city;
  String? pincode;
  String? isDefault;
  String? id;
  String? updatedAt;
  String? createdAt;

  SingleAddress.fromJson(Map<String, dynamic> json) {
    if (json["user_id"] is String) {
      userId = json["user_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["address"] is String) {
      address = json["address"];
    }
    if (json["country"] is String) {
      country = json["country"];
    }
    if (json["state"] is String) {
      state = json["state"];
    }
    if (json["city"] is String) {
      city = json["city"];
    }
    if (json["pincode"] is String) {
      pincode = json["pincode"];
    }
    if (json["is_default"] is String) {
      isDefault = json["is_default"];
    }
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user_id"] = userId;
    _data["name"] = name;
    _data["address"] = address;
    _data["country"] = country;
    _data["state"] = state;
    _data["city"] = city;
    _data["pincode"] = pincode;
    _data["is_default"] = isDefault;
    _data["id"] = id;
    _data["updated_at"] = updatedAt;
    _data["created_at"] = createdAt;
    return _data;
  }
}
