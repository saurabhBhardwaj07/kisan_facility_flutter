import 'package:kisan_facility/model/address_list_response.dart';
import 'package:kisan_facility/model/product_response.dart';
import 'package:kisan_facility/model/user_model.dart';

class UserOrderResponse {
  String? message;
  List<SingeUserOrder> data = [];

  UserOrderResponse({this.message, required this.data});

  UserOrderResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = (json["data"] as List)
          .map((e) => SingeUserOrder.fromJson(e))
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

class SingeUserOrder {
  String? id;
  String? userId;
  String? userAddressId;
  int? totalPrice;
  String? createdAt;
  String? updatedAt;
  User? user;
  SingleAddress? address;
  List<OrderProducts> orderProducts = [];

  SingeUserOrder.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["user_id"] is String) {
      userId = json["user_id"];
    }
    if (json["user_address_id"] is String) {
      userAddressId = json["user_address_id"];
    }
    if (json["total_price"] is int) {
      totalPrice = json["total_price"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["address"] is Map) {
      address = json["address"] == null
          ? null
          : SingleAddress.fromJson(json["address"]);
    }
    if (json["order_products"] is List) {
      orderProducts = (json["order_products"] as List)
          .map((e) => OrderProducts.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["user_address_id"] = userAddressId;
    _data["total_price"] = totalPrice;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    if (address != null) {
      _data["address"] = address?.toJson();
    }
    _data["order_products"] = orderProducts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class OrderProducts {
  String? id;
  String? orderId;
  String? productId;
  int? quantity;
  int? price;
  String? createdAt;
  String? updatedAt;
  SingleProduct? product;

  OrderProducts(
      {this.id,
      this.orderId,
      this.productId,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.product});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["order_id"] is String) {
      orderId = json["order_id"];
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
    if (json["product"] is Map) {
      product = json["product"] == null
          ? null
          : SingleProduct.fromJson(json["product"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["order_id"] = orderId;
    _data["product_id"] = productId;
    _data["quantity"] = quantity;
    _data["price"] = price;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    if (product != null) {
      _data["product"] = product?.toJson();
    }
    return _data;
  }
}
