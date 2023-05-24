import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kisan_facility/core/constants/api_constant.dart';
import 'package:kisan_facility/core/failure.dart';
import 'package:kisan_facility/core/type_def/either_type_def.dart';
import 'package:kisan_facility/model/govt_scheme_list_response.dart';
import 'package:kisan_facility/service/network/network_client.dart';

final govtSchemeRepositoryProvider = Provider((ref) =>
    GovtSchemeRepository(networkClient: ref.watch(networkClientProvider)));

class GovtSchemeRepository {
  final NetworkClient _networkClient;

  GovtSchemeRepository({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  FutureEither<List<SingleGovtScheme>> fetchGovtScheme() async {
    try {
      final resp = await _networkClient.get(apiBaseUrl + govtSchemeEndPoint);
      var newsResp = GovtSchemeListResponse.fromJson(resp.data);
      return right(newsResp.data);
    } on DioError catch (err) {
      print(err.response?.data);
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }
}
