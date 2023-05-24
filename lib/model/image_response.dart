class ImageUrl {
  String? id;
  String? type;
  String? name;
  String? path;
  String? extension;
  String? mediableType;
  String? mediableId;
  String? createdAt;
  String? updatedAt;

  ImageUrl.fromJson(Map<String, dynamic> json) {
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
