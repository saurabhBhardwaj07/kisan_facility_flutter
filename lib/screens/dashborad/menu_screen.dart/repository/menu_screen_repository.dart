import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kisan_facility/core/constants/api_constant.dart';
import 'package:kisan_facility/core/failure.dart';
import 'package:kisan_facility/core/type_def/either_type_def.dart';
import 'package:kisan_facility/model/sucess_response.dart';
import 'package:kisan_facility/service/network/network_client.dart';

final menuScreenRepository = Provider((ref) =>
    MenuScreenRepository(networkClient: ref.watch(networkClientProvider)));

class MenuScreenRepository {
  final NetworkClient _networkClient;

  MenuScreenRepository({required NetworkClient networkClient})
      : _networkClient = networkClient;

  FutureEither<SuccessResponse> contactUsForm(
      String fullName, String email, String detailsIssue) async {
    try {
      final call = await _networkClient.post(apiBaseUrl + contactUs, body: {
        "name": fullName,
        "email": email,
        "description": detailsIssue
      });
      var resp = SuccessResponse.fromJson(call.data);
      return right(resp);
    } on DioError catch (err) {
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }
}
