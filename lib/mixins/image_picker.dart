import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisan_facility/utils/app_colors.dart';

typedef ImageSelectedCallback = Function(File selectedFile);

mixin ImagePickerMixin {
  void showImagePickerOptions(BuildContext context, ImagePicker _picker,
      ImageSelectedCallback callback) {
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.antiqueWhite,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(
                  "Camera",
                ),
                leading: const Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                onTap: () {
                  _launchImagePicker(
                      context, _picker, ImageSource.camera, callback);
                },
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  _launchImagePicker(
                      context, _picker, ImageSource.gallery, callback);
                },
                title: const Text(
                  "Gallery",
                ),
                leading: const Icon(
                  Icons.photo,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        });
  }

  void _launchImagePicker(BuildContext context, ImagePicker _picker,
      ImageSource source, ImageSelectedCallback returnedFile) async {
    XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.kPrimaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 50,
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );

    if (croppedFile != null) {
      returnedFile(croppedFile);
      // _uploadProfilePic(croppedFile);
    }
  }
}
