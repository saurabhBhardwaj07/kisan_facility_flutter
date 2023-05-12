class ProductListResponse {
  String? productTitles;
  String? shortDescription;
  String? description;
  int? regularPrice;
  int? salesPrice;
  List<ProductImages> productImages = [];
  String? stockStatus;
  int stockQuantity = 0;
  bool isFavorite = false;
  int totalLikes = 0;

  ProductListResponse({
    this.productTitles,
    this.shortDescription,
    this.description,
    this.regularPrice,
    this.salesPrice,
    this.stockStatus,
  });

  ProductListResponse.fromJson(Map<String, dynamic> json) {
    if (json["productTitles"] is String) {
      productTitles = json["productTitles"];
    }
    if (json["short_description"] is String) {
      shortDescription = json["short_description"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["regularPrice"] is int) {
      regularPrice = json["regularPrice"];
    }
    if (json["salesPrice"] is int) {
      salesPrice = json["salesPrice"];
    }
    if (json["productImages"] is List) {
      productImages = (json["productImages"] as List)
          .map((e) => ProductImages.fromJson(e))
          .toList();
    }
    if (json["stockStatus"] is String) {
      stockStatus = json["stockStatus"];
    }
    if (json["stockQuantity"] is int) {
      stockQuantity = json["stockQuantity"];
    }
    if (json["isFavorite"] is bool) {
      isFavorite = json["isFavorite"];
    }
    if (json["totalLikes"] is int) {
      totalLikes = json["totalLikes"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["productTitles"] = productTitles;
    data["short_description"] = shortDescription;
    data["description"] = description;
    data["regularPrice"] = regularPrice;
    data["salesPrice"] = salesPrice;

    data["productImages"] = productImages.map((e) => e.toJson()).toList();

    data["stockStatus"] = stockStatus;
    data["stockQuantity"] = stockQuantity;
    data["isFavorite"] = isFavorite;
    data["totalLikes"] = totalLikes;
    return data;
  }
}

class ProductImages {
  int? id;
  String? name;
  String? url;

  ProductImages({this.id, this.name, this.url});

  ProductImages.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["url"] is String) {
      url = json["url"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["url"] = url;
    return data;
  }
}
