class WeatherResponse {
  WeatherData? data;

  WeatherResponse({this.data});

  WeatherResponse.fromJson(Map<String, dynamic> json) {
    if (json["data"] is Map) {
      data = json["data"] == null ? null : WeatherData.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class WeatherData {
  List<SingleDayWeather> weather = [];

  WeatherData.fromJson(Map<String, dynamic> json) {
    if (json["weather"] is List) {
      weather = (json["weather"] as List)
          .map((e) => SingleDayWeather.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["weather"] = weather.map((e) => e.toJson()).toList();

    return _data;
  }
}

class SingleDayWeather {
  String? date;
  List<Astronomy>? astronomy;
  String? maxtempC;
  String? maxtempF;
  String? mintempC;
  String? mintempF;
  String? avgtempC;
  String? avgtempF;
  String? totalSnowCm;
  String? sunHour;
  String? uvIndex;
  List<Hourly> hourly = [];

  SingleDayWeather.fromJson(Map<String, dynamic> json) {
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["astronomy"] is List) {
      astronomy = json["astronomy"] == null
          ? null
          : (json["astronomy"] as List)
              .map((e) => Astronomy.fromJson(e))
              .toList();
    }
    if (json["maxtempC"] is String) {
      maxtempC = json["maxtempC"];
    }
    if (json["maxtempF"] is String) {
      maxtempF = json["maxtempF"];
    }
    if (json["mintempC"] is String) {
      mintempC = json["mintempC"];
    }
    if (json["mintempF"] is String) {
      mintempF = json["mintempF"];
    }
    if (json["avgtempC"] is String) {
      avgtempC = json["avgtempC"];
    }
    if (json["avgtempF"] is String) {
      avgtempF = json["avgtempF"];
    }
    if (json["totalSnow_cm"] is String) {
      totalSnowCm = json["totalSnow_cm"];
    }
    if (json["sunHour"] is String) {
      sunHour = json["sunHour"];
    }
    if (json["uvIndex"] is String) {
      uvIndex = json["uvIndex"];
    }
    if (json["hourly"] is List) {
      hourly = (json["hourly"] as List).map((e) => Hourly.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    if (astronomy != null) {
      _data["astronomy"] = astronomy?.map((e) => e.toJson()).toList();
    }
    _data["maxtempC"] = maxtempC;
    _data["maxtempF"] = maxtempF;
    _data["mintempC"] = mintempC;
    _data["mintempF"] = mintempF;
    _data["avgtempC"] = avgtempC;
    _data["avgtempF"] = avgtempF;
    _data["totalSnow_cm"] = totalSnowCm;
    _data["sunHour"] = sunHour;
    _data["uvIndex"] = uvIndex;
    _data["hourly"] = hourly.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Hourly {
  List<WeatherIconUrl1>? weatherIconUrl;
  List<WeatherDesc1>? weatherDesc;

  Hourly.fromJson(Map<String, dynamic> json) {
    if (json["weatherIconUrl"] is List) {
      weatherIconUrl = json["weatherIconUrl"] == null
          ? null
          : (json["weatherIconUrl"] as List)
              .map((e) => WeatherIconUrl1.fromJson(e))
              .toList();
    }
    if (json["weatherDesc"] is List) {
      weatherDesc = json["weatherDesc"] == null
          ? null
          : (json["weatherDesc"] as List)
              .map((e) => WeatherDesc1.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};

    if (weatherIconUrl != null) {
      _data["weatherIconUrl"] = weatherIconUrl?.map((e) => e.toJson()).toList();
    }
    if (weatherDesc != null) {
      _data["weatherDesc"] = weatherDesc?.map((e) => e.toJson()).toList();
    }

    return _data;
  }
}

class WeatherDesc1 {
  String? value;

  WeatherDesc1({this.value});

  WeatherDesc1.fromJson(Map<String, dynamic> json) {
    if (json["value"] is String) {
      value = json["value"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["value"] = value;
    return _data;
  }
}

class WeatherIconUrl1 {
  String? value;

  WeatherIconUrl1({this.value});

  WeatherIconUrl1.fromJson(Map<String, dynamic> json) {
    if (json["value"] is String) {
      value = json["value"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["value"] = value;
    return _data;
  }
}

class Astronomy {
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;
  String? moonIllumination;

  Astronomy(
      {this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.moonIllumination});

  Astronomy.fromJson(Map<String, dynamic> json) {
    if (json["sunrise"] is String) {
      sunrise = json["sunrise"];
    }
    if (json["sunset"] is String) {
      sunset = json["sunset"];
    }
    if (json["moonrise"] is String) {
      moonrise = json["moonrise"];
    }
    if (json["moonset"] is String) {
      moonset = json["moonset"];
    }
    if (json["moon_phase"] is String) {
      moonPhase = json["moon_phase"];
    }
    if (json["moon_illumination"] is String) {
      moonIllumination = json["moon_illumination"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["sunrise"] = sunrise;
    _data["sunset"] = sunset;
    _data["moonrise"] = moonrise;
    _data["moonset"] = moonset;
    _data["moon_phase"] = moonPhase;
    _data["moon_illumination"] = moonIllumination;
    return _data;
  }
}
