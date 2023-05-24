import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/address_list_response.dart';
import 'package:kisan_facility/screens/dashborad/address/add_address_screen.dart';
import 'package:kisan_facility/screens/dashborad/address/controller/address_controller.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class AddressScreen extends ConsumerStatefulWidget {
  final bool isEditable;
  const AddressScreen({super.key, this.isEditable = false});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddressScreen> {
  @override
  void didChangeDependencies() {
    Future.delayed(Duration(milliseconds: 1200)).then((value) =>
        ref.read(addressControllerProvider.notifier).getUserAddress(context));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "Your Address",
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () =>
                        AppNavigation.goScreen(context, AddAddressScreen()),
                  ),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: const Icon(Icons.arrow_back_ios),
                      ))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Builder(builder: (context) {
              final loading = ref.watch(addressControllerProvider);
              final addressList = ref.watch(userAddressList);
              return loading == true
                  ? SpinKitWave(itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven ? Colors.red : Colors.green,
                        ),
                      );
                    })
                  : addressList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 25),
                          child: const Text(
                              "You have not add address Yet! \n click on + icon to add address"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: addressList.length,
                          itemBuilder: (context, index) {
                            var element = addressList[index];
                            return AddressSingleItem(
                                address: element,
                                isEditable: widget.isEditable);
                          });
            })
          ],
        ));
  }
}

class AddressSingleItem extends StatelessWidget {
  final SingleAddress address;
  final bool isEditable;

  const AddressSingleItem(
      {super.key, required this.address, this.isEditable = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.bisque,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            address.isDefault == "1"
                ? const Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Is Default",
                      style: TextStyle(
                          color: AppColors.blue, fontWeight: FontWeight.w700),
                    ),
                  )
                : const SizedBox(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(address.address.toString()),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(address.city ?? ""),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(address.state ?? ""),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(address.country ?? ""),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text("pincode: ${address.pincode}")
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => AppNavigation.goScreen(
                            context,
                            AddAddressScreen(
                              isEditable: true,
                              address: address,
                            )),
                        icon: Icon(Icons.edit)),
                    SizedBox(
                      height: 10.h,
                    ),
                    Consumer(builder: (context, ref, child) {
                      return IconButton(
                          onPressed: () {
                            ref
                                .watch(addressControllerProvider.notifier)
                                .deleteAddress(address.id ?? "", context);
                          },
                          icon: Icon(Icons.delete));
                    })
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
