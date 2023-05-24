class CropPracticeListResponse {
  String? message;
  List<SingleCropPractice> data = [];

  CropPracticeListResponse({this.message, required this.data});

  CropPracticeListResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = (json["data"] as List)
          .map((e) => SingleCropPractice.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class SingleCropPractice {
  String? id;
  String? name;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Crops> crops = [];

  SingleCropPractice.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
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
    if (json["crops"] is List) {
      crops = (json["crops"] as List).map((e) => Crops.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    if (crops != null) {
      _data["crops"] = crops.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Crops {
  String? id;
  String? cropCategoryId;
  String? name;
  String? introduction;
  String? climate;
  String? soil;
  String? season;
  String? status;
  String? createdAt;
  String? updatedAt;
  CropImage? image;

  Crops(
      {this.id,
      this.cropCategoryId,
      this.name,
      this.introduction,
      this.climate,
      this.soil,
      this.season,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.image});

  Crops.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["crop_category_id"] is String) {
      cropCategoryId = json["crop_category_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["introduction"] is String) {
      introduction = json["introduction"];
    }
    if (json["climate"] is String) {
      climate = json["climate"];
    }
    if (json["soil"] is String) {
      soil = json["soil"];
    }
    if (json["season"] is String) {
      season = json["season"];
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
    if (json["image"] is Map) {
      image = json["image"] == null ? null : CropImage.fromJson(json["image"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["crop_category_id"] = cropCategoryId;
    _data["name"] = name;
    _data["introduction"] = introduction;
    _data["climate"] = climate;
    _data["soil"] = soil;
    _data["season"] = season;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    if (image != null) {
      _data["image"] = image?.toJson();
    }
    return _data;
  }
}

class CropImage {
  String? id;
  String? type;
  String? name;
  String? path;
  String? extension;
  String? mediableType;
  String? mediableId;
  String? createdAt;
  String? updatedAt;

  CropImage.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["path"] is String) {
      path = json["path"];
    }
    if (json["extension"] is String) {
      extension = json["extension"];
    }
    if (json["mediable_type"] is String) {
      mediableType = json["mediable_type"];
    }
    if (json["mediable_id"] is String) {
      mediableId = json["mediable_id"];
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
    _data["type"] = type;
    _data["name"] = name;
    _data["path"] = path;
    _data["extension"] = extension;
    _data["mediable_type"] = mediableType;
    _data["mediable_id"] = mediableId;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}
