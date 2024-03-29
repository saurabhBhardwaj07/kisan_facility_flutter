class GovtSchemeListResponse {
  String? message;
  List<SingleGovtScheme> data = [];

  GovtSchemeListResponse({this.message, required this.data});

  GovtSchemeListResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = (json["data"] as List)
          .map((e) => SingleGovtScheme.fromJson(e))
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

class SingleGovtScheme {
  String? id;
  String? name;
  String? link;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  SingleGovtScheme.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["link"] is String) {
      link = json["link"];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["link"] = link;
    data["description"] = description;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}
