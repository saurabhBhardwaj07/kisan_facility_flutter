import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/model/cart_list_response.dart';
import 'package:kisan_facility/screens/dashborad/shop/booking_succes_screen.dart';
import 'package:kisan_facility/screens/dashborad/shop/repository/shop_repository.dart';
import 'package:kisan_facility/service/notification/local_notification_service.dart';
import 'package:kisan_facility/utils/app_snackbar.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

final cartListProvider = StateProvider<List<SingleCartItem>>((ref) => []);
final deleteProductItemLoading = StateProvider<bool>((ref) => false);

final placeOrderLoading = StateProvider<bool>((ref) => false);

final cartTotalPrice = StateProvider<num>((ref) => 0);
final cartSavingPrice = StateProvider<num>((ref) => 0);

final cartControllerProvider =
    StateNotifierProvider<CartController, int>((ref) {
  return CartController(
      ref: ref, shopRepository: ref.watch(shopRepositoryProvider));
});

class CartController extends StateNotifier<int> {
  final Ref _ref;
  final ShopRepository _shopRepository;

  CartController({
    required Ref ref,
    required ShopRepository shopRepository,
  })  : _ref = ref,
        _shopRepository = shopRepository,
        super(0);

  void getCartList(BuildContext context) async {
    final getResp = await _shopRepository.fetchUserCart();
    getResp.fold((l) => showSnackBar(context, l.message), (products) {
      _ref.refresh(cartSavingPrice.notifier).state = 0;
      _ref.refresh(cartTotalPrice.notifier).state = 0;
      for (var x in products) {
        addPrice(x.price, x.quantity ?? 0, x.product?.price ?? 0.00);
      }
      state = 0;
      state = products.length;
      _ref.read(cartListProvider.notifier).state.clear();
      _ref.read(cartListProvider.notifier).state.addAll(products);
    });
  }

  void addPrice(num price, int quantity, num mainPrice) {
    _ref.read(cartTotalPrice.notifier).state =
        (_ref.read(cartTotalPrice.notifier).state + price);
    calculateSavePrice(quantity, mainPrice, price);
    log("${_ref.read(cartTotalPrice.notifier).state}XX");
  }

  void calculateSavePrice(int quantity, num mainPrice, num actualPrice) {
    _ref.read(cartSavingPrice.notifier).state =
        ((mainPrice * quantity) - actualPrice) +
            _ref.read(cartSavingPrice.notifier).state;
    log("${_ref.read(cartSavingPrice.notifier).state}YY");
  }

  void deleteCartItem(String productId, BuildContext context) async {
    _ref.watch(deleteProductItemLoading.notifier).state = true;
    final storeResp = await _shopRepository.deleteCart(productId);
    storeResp.fold((l) => showSnackBar(context, l.message), (r) {
      getCartList(context);
    });
    _ref.watch(deleteProductItemLoading.notifier).state = false;
  }

  void placeOrder(BuildContext context) async {
    _ref.watch(placeOrderLoading.notifier).state = true;
    final storeResp = await _shopRepository.placeOrder();
    _ref.watch(placeOrderLoading.notifier).state = false;

    storeResp.fold((l) => showSnackBar(context, l.message), (r) {
      getCartList(context);
      LocalNotificationService.showBigTextNotification(
          title: "Congratulation", body: "Your Order Places Successful");
      Navigator.pop(context);
      Navigator.pop(context);
      AppNavigation.goScreen(context, SuccessScreen());
    });
  }
}
