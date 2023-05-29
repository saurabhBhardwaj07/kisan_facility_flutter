import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/components/custom_rounded_button.dart';
import 'package:kisan_facility/model/product_response.dart';
import 'package:kisan_facility/screens/dashborad/shop/controller/shop_controller.dart';
import 'package:kisan_facility/utils/help_string.dart';
import 'package:kisan_facility/utils/text_style.dart';
import 'package:quantity_input/quantity_input.dart';

typedef CartCountCallBack = Function(int cart);

class AddToCartBottomSheet extends StatefulWidget {
  final SingleProduct product;
  final CartCountCallBack cartCountCallBack;
  final int count;

  const AddToCartBottomSheet(
      {super.key,
      required this.product,
      required this.cartCountCallBack,
      this.count = 1});

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int simpleIntInput = 1;

  double price = 0.0;
  double actualPrice = 0.0;

  @override
  void initState() {
    simpleIntInput = widget.count;
    price =
        double.parse(widget.product.discountedPrice ?? "0.00") * widget.count;
    actualPrice =
        double.parse(widget.product.discountedPrice ?? "0.00") * widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add To Cart"),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text("Product Name"),
                const SizedBox(
                  width: 10,
                ),
                AutoSizeText(
                  "${widget.product.name}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  minFontSize: 15,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(children: [
              const Text("Quantity No."),
              const Spacer(),
              QuantityInput(
                  value: simpleIntInput,
                  onChanged: (value) {
                    setState(() {
                      simpleIntInput = int.parse(value.replaceAll(',', ''));
                      price = simpleIntInput * actualPrice;
                    });
                    widget.cartCountCallBack(simpleIntInput);
                  }),
            ]),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: AppText.medium(
                    AppHelpString().changePrice(price.toString()),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(child: Consumer(
                  builder: (context, ref, child) {
                    final loader = ref.watch(addToCartLoading);
                    return CustomRoundedButton(
                        loading: loader,
                        centerText: "Add To  Cart",
                        onPressed: () {
                          ref.read(shopControllerProvider.notifier).addToCart(
                              context,
                              widget.product.id ?? "",
                              simpleIntInput,
                              price);
                        });
                  },
                ))
              ],
            ),
            const Spacer(),
          ],
        ));
  }
}
