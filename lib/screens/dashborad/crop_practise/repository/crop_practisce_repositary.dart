import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kisan_facility/core/constants/api_constant.dart';
import 'package:kisan_facility/core/failure.dart';
import 'package:kisan_facility/core/type_def/either_type_def.dart';
import 'package:kisan_facility/model/crop_practice_list_response.dart';
import 'package:kisan_facility/service/network/network_client.dart';

final cropPracticeRepositoryProvider = Provider((ref) =>
    CropPracticeRepository(networkClient: ref.watch(networkClientProvider)));

class CropPracticeRepository {
  final NetworkClient _networkClient;

  CropPracticeRepository({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  FutureEither<List<SingleCropPractice>> fetchCropPractice() async {
    try {
      final resp = await _networkClient.get(apiBaseUrl + cropPracticeEndPoint);
      var newsResp = CropPracticeListResponse.fromJson(resp.data);
      return right(newsResp.data);
    } on DioError catch (err) {
      print(err.response?.data);
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }
}
