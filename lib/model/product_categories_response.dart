import 'package:kisan_facility/model/product_response.dart';

class ProductCategoriesResponse {
  String? message;
  List<SingleCategory> data = [];

  ProductCategoriesResponse({this.message, required this.data});

  ProductCategoriesResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = (json["data"] as List)
          .map((e) => SingleCategory.fromJson(e))
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

class SingleCategory {
  String? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<SingleProduct> products = [];

  SingleCategory.fromJson(Map<String, dynamic> json) {
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
    if (json["products"] is List) {
      products = (json["products"] as List)
          .map((e) => SingleProduct.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["products"] = products.map((e) => e.toJson()).toList();

    return data;
  }
}
