import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/user_order_response.dart';
import 'package:kisan_facility/screens/dashborad/shop/repository/shop_repository.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/help_string.dart';
import 'package:kisan_facility/utils/text_style.dart';

final userOderListProvider = FutureProvider<List<SingeUserOrder>>((ref) async {
  final shopRepository = ref.watch(shopRepositoryProvider);
  List<SingeUserOrder> orderList = [];
  final orderResp = await shopRepository.getUserOrder();
  orderResp.fold((l) {}, (r) {
    orderList.addAll(r);
  });
  return orderList;
});

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "My Orders",
                  trailing: SizedBox(),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                final location = ref.watch(userOderListProvider);
                return location.when(
                    data: (List<SingeUserOrder> data) {
                      return data.isEmpty
                          ? const Text("No Weather Found")
                          : ListView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var element = data[index];
                                return Card(
                                  color: AppColors.kPrimaryLightColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: AppColors.kPrimaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ...element.orderProducts
                                            .map((e) => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AutoSizeText(
                                                      e.product?.name ?? "",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      maxLines: 1,
                                                      minFontSize: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        AppText.small(
                                                          "\u{20B9} ${AppHelpString().changePrice(
                                                            e.price.toString(),
                                                          )}",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            "Size: ${e.product?.size}"),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            "Qty: ${e.quantity}")
                                                      ],
                                                    ),
                                                  ],
                                                ))
                                            .toList(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Delivery Address",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(element.address?.city ?? ""),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(element.address?.state ?? ""),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(element.address?.country ?? ""),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                            "pincode: ${element.address?.pincode}")
                                      ],
                                    ),
                                  ),
                                );
                              });
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
            )
          ],
        ));
  }
}
