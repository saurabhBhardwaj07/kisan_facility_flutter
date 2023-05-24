import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/weather_response.dart';
import 'package:kisan_facility/screens/dashborad/weather/repository/weather_repository.dart';
import 'package:kisan_facility/state_provider/user_location_provider.dart';
import 'package:kisan_facility/utils/app_colors.dart';

final dailyWeatherListProvider =
    FutureProvider<List<SingleDayWeather>>((ref) async {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final location = ref.watch(userLocationProvider);
  List<SingleDayWeather> weatherList = [];
  final weather = await weatherRepository.fetchThreeDayWeather(
      location!.latitude, location.longitude);
  weather.fold((l) {}, (r) {
    weatherList.addAll(r);
  });

  return weatherList;
});

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  @override
  void didChangeDependencies() {
    final location = ref.read(userLocationProvider);
    if (location == null) {
      ref.read(userLocationProvider.notifier).fetchUserLocation(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "Weather",
                  trailing: const SizedBox(),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Consumer(builder: (context, reff, child) {
              final location = reff.watch(dailyWeatherListProvider);
              return location.when(
                  data: (List<SingleDayWeather> data) {
                    return data.isEmpty
                        ? const Text("No Weather Found")
                        : Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var element = data[index];
                                  return Card(
                                    color: AppColors.whiteSmoke,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(DateFormat.yMd()
                                                  .format(DateTime.parse(
                                                      element.date.toString()))
                                                  .toString()),
                                              Spacer(),
                                              Text(element.hourly[0]
                                                      .weatherDesc![0].value ??
                                                  ""),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Temp: ${element.maxtempC}\u2103 /${element.mintempC}\u2103"),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      "Total Sun Hour : ${element.sunHour}"),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      "Sunrise : ${element.astronomy![0].sunrise}"),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      "Sunset : ${element.astronomy![0].sunset}"),
                                                ],
                                              ),
                                              Spacer(),
                                              Image.network(element
                                                      .hourly[0]
                                                      .weatherIconUrl![0]
                                                      .value ??
                                                  "")
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }));
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
            }),
            SizedBox(
              height: 20.h,
            ),
          ],
        ));
  }
}
