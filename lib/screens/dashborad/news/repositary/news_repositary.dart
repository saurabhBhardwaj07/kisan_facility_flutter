// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kisan_facility/core/constants/api_constant.dart';
import 'package:kisan_facility/core/failure.dart';
import 'package:kisan_facility/core/type_def/either_type_def.dart';
import 'package:kisan_facility/model/news_list_response.dart';
import 'package:kisan_facility/service/network/network_client.dart';

final newsRepositoryProvider = Provider(
    (ref) => NewsRepository(networkClient: ref.watch(networkClientProvider)));

class NewsRepository {
  final NetworkClient _networkClient;
  NewsRepository({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  FutureEither<List<SingleNews>> fetchNews() async {
    try {
      final resp = await _networkClient.get(apiBaseUrl + newsEndPoint);
      var newsResp = NewsListResponse.fromJson(resp.data);
      return right(newsResp.data);
    } on DioError catch (err) {
      print(err.response?.data);
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }
}
