import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/crop_practice_list_response.dart';
import 'package:kisan_facility/screens/dashborad/crop_practise/crop_details_screen.dart';
import 'package:kisan_facility/screens/dashborad/crop_practise/repository/crop_practisce_repositary.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';
import 'package:readmore/readmore.dart';

final cropPracticeListProvider =
    FutureProvider<List<SingleCropPractice>>((ref) async {
  final cropRepository = ref.watch(cropPracticeRepositoryProvider);
  List<SingleCropPractice> crop = [];
  final user = await cropRepository.fetchCropPractice();
  user.fold((l) {}, (r) {
    crop.addAll(r);
  });
  return crop;
});

class CropPracticeScreen extends StatelessWidget {
  const CropPracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "Crop Practices",
                  trailing: const SizedBox(),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Consumer(builder: (context, ref, child) {
              final crop = ref.watch(cropPracticeListProvider);
              return crop.when(
                  data: (List<SingleCropPractice> data) {
                    return data.isEmpty
                        ? const Text("No Crop Found")
                        : Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var element = data[index];
                                  return InkWell(
                                    onTap: () {},
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            element.name ?? "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          ReadMoreText(
                                            element.description ?? "",
                                            trimLength: 100,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          GridView.builder(
                                              itemCount: element.crops.length,
                                              shrinkWrap: true,
                                              padding:
                                                  EdgeInsets.only(bottom: 30.h),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 15,
                                                      // mainAxisExtent: 140.h,
                                                      mainAxisSpacing: 15),
                                              itemBuilder: (context, index) {
                                                var x = element.crops[index];
                                                return InkWell(
                                                  onTap: () =>
                                                      AppNavigation.goScreen(
                                                          context,
                                                          CropDetailsScreen(
                                                              crop: x)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: SizedBox(
                                                            height: 120.h,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  "https://kisan-facility.mmssatta.in/api/media/crops/${x.image?.path}",
                                                              width: double
                                                                  .infinity,
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                              fit: BoxFit.cover,
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Text(
                                                        x.name ?? "",
                                                        style: TextStyle(
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                        ]),
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
