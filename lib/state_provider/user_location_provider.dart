import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/pos_input_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:kisan_facility/model/place_mark_location.dart';
import 'package:kisan_facility/screens/dashborad/weather/weather_screen.dart';
import 'package:kisan_facility/service/location/location_service.dart';
import 'package:kisan_facility/utils/app_colors.dart';

final userLocationProvider =
    StateNotifierProvider<UserLocationController, PlaceMarkLocation?>(
        (ref) => UserLocationController(ref: ref));

class UserLocationController extends StateNotifier<PlaceMarkLocation?> {
  final Ref _ref;
  UserLocationController({required Ref ref})
      : _ref = ref,
        super(null);

  void fetchUserLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled == false) {
      if (context.mounted) {
        return showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            title: const Text(
              "Kisan Facility need your location access to fetch Weather",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: AppColors.white,
            children: <Widget>[
              TextButton(
                child: const Text(" Approve",
                    style: const TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.bold)),
                onPressed: () async {
                  bool permission = await Geolocator.openLocationSettings();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Ignore",
                    style: const TextStyle(color: AppColors.kPrimaryColor)),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        );
      }
    }
    Position? position = await determineUserPosition();
    List<Placemark> locations =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    print("${position.latitude} ${position.longitude}");

    PlaceMarkLocation location = PlaceMarkLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        locality: locations[0].locality ?? "",
        administrativeArea: locations[0].administrativeArea ?? "",
        postalCode: locations[0].postalCode ?? "");

    state = location;
  }
}
