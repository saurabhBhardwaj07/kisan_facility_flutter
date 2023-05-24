import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/model/news_list_response.dart';
import 'package:kisan_facility/utils/app_colors.dart';

import '../../../components/top_widget.dart';

class NewsDetailScreen extends StatelessWidget {
  final SingleNews singleNews;
  const NewsDetailScreen({super.key, required this.singleNews});

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "News Detail",
                  trailing: const SizedBox(),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        imageUrl:
                            "https://kisan-facility.mmssatta.in/api/media/news/${singleNews.image?.path}"),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    singleNews.title ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Text(
                    "Details News",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.aquamarine),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    singleNews.content ?? "",
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
