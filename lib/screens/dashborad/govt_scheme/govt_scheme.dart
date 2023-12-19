import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/govt_scheme_list_response.dart';
import 'package:kisan_facility/screens/dashborad/govt_scheme/repository/govt_scheme_repository.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/app_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class GovtSchemeScreen extends StatelessWidget {
  const GovtSchemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final govtSchemeListProvider =
        FutureProvider<List<SingleGovtScheme>>((ref) async {
      final govtRepository = ref.watch(govtSchemeRepositoryProvider);
      List<SingleGovtScheme> video = [];
      final user = await govtRepository.fetchGovtScheme();
      user.fold((l) => showSnackBar(context, l.message), (r) {
        video.addAll(r);
      });
      return video;
    });

    return Layout(
        showAsset: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "Government Scheme",
                  trailing: const SizedBox(),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Consumer(builder: (context, ref, child) {
              final scheme = ref.watch(govtSchemeListProvider);
              return scheme.when(
                  data: (List<SingleGovtScheme> data) {
                    return data.isEmpty
                        ? const Text("No Govt Scheme Found")
                        : Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var element = data[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 15.0.h),
                                    child: Card(
                                      color: AppColors.kPrimaryLightColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                          color: AppColors.kPrimaryColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(TextSpan(
                                                text: element.name ?? "",
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        var uri = Uri.parse(
                                                            element.link ?? "");
                                                        if (await canLaunchUrl(
                                                            uri)) {
                                                          await launchUrl(uri);
                                                        } else {
                                                          throw 'Could not launch $uri';
                                                        }
                                                      },
                                                style: TextStyle(
                                                    fontSize: 20.sp,
                                                    color: AppColors
                                                        .secondaryColor,
                                                    decoration: TextDecoration
                                                        .underline),
                                                children: const [
                                                  TextSpan(
                                                      text:
                                                          "    (Click Here to Visit)",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color: AppColors
                                                              .indianRed))
                                                ])),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(element.description ?? ""),
                                          ],
                                        ),
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
