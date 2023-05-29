import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/product_single_item.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/product_response.dart';

class ProductListScreen extends StatelessWidget {
  final String title;
  final List<SingleProduct> products;
  const ProductListScreen(
      {super.key, required this.products, required this.title});

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
                  centerText: title,
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
                  itemCount: products.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 30.h),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 240.h,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    var element = products[index];
                    return ProductSingleItem(element: element);
                  }),
            )
          ],
        ));
  }
}
