import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kisan_facility/core/failure.dart';
import 'package:kisan_facility/core/type_def/either_type_def.dart';
import 'package:kisan_facility/model/weather_response.dart';
import 'package:kisan_facility/service/network/network_client.dart';

final weatherRepositoryProvider = Provider((ref) =>
    WeatherRepository(networkClient: ref.watch(networkClientProvider)));

class WeatherRepository {
  final NetworkClient _networkClient;
  WeatherRepository({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  FutureEither<List<SingleDayWeather>> fetchThreeDayWeather(
      double latitude, double longitude) async {
    try {
      final resp = await _networkClient.get(
          "https://api.worldweatheronline.com/premium/v1/weather.ashx",
          query: {
            "q": "$latitude,$longitude",
            "num_of_days": 10,
            "format": "json",
            "key": "4675598358124505a57181943231805",
            "showlocaltime": "yes",
            "tp": 24
          });

      var weather = WeatherResponse.fromJson(resp.data);

      return right(weather.data!.weather);
    } on DioError catch (err) {
      print(err.response?.data);
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      print(err.toString());
      return left(Failure(err.toString()));
    }
  }
}
