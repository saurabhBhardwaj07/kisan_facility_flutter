import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/news_list_response.dart';
import 'package:kisan_facility/screens/dashborad/news/controller/news_controller.dart';
import 'package:kisan_facility/screens/dashborad/news/news_deatil_screen.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
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
                  centerText: "News",
                  trailing: const SizedBox(),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Consumer(builder: (context, ref, child) {
              final news = ref.watch(newsListProvider);
              return news.when(
                  data: (List<SingleNews> data) {
                    return data.isEmpty
                        ? const Text("No News Found")
                        : Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var element = data[index];
                                  return InkWell(
                                    onTap: () => AppNavigation.goScreen(context,
                                        NewsDetailScreen(singleNews: element)),
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 20.0.h),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://kisan-facility.mmssatta.in/api/media/news/${element.image?.path}"),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            element.title ?? "",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                decoration:
                                                    TextDecoration.underline),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                  },
                  error: (Object error, StackTrace stackTrace) {
                    return Text(error.toString());
                  },
                  loading: () => SpinKitWave(
                          itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.red : Colors.green,
                          ),
                        );
                      }));
            })
          ],
        ));
  }
}
