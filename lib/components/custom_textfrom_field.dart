import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kisan_facility/utils/app_colors.dart';

class CustomTextronField extends StatelessWidget {
  final TextEditingController inputController;
  final String labelText;
  final String hintText;
  final Widget? prefix;
  final bool readOnly;
  final bool hideValidator;
  final int maxline;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  const CustomTextronField(
      {Key? key,
      required this.inputController,
      required this.labelText,
      this.prefix,
      this.hintText = "type here",
      this.inputFormatters,
      this.readOnly = false,
      this.maxline = 1,
      this.hideValidator = false,
      this.onTap,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextFormField(
        controller: inputController,
        maxLines: maxline,
        minLines: maxline == 1 ? 1 : maxline - 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          //Do something wi
        },
        keyboardType: keyboardType ?? TextInputType.text,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        validator: hideValidator == true
            ? null
            : (value) {
                if (value == null || value.isEmpty) {
                  return "Field is required";
                }
                return null;
              },
        onTap: onTap,
        decoration: InputDecoration(
          label: Text(labelText),
          labelStyle: const TextStyle(color: AppColors.primaryColor),
          filled: true,
          fillColor: AppColors.accentColor,
          hintText: hintText,
          prefix: prefix,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.errorColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
