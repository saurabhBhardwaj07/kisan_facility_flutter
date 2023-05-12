import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/model/product_list_response.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/help_string.dart';
import 'package:kisan_facility/utils/text_style.dart';

class ProductSingleItem extends StatelessWidget {
  final ProductListResponse element;

  const ProductSingleItem({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.aliceBlue,
            border: Border.all(
                color: const Color.fromARGB(255, 219, 232, 243), width: 2.0),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: element.productImages[0].url ?? "",
                  height: 100.h,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Icon(
                        element.isFavorite == true
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color:
                            element.isFavorite == true ? AppColors.red : null,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AppText.small("${element.totalLikes}")
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            AppText.medium(
              element.productTitles!,
              fontSize: 14,
            ),
            const SizedBox(
              height: 5,
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
                              .changePrice(element.salesPrice.toString()),
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        const Text("\u{20B9} "),
                        AppText.small(
                          AppHelpString().changePrice(
                            element.regularPrice.toString(),
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
                  height: 25,
                  width: 25,
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            AppText.large(
              "You saving \u{20B9} ${element.regularPrice! - element.salesPrice!} on this.",
              fontSize: 12.sp,
              color: AppColors.fireBrick,
            )
          ],
        ));
  }
}
