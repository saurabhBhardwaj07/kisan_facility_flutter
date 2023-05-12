import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/components/dashboard_header.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/option_heading_with_view_all.dart';
import 'package:kisan_facility/components/product_single_item.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/view_model/product_list_provider.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "All Products",
      "Offers",
      "Crop Tonic",
      "Fertilizers",
      "Pesticides",
      "Traps"
    ];

    List<Color> categoriesColor = [
      AppColors.lightGreen,
      AppColors.burlyWood,
      AppColors.darkKhaki,
      AppColors.darkSeaGreen,
      AppColors.lemonChiffon,
      AppColors.lightSteelBlue
    ];

    return Layout(
        showAsset: false,
        child: ListView(
          children: [
            const DashboardHeader(
              centerText: 'Shop',
            ),
            const SizedBox(
              height: 20,
            ),
            const OptionHeadingWithViewAll(
              heading: "Categories",
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: index == 0 ? 0 : 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 65.h,
                            width: 65.w,
                            decoration: BoxDecoration(
                                color: categoriesColor[index],
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(categories[index])
                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            const OptionHeadingWithViewAll(
              heading: "Top Selling Products",
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer(builder: (context, ref, widget) {
              final product = ref.watch(productListProvider);
              return product.when(
                  data: (value) {
                    return GridView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 220.h,
                            mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          if (index < 2) {
                            var element = value[index];
                            return ProductSingleItem(element: element);
                          }
                          return null;
                        });
                  },
                  error: (err, stackTrace) {
                    return Text("error: $err");
                  },
                  loading: () => const SizedBox(
                      height: 40,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: AppColors.chartreuse,
                      )));
            }),
            const SizedBox(
              height: 20,
            ),
            const OptionHeadingWithViewAll(
              heading: "Recommended Products",
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer(builder: (context, ref, widget) {
              final product = ref.watch(productListProvider);
              return product.when(
                  data: (value) {
                    return GridView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 30.h),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 220.h,
                            mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          var element = value[index];
                          return ProductSingleItem(element: element);
                        });
                  },
                  error: (err, stackTrace) {
                    return Text("error: $err");
                  },
                  loading: () => const SizedBox(
                      height: 40,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: AppColors.chartreuse,
                      )));
            })
          ],
        ));
  }
}
