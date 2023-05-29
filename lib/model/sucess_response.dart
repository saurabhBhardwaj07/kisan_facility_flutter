class SuccessResponse {
  String? message;
  dynamic data;

  SuccessResponse({this.message, this.data});

  SuccessResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    // if(json["data"] i) {
    //   data = json["data"] == null ? null : Data.fromJson(json["data"]);
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    // if(data != null) {
    //   _data["data"] = data?.toJson();
    // }
    return data;
  }
}
