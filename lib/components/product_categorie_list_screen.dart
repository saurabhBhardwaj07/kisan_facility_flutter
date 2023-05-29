import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/product_list_screen.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/product_categories_response.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class ProductCategoriesListScreen extends StatefulWidget {
  final List<SingleCategory> category;
  const ProductCategoriesListScreen({super.key, required this.category});

  @override
  State<ProductCategoriesListScreen> createState() =>
      _ProductCategoriesListScreenState();
}

class _ProductCategoriesListScreenState
    extends State<ProductCategoriesListScreen> {
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
  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "Category",
                  trailing: const SizedBox(),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: widget.category.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 30.h),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 240.h,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    var element = widget.category[index];
                    return InkWell(
                      onTap: () => AppNavigation.goScreen(
                          context,
                          ProductListScreen(
                              products: element.products,
                              title: element.name ?? "")),
                      child: Padding(
                        padding:
                            EdgeInsets.only(right: index == 0 ? 0 : 20.0.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 65.h,
                              width: 65.w,
                              decoration: BoxDecoration(
                                  color: categoriesColor[index],
                                  borderRadius: BorderRadius.circular(50.r)),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(element.name ?? "")
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
