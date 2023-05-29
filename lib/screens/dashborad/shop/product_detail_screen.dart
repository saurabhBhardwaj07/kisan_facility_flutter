import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/components/custom_rounded_button.dart';
import 'package:kisan_facility/components/dashboard_header.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/product_response.dart';
import 'package:kisan_facility/screens/dashborad/shop/add_to_cart_bottom_sheet.dart';
import 'package:kisan_facility/screens/dashborad/shop/cart/cart_screen.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/help_string.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';
import 'package:kisan_facility/utils/text_style.dart';

class ProductDetailScreen extends StatelessWidget {
  final SingleProduct product;
  ProductDetailScreen({super.key, required this.product});

  int simpleIntInput = 1;
  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "Product Detail",
                  trailing: InkWell(
                      onTap: () =>
                          AppNavigation.goScreen(context, const CartScreen()),
                      child: const AppCartIcon()),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: ListView(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://kisan-facility.mmssatta.in/api/media/products/${product.image?.path}",
                    height: 200.h,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AutoSizeText(
                    product.name ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    minFontSize: 15,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppText.medium(
                        AppHelpString()
                            .changePrice(product.discountedPrice ?? "0.00"),
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AppText.small(
                        AppHelpString().changePrice(
                          product.price.toString(),
                        ),
                        textDecoration: TextDecoration.lineThrough,
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/images/save-instagram.png",
                        height: 25.h,
                        width: 25.w,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Divider(
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Description',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.sp),
                    ),
                    tilePadding: const EdgeInsets.all(0),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: const EdgeInsets.all(0),
                    children: <Widget>[
                      Text(
                        product.description ?? "",
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Uses',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.sp),
                    ),
                    tilePadding: const EdgeInsets.all(0),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: const EdgeInsets.all(0),
                    children: <Widget>[
                      Text(
                        product.uses ?? "",
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Composition',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.sp),
                    ),
                    tilePadding: const EdgeInsets.all(0),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: const EdgeInsets.all(0),
                    children: <Widget>[
                      Text(
                        product.composition ?? "",
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0, top: 10),
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Expanded(
                    child: CustomRoundedButton(
                        centerText: "Add To  Cart",
                        onPressed: () {
                          showSheet(
                              context,
                              AddToCartBottomSheet(
                                product: product,
                                count: simpleIntInput,
                                cartCountCallBack: (int cart) {
                                  simpleIntInput = cart;
                                },
                              ));
                        }),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void showSheet(context, Widget bottomSheet) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColors.mistyRose,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0.r),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return bottomSheet;
        });
  }
}
