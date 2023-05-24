class NewsListResponse {
  String? message;
  List<SingleNews> data = [];

  NewsListResponse({
    this.message,
  });

  NewsListResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = (json["data"] as List).map((e) => SingleNews.fromJson(e)).toList();
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["data"] = data.map((e) => e.toJson()).toList();

    return _data;
  }
}

class SingleNews {
  String? id;
  String? title;
  String? content;
  String? status;
  String? createdAt;
  String? updatedAt;
  Image? image;

  SingleNews.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["content"] is String) {
      content = json["content"];
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
      image = json["image"] == null ? null : Image.fromJson(json["image"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["content"] = content;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    if (image != null) {
      data["image"] = image?.toJson();
    }
    return data;
  }
}

class Image {
  String? id;
  String? type;
  String? name;
  String? path;
  String? extension;
  String? mediableType;
  String? mediableId;
  String? createdAt;
  String? updatedAt;

  Image.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["type"] = type;
    data["name"] = name;
    data["path"] = path;
    data["extension"] = extension;
    data["mediable_type"] = mediableType;
    data["mediable_id"] = mediableId;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}
