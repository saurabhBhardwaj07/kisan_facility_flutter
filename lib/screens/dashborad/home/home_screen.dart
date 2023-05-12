// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/components/dashboard_header.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/option_heading_with_view_all.dart';
import 'package:kisan_facility/components/product_single_item.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/view_model/product_list_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HomeCategories> homeCategories = [];
  PageController imageController = PageController();

  List<Color> colors = [
    AppColors.aquamarine,
    AppColors.azure,
    AppColors.beige,
    AppColors.bisque
  ];
  int _currPageValue = 0;

  Timer? _timer;

  @override
  void initState() {
    addHomeCategories();
    imageController =
        PageController(initialPage: _currPageValue, viewportFraction: 1.02);

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currPageValue < 3) {
        _currPageValue++;
      } else {
        _currPageValue = 0;
      }
      imageController.animateToPage(
        _currPageValue,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: ListView(
          controller: _controller,
          children: [
            const DashboardHeader(
              centerText: "Kisan Facility",
            ),
            SizedBox(
              height: 200,
              child: PageView.builder(
                  itemCount: colors.length,
                  physics: const BouncingScrollPhysics(),
                  controller: imageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (page) {
                    _currPageValue = page;
                  },
                  itemBuilder: (context, position) {
                    return InkWell(
                        onTap: () {},
                        child: Container(
                          height: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: colors[position],
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(" Highlighted Poster"),
                          ),
                        ));
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 80,
                    mainAxisSpacing: 8),
                itemCount: homeCategories.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext ctx, index) {
                  var element = homeCategories[index];
                  return Card(
                    shadowColor: AppColors.kPrimaryLightColor,
                    elevation: 5,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            element.assetsPath,
                            height: 30,
                            width: 30,
                          ),
                          const Spacer(),
                          Text(
                            element.text,
                            style: const TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  );
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
                        itemCount: value.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 30.h),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 240.h,
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

  void addHomeCategories() {
    homeCategories.clear();
    homeCategories.add(HomeCategories(
        id: 1, assetsPath: "assets/images/cart.png", text: "Shop"));
    homeCategories.add(HomeCategories(
        id: 2, assetsPath: "assets/images/sprout.png", text: "Crop Practices"));
    homeCategories.add(HomeCategories(
        id: 3,
        assetsPath: "assets/images/government.png",
        text: "Govt. Schemes"));
    homeCategories.add(HomeCategories(
        id: 4, assetsPath: "assets/images/cloudy.png", text: "Weather"));
    homeCategories.add(HomeCategories(
        id: 5, assetsPath: "assets/images/newspaper.png", text: "News"));
    homeCategories.add(HomeCategories(
        id: 6, assetsPath: "assets/images/streaming.png", text: "Videos"));
  }
}

class HomeCategories {
  int id;
  String assetsPath;
  String text;
  HomeCategories({
    required this.id,
    required this.assetsPath,
    required this.text,
  });
}
