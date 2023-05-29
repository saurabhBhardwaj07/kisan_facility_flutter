import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/core/constants/api_constant.dart';
import 'package:kisan_facility/core/failure.dart';
import 'package:kisan_facility/core/type_def/either_type_def.dart';
import 'package:kisan_facility/model/cart_list_response.dart';
import 'package:kisan_facility/model/product_categories_response.dart';
import 'package:kisan_facility/model/product_response.dart';
import 'package:kisan_facility/model/remove_cart_response.dart';
import 'package:kisan_facility/model/sucess_response.dart';
import 'package:kisan_facility/model/user_order_response.dart';
import 'package:kisan_facility/service/network/network_client.dart';

final shopRepositoryProvider = Provider(
    (ref) => ShopRepository(networkClient: ref.watch(networkClientProvider)));

class ShopRepository {
  final NetworkClient _networkClient;

  ShopRepository({required NetworkClient networkClient})
      : _networkClient = networkClient;

  FutureEither<List<SingleProduct>> callingProductList() async {
    try {
      final call = await _networkClient.get(apiBaseUrl + productListEndPoint);
      var productList = ProductResponse.fromJson(call.data);
      return right(productList.data);
    } on DioError catch (err) {
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<List<SingleCategory>> callingCategoryList() async {
    try {
      final call =
          await _networkClient.get(apiBaseUrl + productCategoryEndPoint);
      var productList = ProductCategoriesResponse.fromJson(call.data);
      return right(productList.data);
    } on DioError catch (err) {
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<SuccessResponse> addToCart(
      String productID, int quantity, double price) async {
    try {
      final call = await _networkClient.post(apiBaseUrl + addToCartEndPoint,
          body: {
            "product_id": productID,
            "quantity": quantity,
            "price": price
          });

      var resp = SuccessResponse.fromJson(call.data);
      return right(resp);
    } on DioError catch (err) {
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<List<SingleCartItem>> fetchUserCart() async {
    try {
      final call = await _networkClient.get(
        apiBaseUrl + addToCartEndPoint,
      );
      var resp = CartListResponse.fromJson(call.data);
      return right(resp.data);
    } on DioError catch (err) {
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<RemoveCartResponse> deleteCart(String productId) async {
    try {
      final call = await _networkClient.post(
          "$apiBaseUrl$addToCartEndPoint/$productId",
          queryParameters: {"_method": "DELETE"});
      var resp = RemoveCartResponse.fromJson(call.data);
      return right(resp);
    } on DioError catch (err) {
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<SuccessResponse> placeOrder() async {
    try {
      final call = await _networkClient.post(apiBaseUrl + placeOrderEndPoint);
      var resp = SuccessResponse.fromJson(call.data);
      return right(resp);
    } on DioError catch (err) {
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<List<SingeUserOrder>> getUserOrder() async {
    try {
      final call = await _networkClient.get(apiBaseUrl + placeOrderEndPoint);
      var resp = UserOrderResponse.fromJson(call.data);
      return right(resp.data);
    } on DioError catch (err) {
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }
}
