import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kisan_facility/core/constants/api_constant.dart';
import 'package:kisan_facility/core/failure.dart';
import 'package:kisan_facility/core/type_def/either_type_def.dart';
import 'package:kisan_facility/model/address_list_response.dart';
import 'package:kisan_facility/service/network/network_client.dart';

final addressRepository = Provider((ref) =>
    AddressRepository(networkClient: ref.watch(networkClientProvider)));

class AddressRepository {
  final NetworkClient _networkClient;
  AddressRepository({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  FutureEither<List<SingleAddress>> fetchUserAddressList() async {
    try {
      final resp = await _networkClient.get(apiBaseUrl + userAddress);

      var addressList = AddressListResponse.fromJson(resp.data);
      return right(addressList.data);
    } on DioError catch (err) {
      print(err.response?.data);
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<SingleAddress> addNewAddress(
      String name,
      String address,
      String country,
      String state,
      String city,
      String pinCode,
      String isDefault,
      {bool isEditable = false,
      String? id}) async {
    try {
      final resp = await _networkClient.post(
          apiBaseUrl + userAddress + (isEditable == true ? "/$id" : ""),
          body: {
            "name": name,
            "address": address,
            "country": country,
            "state": state,
            "city": city,
            "pincode": pinCode,
            "is_default": isDefault
          },
          queryParameters: isEditable == true ? {"_method": "PUT"} : null);

      var addedAdress = SingleAddress.fromJson(resp.data['data']);
      return Right(addedAdress);
    } on DioError catch (err) {
      print(err.response?.data);
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<SingleAddress> deleteAddress(String id) async {
    try {
      final resp = await _networkClient.post("$apiBaseUrl$userAddress/$id",
          queryParameters: {"_method": "DELETE"});
      var deleteAddress = SingleAddress.fromJson(resp.data['data']);
      return Right(deleteAddress);
    } on DioError catch (err) {
      print(err.response?.data);
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }
}
