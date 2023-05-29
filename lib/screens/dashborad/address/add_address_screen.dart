import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/components/custom_rounded_button.dart';
import 'package:kisan_facility/components/custom_textfrom_field.dart';
import 'package:kisan_facility/components/layout.dart' as appLayout;
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/mixins/selectable_sheet_mixin.dart';
import 'package:kisan_facility/model/address_list_response.dart';
import 'package:kisan_facility/screens/dashborad/address/controller/address_controller.dart';

class AddAddressScreen extends StatefulWidget {
  final bool isEditable;
  final SingleAddress? address;
  const AddAddressScreen({super.key, this.isEditable = false, this.address});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  String countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  final TextEditingController addressCtr = TextEditingController();
  final TextEditingController pinCodeCtr = TextEditingController();
  final TextEditingController addressTypeCtr = TextEditingController();
  int isDefault = 0;

  List<String> addressType = ["Home", "Office", "Random"];

  void addAdress(WidgetRef ref) {
    ref.read(addressControllerProvider.notifier).addNewAddress(
        context,
        addressTypeCtr.text,
        addressCtr.text,
        countryValue,
        stateValue ?? "",
        cityValue ?? "",
        pinCodeCtr.text,
        isDefault.toString(),
        isEditable: widget.isEditable,
        id: widget.address?.id);
  }

  @override
  void initState() {
    if (widget.address != null) {
      countryValue = widget.address?.country ?? "";
      stateValue = widget.address?.state ?? "";
      cityValue = widget.address?.city ?? "";
      addressCtr.text = widget.address?.address ?? "";
      pinCodeCtr.text = widget.address?.pincode ?? "";
      addressTypeCtr.text = widget.address?.name ?? "";
      isDefault = widget.address?.isDefault == "1" ? 1 : 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return appLayout.Layout(
        showAsset: false,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "Add Address",
                  trailing: const SizedBox(),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 20.h,
            ),
            CSCPicker(
              layout: Layout.vertical,
              defaultCountry: CscCountry.India,
              currentCountry: "India",
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged: (value) {
                setState(() {
                  stateValue = value;
                });
              },
              onCityChanged: (value) {
                setState(() {
                  cityValue = value;
                });
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextronField(
              inputController: addressCtr,
              labelText: "Addresses",
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextronField(
              inputController: pinCodeCtr,
              labelText: "PinCode",
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextronField(
              inputController: addressTypeCtr,
              labelText: "Address Type",
              readOnly: true,
              onTap: () => SelectableSheetMixin.showTypeForSelect((type) {
                addressTypeCtr.text = type;
              }, context, addressType),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              children: [
                Checkbox(
                    value: isDefault == 0 ? false : true,
                    onChanged: (v) {
                      if (v == true) {
                        isDefault = 1;
                      }

                      if (v == false) {
                        isDefault = 0;
                      }

                      setState(() {});
                    }),
                SizedBox(
                  width: 20.w,
                ),
                const Text("Set As Default")
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Consumer(builder: (context, ref, child) {
              final loading = ref.watch(addressControllerProvider);
              return CustomRoundedButton(
                  loading: loading,
                  centerText: "Add Address",
                  onPressed: () => addAdress(ref));
            })
          ],
        ));
  }
}
