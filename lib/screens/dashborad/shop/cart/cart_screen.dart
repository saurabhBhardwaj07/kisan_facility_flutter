import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/components/custom_rounded_button.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/screens/dashborad/address/controller/address_controller.dart';
import 'package:kisan_facility/screens/dashborad/shop/cart/checkout_screen.dart';
import 'package:kisan_facility/screens/dashborad/shop/cart/single_cart_item.dart';
import 'package:kisan_facility/screens/dashborad/shop/controller/cart_controlller.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/help_string.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 800)).then((value) =>
        ref.read(addressControllerProvider.notifier).getUserAddress(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "Cart",
                  trailing: const SizedBox(),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 15.h,
            ),
            Consumer(builder: (context, ref, child) {
              final priceSave = ref.watch(cartSavingPrice);
              final cartList = ref.watch(cartListProvider);
              ref.listen(cartControllerProvider, (previous, next) {
                setState(() {});
              });
              return cartList.isEmpty
                  ? const SizedBox()
                  : Text(
                      "You Save ${AppHelpString().changePrice(priceSave.toString())} On this order.",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryColor),
                    );
            }),
            SizedBox(
              height: 15.h,
            ),
            Expanded(child: Consumer(builder: (context, ref, index) {
              final cartList = ref.watch(cartListProvider.notifier);
              ref.listen(cartControllerProvider, (previous, next) {
                setState(() {});
              });
              return cartList.state.isEmpty
                  ? const Text("You Cart is Empty. Shop it.")
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartList.state.length,
                      itemBuilder: (context, index) {
                        var element = cartList.state[index];
                        return SingleCartItemScreen(element: element);
                      });
            })),
            Consumer(
              builder: (context, ref, child) {
                final totalPrice = ref.watch(cartTotalPrice);
                final cartList = ref.watch(cartListProvider);
                ref.listen(cartControllerProvider, (previous, next) {
                  setState(() {});
                });
                return cartList.isEmpty
                    ? const SizedBox()
                    : Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                          width: 1.5,
                          color: Colors.grey,
                        ))),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Total"),
                                Text(
                                  AppHelpString()
                                      .changePrice(totalPrice.toString()),
                                  style: const TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: 15),
                                )
                              ],
                            )),
                            Expanded(
                              child: CustomRoundedButton(
                                  centerText: "Place Order",
                                  onPressed: () => AppNavigation.goScreen(
                                      context,
                                      CheckoutScreen(
                                        orderProduct:
                                            ref.read(cartListProvider),
                                        totalPrice: ref.watch(cartTotalPrice),
                                      ))),
                            ),
                          ],
                        ),
                      );
              },
            )
          ],
        ));
  }
}
