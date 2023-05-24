import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kisan_facility/core/constants/api_constant.dart';
import 'package:kisan_facility/core/failure.dart';
import 'package:kisan_facility/core/type_def/either_type_def.dart';
import 'package:kisan_facility/service/network/network_client.dart';
import '../../../../model/videos_list_response.dart';

final videosRepositoryProvider = Provider(
    (ref) => VideosRepository(networkClient: ref.watch(networkClientProvider)));

class VideosRepository {
  final NetworkClient _networkClient;

  VideosRepository({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  FutureEither<List<SingleVideo>> fetchVideos() async {
    try {
      final resp = await _networkClient.get(apiBaseUrl + videosEndPoint);
      var newsResp = VideosListResponse.fromJson(resp.data);
      return right(newsResp.data);
    } on DioError catch (err) {
      print(err.response?.data);
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }
}
