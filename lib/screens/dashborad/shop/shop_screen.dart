import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kisan_facility/components/dashboard_header.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/option_heading_with_view_all.dart';
import 'package:kisan_facility/components/product_categorie_list_screen.dart';
import 'package:kisan_facility/components/product_list_screen.dart';
import 'package:kisan_facility/components/product_single_item.dart';
import 'package:kisan_facility/screens/dashborad/shop/controller/shop_controller.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';
// import 'package:kisan_facility/state_provider/product_list_provider.dart';

class ShoppingScreen extends ConsumerStatefulWidget {
  const ShoppingScreen({super.key});

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends ConsumerState<ShoppingScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1200)).then((value) =>
        ref.read(shopControllerProvider.notifier).getCategoryList(context));
    super.initState();
  }

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
      AppColors.lightSteelBlue,
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
            InkWell(
              onTap: () => AppNavigation.goScreen(
                  context,
                  ProductCategoriesListScreen(
                      category: ref.watch(productCategoryListProvider))),
              child: const OptionHeadingWithViewAll(
                heading: "Categories",
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 100.h,
              child: Builder(builder: (context) {
                final loading = ref.watch(productCategoryLoading);
                final categoryList = ref.watch(productCategoryListProvider);
                return loading == true
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: SpinKitWave(
                            itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: index.isEven ? Colors.red : Colors.green,
                            ),
                          );
                        }),
                      )
                    : ListView.builder(
                        itemCount: categoryList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => AppNavigation.goScreen(
                                context,
                                ProductListScreen(
                                    products: categoryList[index].products,
                                    title: categoryList[index].name ?? "")),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: index == 0 ? 0 : 20.0.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 65.h,
                                    width: 65.w,
                                    decoration: BoxDecoration(
                                        color: categoriesColor[index],
                                        borderRadius:
                                            BorderRadius.circular(50.r)),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(categoryList[index].name ?? "")
                                ],
                              ),
                            ),
                          );
                        });
              }),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () => AppNavigation.goScreen(
                  context,
                  ProductListScreen(
                      products: ref.watch(productListProvider),
                      title: "Top Selling Products")),
              child: const OptionHeadingWithViewAll(
                heading: "Top Selling Products",
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Builder(builder: (context) {
              return Consumer(builder: (context, ref, widget) {
                final loading = ref.watch(shopControllerProvider);
                final productList = ref.watch(topSellingProductProvider);

                return loading == true
                    ? SpinKitWave(
                        itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.red : Colors.green,
                          ),
                        );
                      })
                    : productList.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 25),
                            child: Text("No Product"),
                          )
                        : GridView.builder(
                            itemCount: productList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 30.h),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 240.h,
                                    mainAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              var element = productList[index];
                              return ProductSingleItem(element: element);
                            });
              });
            }),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () => AppNavigation.goScreen(
                  context,
                  ProductListScreen(
                      products: ref.watch(productListProvider),
                      title: "Recommended Products")),
              child: const OptionHeadingWithViewAll(
                heading: "Recommended Products",
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Builder(builder: (context) {
              return Consumer(builder: (context, ref, widget) {
                final loading = ref.watch(shopControllerProvider);
                final productList = ref.watch(recommendedProductProvider);

                return loading == true
                    ? SpinKitWave(
                        itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.red : Colors.green,
                          ),
                        );
                      })
                    : productList.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 25),
                            child: Text("No Product"),
                          )
                        : GridView.builder(
                            itemCount: productList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 30.h),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 240.h,
                                    mainAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              var element = productList[index];
                              return ProductSingleItem(element: element);
                            });
              });
            }),
          ],
        ));
  }
}
