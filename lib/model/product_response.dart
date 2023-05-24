import 'package:kisan_facility/model/image_response.dart';

class ProductResponse {
  String? message;
  List<Data>? data;

  ProductResponse({this.message, this.data});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  String? id;
  String? productCategoryId;
  String? name;
  int? quantity;
  String? size;
  int? price;
  int? discount;
  String? description;
  String? composition;
  String? uses;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? discountedPrice;
  ImageUrl? image;
  ProductCategory? productCategory;

  Data(
      {this.id,
      this.productCategoryId,
      this.name,
      this.quantity,
      this.size,
      this.price,
      this.discount,
      this.description,
      this.composition,
      this.uses,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.discountedPrice,
      this.image,
      this.productCategory});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json["price"] is int) {
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
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["product_category_id"] = productCategoryId;
    _data["name"] = name;
    _data["quantity"] = quantity;
    _data["size"] = size;
    _data["price"] = price;
    _data["discount"] = discount;
    _data["description"] = description;
    _data["composition"] = composition;
    _data["uses"] = uses;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["discounted_price"] = discountedPrice;
    if (image != null) {
      _data["image"] = image?.toJson();
    }
    if (productCategory != null) {
      _data["product_category"] = productCategory?.toJson();
    }
    return _data;
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
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}
