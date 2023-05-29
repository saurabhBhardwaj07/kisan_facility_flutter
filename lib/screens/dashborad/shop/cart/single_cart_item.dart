import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/model/cart_list_response.dart';
import 'package:kisan_facility/screens/dashborad/shop/controller/cart_controlller.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/help_string.dart';
import 'package:kisan_facility/utils/text_style.dart';

class SingleCartItemScreen extends StatelessWidget {
  final SingleCartItem element;
  const SingleCartItemScreen({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kPrimaryLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: AppColors.kPrimaryColor,
          width: 1,
        ),
      ),
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      element.product?.name ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      minFontSize: 10,
                    ),
                    Row(
                      children: [
                        AppText.small(
                          "\u{20B9} ${AppHelpString().changePrice(
                            element.price.toString(),
                          )}",
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        AppText.small(
                          "\u{20B9} ${AppHelpString().changePrice((element.product!.price * (element.quantity ?? 0)).toString())}",
                          textDecoration: TextDecoration.lineThrough,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Size: ${element.product?.size}")
                  ],
                ),
              ),
              // Spacer(),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl:
                      "https://kisan-facility.mmssatta.in/api/media/products/${element.product?.image?.path}",
                  height: 100.h,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Consumer(builder: (context, ref, child) {
                final deleting = ref.watch(deleteProductItemLoading.notifier);
                return deleting.state == true
                    ? const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(),
                      )
                    : InkWell(
                        onTap: () => ref
                            .watch(cartControllerProvider.notifier)
                            .deleteCartItem(element.id ?? "", context),
                        child: const Text(
                          "Remove",
                          style: TextStyle(color: AppColors.darkRed),
                        ),
                      );
              }),
              const Spacer(),
              Text("Qty: ${element.quantity}")
            ],
          )
        ]),
      ),
    );
    ;
  }
}
