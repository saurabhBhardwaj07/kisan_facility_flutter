// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/model/product_categories_response.dart';
import 'package:kisan_facility/model/product_response.dart';
import 'package:kisan_facility/screens/dashborad/shop/controller/cart_controlller.dart';
import 'package:kisan_facility/screens/dashborad/shop/repository/shop_repository.dart';
import 'package:kisan_facility/utils/app_snackbar.dart';

final productCategoryLoading = StateProvider<bool>((ref) => false);
final addToCartLoading = StateProvider<bool>((ref) => false);

final productListProvider = Provider<List<SingleProduct>>((ref) => []);
final productCategoryListProvider = Provider<List<SingleCategory>>((ref) => []);

final topSellingProductProvider = Provider<List<SingleProduct>>((ref) => []);
final topFourRecommendedProductProvider =
    Provider<List<SingleProduct>>((ref) => []);
final recommendedProductProvider = Provider<List<SingleProduct>>((ref) => []);

final shopControllerProvider =
    StateNotifierProvider<ShopController, bool>((ref) {
  return ShopController(
    ref: ref,
    shopRepository: ref.watch(shopRepositoryProvider),
  );
});

class ShopController extends StateNotifier<bool> {
  final Ref _ref;
  final ShopRepository _shopRepository;

  ShopController({
    required Ref ref,
    required ShopRepository shopRepository,
  })  : _ref = ref,
        _shopRepository = shopRepository,
        super(false);

  void getProductList(BuildContext context) async {
    state = true;
    final getResp = await _shopRepository.callingProductList();
    state = false;
    getResp.fold((l) => showSnackBar(context, l.message), (products) {
      _ref.read(productListProvider).clear();
      _ref.read(topSellingProductProvider).clear();
      _ref.read(recommendedProductProvider).clear();
      _ref.read(topFourRecommendedProductProvider).clear();
      _ref.read(productListProvider).addAll(products);

      if (products.isNotEmpty) {
        for (var i in products) {
          var index = products.indexOf(i);
          if (index < 2) {
            _ref.read(topSellingProductProvider).add(i);
            _ref.read(recommendedProductProvider).add(i);
          }

          if (index < 4) {
            _ref.read(topFourRecommendedProductProvider).add(i);
          }
        }
      }
    });
  }

  void getCategoryList(BuildContext context) async {
    _ref.watch(productCategoryLoading.notifier).state = true;
    final getResp = await _shopRepository.callingCategoryList();

    _ref.watch(productCategoryLoading.notifier).state = false;
    getResp.fold((l) => showSnackBar(context, l.message), (category) {
      _ref.read(productCategoryListProvider).clear();
      _ref.read(productCategoryListProvider).addAll(category);
    });
  }

  void addToCart(BuildContext context, String productID, int quantity,
      double price) async {
    _ref.watch(addToCartLoading.notifier).state = true;
    final getResp = await _shopRepository.addToCart(productID, quantity, price);
    if (mounted) {
      _ref.read(cartControllerProvider.notifier).getCartList(context);
    }
    getResp.fold((l) => showSnackBar(context, l.message), (r) {
      Navigator.pop(context);
    });
    _ref.watch(addToCartLoading.notifier).state = false;
  }
}
