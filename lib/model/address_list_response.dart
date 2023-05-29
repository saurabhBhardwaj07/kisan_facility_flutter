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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user_id"] = userId;
    data["name"] = name;
    data["address"] = address;
    data["country"] = country;
    data["state"] = state;
    data["city"] = city;
    data["pincode"] = pincode;
    data["is_default"] = isDefault;
    data["id"] = id;
    data["updated_at"] = updatedAt;
    data["created_at"] = createdAt;
    return data;
  }
}
