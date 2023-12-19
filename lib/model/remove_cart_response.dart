class RemoveCartResponse {
  String? message;
  RemovedProduct? data;

  RemoveCartResponse({this.message, this.data});

  RemoveCartResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is Map) {
      data =
          json["data"] == null ? null : RemovedProduct.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["data"] = data?.toJson();
    return _data;
  }
}

class RemovedProduct {
  String? id;
  String? userId;
  String? productId;
  int? quantity;
  int? price;
  String? createdAt;
  String? updatedAt;

  RemovedProduct.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["user_id"] is String) {
      userId = json["user_id"];
    }
    if (json["product_id"] is String) {
      productId = json["product_id"];
    }
    if (json["quantity"] is int) {
      quantity = json["quantity"];
    }
    if (json["price"] is int) {
      price = json["price"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["user_id"] = userId;
    data["product_id"] = productId;
    data["quantity"] = quantity;
    data["price"] = price;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}
