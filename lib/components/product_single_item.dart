import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/model/product_response.dart';
import 'package:kisan_facility/screens/dashborad/shop/product_detail_screen.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/help_string.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';
import 'package:kisan_facility/utils/text_style.dart';

class ProductSingleItem extends StatelessWidget {
  final SingleProduct element;

  const ProductSingleItem({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    // int calculateDiscountPrice(int price, int disPrice) {
    //   return );
    // }

    return InkWell(
      onTap: () => AppNavigation.goScreen(
          context, ProductDetailScreen(product: element)),
      child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
              color: AppColors.aliceBlue,
              border: Border.all(
                  color: const Color.fromARGB(255, 219, 232, 243),
                  width: 2.0.w),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://kisan-facility.mmssatta.in/api/media/products/${element.image?.path}",
                    height: 100.h,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  // Positioned(
                  //   top: 0,
                  //   right: 0,
                  //   child: Column(
                  //     children: [
                  //       Icon(
                  //         element.isFavorite == true
                  //             ? Icons.favorite
                  //             : Icons.favorite_border_outlined,
                  //         color:
                  //             element.isFavorite == true ? AppColors.red : null,
                  //       ),
                  //       SizedBox(
                  //         height: 5.h,
                  //       ),
                  //       AppText.small("${element.totalLikes}")
                  //     ],
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              AutoSizeText(
                element.name ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                minFontSize: 10,
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text("\u{20B9} "),
                          AppText.small(
                            AppHelpString()
                                .changePrice(element.discountedPrice ?? "0.00"),
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          const Text("\u{20B9} "),
                          AppText.small(
                            AppHelpString().changePrice(
                              element.price.toString(),
                            ),
                            textDecoration: TextDecoration.lineThrough,
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/save-instagram.png",
                    height: 25.h,
                    width: 25.w,
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              AppText.large(
                "You saving \u{20B9} ${element.price * element.discount / 100} on this.",
                fontSize: 12.sp,
                color: AppColors.fireBrick,
              )
            ],
          )),
    );
  }
}
