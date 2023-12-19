import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kisan_facility/components/custom_rounded_button.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/cart_list_response.dart';
import 'package:kisan_facility/screens/dashborad/address/add_address_screen.dart';
import 'package:kisan_facility/screens/dashborad/address/address_screen.dart';
import 'package:kisan_facility/screens/dashborad/address/controller/address_controller.dart';
import 'package:kisan_facility/screens/dashborad/shop/controller/cart_controlller.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class CheckoutScreen extends StatefulWidget {
  final List<SingleCartItem> orderProduct;
  final num totalPrice;

  const CheckoutScreen(
      {super.key, required this.orderProduct, required this.totalPrice});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final styleX = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.primaryColor);

  List<String> option = ["COD", "Card Pay"];

  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "Checkout",
                  trailing: const SizedBox(),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: ListView(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final loading = ref.watch(addressControllerProvider);
                      final defaultAddress =
                          ref.read(userDefaultAddress.notifier);
                      return loading == true
                          ? SpinKitWave(
                              itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color:
                                      index.isEven ? Colors.red : Colors.green,
                                ),
                              );
                            })
                          : defaultAddress.state != null
                              ? AddressSingleItem(
                                  address: defaultAddress.state!,
                                  isEditable: false)
                              : Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Oops! You dont have a Default Address \n",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (await AppNavigation.goScreen(
                                                  context,
                                                  const AddAddressScreen()) !=
                                              null) {
                                            ref
                                                .read(addressControllerProvider
                                                    .notifier)
                                                .getUserAddress(context);
                                          }
                                        },
                                        child: const Text(
                                          "Click Here To Add",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: AppColors.kPrimaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const Text(
                    "Order Details",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kPrimaryColor),
                  ),
                  const Divider(),
                  ListView.builder(
                      itemCount: widget.orderProduct.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var element = widget.orderProduct[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                element.product?.name ?? "",
                                style: styleX,
                              ),
                              Text(
                                "Qty ${element.quantity}",
                                style: styleX,
                              ),
                              Text(
                                "\u{20B9} ${element.price}",
                                style: styleX,
                              )
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: 15.h,
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: styleX,
                      ),
                      Text(
                        "${widget.totalPrice}",
                        style: styleX,
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
            Row(
                children: option.map((e) {
              var index = option.indexOf(e);
              return Row(
                children: [
                  Checkbox(
                      value: index == selectedOption ? true : false,
                      onChanged: (c) {
                        setState(() {
                          selectedOption = index;
                        });
                      }),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(e)
                ],
              );
            }).toList()),
            SizedBox(
              height: 15.h,
            ),
            Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  width: 1.5,
                  color: Colors.grey,
                ))),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Consumer(builder: (context, ref, index) {
                  final loading = ref.watch(placeOrderLoading);
                  return CustomRoundedButton(
                      loading: loading,
                      centerText: "Checkout Your Order",
                      onPressed: () {
                        ref
                            .watch(cartControllerProvider.notifier)
                            .placeOrder(context);
                      });
                }))
          ],
        ));
  }
}
