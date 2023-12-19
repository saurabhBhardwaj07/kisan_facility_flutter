import 'package:kisan_facility/model/product_response.dart';

class CartListResponse {
  String? message;
  List<SingleCartItem> data = [];

  CartListResponse({this.message, required this.data});

  CartListResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = (json["data"] as List)
          .map((e) => SingleCartItem.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["data"] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class SingleCartItem {
  String? id;
  String? userId;
  String? productId;
  int? quantity;
  num price = 0.00;
  String? createdAt;
  String? updatedAt;
  SingleProduct? product;

  SingleCartItem.fromJson(Map<String, dynamic> json) {
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
    if (json["price"] is num) {
      price = json["price"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["product"] is Map) {
      product = json["product"] == null
          ? null
          : SingleProduct.fromJson(json["product"]);
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
    if (product != null) {
      data["product"] = product?.toJson();
    }
    return data;
  }
}
