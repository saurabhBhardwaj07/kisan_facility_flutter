import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/components/custom_rounded_button.dart';
import 'package:kisan_facility/components/custom_textfrom_field.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/screens/dashborad/menu_screen.dart/repository/menu_screen_repository.dart';
import 'package:kisan_facility/service/notification/local_notification_service.dart';
import 'package:kisan_facility/utils/app_snackbar.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController fullNameCtr = TextEditingController();
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController detailsIssueCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var loading = false;

  void contactUsData(WidgetRef ref, BuildContext context) async {
    final repo = ref.read(menuScreenRepository);
    setState(() {
      loading = true;
    });
    var resp = await repo.contactUsForm(
        fullNameCtr.text, emailCtr.text, detailsIssueCtr.text);

    setState(() {
      loading = false;
    });
    resp.fold((l) => showSnackBar(context, l.message), (r) {
      LocalNotificationService.showBigTextNotification(
          title: "You Query is submit",
          body: "No worries we connect with you soon");
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "Contact Us",
                  trailing: const SizedBox(),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                              "Kisan Facility Products Pvt. Ltd. V.S. Khandekar Marg, Vile Parle East, Mumbai - 400057, Maharashtra. Tel: 022-6713 0300. Fax: 022-6691 6926."),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.call),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text("9304675594"),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.mail),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text("support@kisanFaclity.com"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextronField(
                      inputController: fullNameCtr, labelText: "Full Name"),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextronField(
                      inputController: emailCtr, labelText: "Email"),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextronField(
                      inputController: detailsIssueCtr,
                      maxline: 5,
                      labelText: "Details of the issue"),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Consumer(builder: (context, ref, child) {
                  return CustomRoundedButton(
                      loading: loading,
                      centerText: "Submit",
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        contactUsData(ref, context);
                      });
                }))
          ],
        ));
  }
}
