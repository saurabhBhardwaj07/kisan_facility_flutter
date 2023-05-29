import 'package:kisan_facility/model/image_response.dart';

class ProductResponse {
  String? message;
  List<SingleProduct> data = [];

  ProductResponse({this.message, required this.data});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data =
          (json["data"] as List).map((e) => SingleProduct.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["data"] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class SingleProduct {
  String? id;
  String? productCategoryId;
  String? name;
  int? quantity;
  String? size;
  num price = 0.00;
  int discount = 0;
  String? description;
  String? composition;
  String? uses;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? discountedPrice;
  ImageUrl? image;
  ProductCategory? productCategory;

  SingleProduct.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["product_category_id"] is String) {
      productCategoryId = json["product_category_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["quantity"] is int) {
      quantity = json["quantity"];
    }
    if (json["size"] is String) {
      size = json["size"];
    }
    if (json["price"] is num) {
      price = json["price"];
    }
    if (json["discount"] is int) {
      discount = json["discount"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["composition"] is String) {
      composition = json["composition"];
    }
    if (json["uses"] is String) {
      uses = json["uses"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["discounted_price"] is String) {
      discountedPrice = json["discounted_price"];
    }
    if (json["image"] is Map) {
      image = json["image"] == null ? null : ImageUrl.fromJson(json["image"]);
    }
    if (json["product_category"] is Map) {
      productCategory = json["product_category"] == null
          ? null
          : ProductCategory.fromJson(json["product_category"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["product_category_id"] = productCategoryId;
    data["name"] = name;
    data["quantity"] = quantity;
    data["size"] = size;
    data["price"] = price;
    data["discount"] = discount;
    data["description"] = description;
    data["composition"] = composition;
    data["uses"] = uses;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["discounted_price"] = discountedPrice;
    if (image != null) {
      data["image"] = image?.toJson();
    }
    if (productCategory != null) {
      data["product_category"] = productCategory?.toJson();
    }
    return data;
  }
}

class ProductCategory {
  String? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  ProductCategory.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["status"] is String) {
      status = json["status"];
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
    data["name"] = name;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}
