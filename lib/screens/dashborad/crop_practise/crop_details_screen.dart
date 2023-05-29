import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/crop_practice_list_response.dart';

class CropDetailsScreen extends StatelessWidget {
  final Crops crop;

  const CropDetailsScreen({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TopWidget(
                    centerText: crop.name ?? "",
                    trailing: const SizedBox(),
                    leading: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios))),
              ),
              SizedBox(
                height: 20.h,
              ),
              CachedNetworkImage(
                imageUrl:
                    "https://kisan-facility.mmssatta.in/api/media/crops/${crop.image?.path}",
                width: double.infinity,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20.h,
              ),
              ExpansionTile(
                title: Text(
                  "Introduction",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
                ),
                tilePadding: const EdgeInsets.all(0),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                childrenPadding: const EdgeInsets.all(0),
                children: <Widget>[
                  Text(
                    crop.introduction ?? "",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              ExpansionTile(
                title: Text(
                  'Climate',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
                ),
                tilePadding: const EdgeInsets.all(0),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                childrenPadding: const EdgeInsets.all(0),
                children: <Widget>[
                  Text(
                    crop.climate ?? "",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              ExpansionTile(
                title: Text(
                  'Soil',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
                ),
                tilePadding: const EdgeInsets.all(0),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                childrenPadding: const EdgeInsets.all(0),
                children: <Widget>[
                  Text(crop.soil ?? ""),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              ExpansionTile(
                title: Text(
                  'Season',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
                ),
                tilePadding: const EdgeInsets.all(0),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                childrenPadding: const EdgeInsets.all(0),
                children: <Widget>[
                  Text(crop.season ?? ""),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ));
  }
}
