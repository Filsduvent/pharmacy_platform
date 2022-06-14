// ignore_for_file: sort_child_properties_last, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';

import '../../utils/colors.dart';

class PostDrugController extends GetxController {
  static PostDrugController instance = Get.find();

  Rx<File?>? _file;
  File? get drugPhoto => _file?.value;

  pickImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (con) {
          return SimpleDialog(
            title: BigText(
              text: "First Select the Image",
              color: AppColors.mainBlackColor,
              size: Dimensions.font20,
            ),
            children: [
              SimpleDialogOption(
                child: BigText(
                  text: "Capture with Camera",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font16,
                ),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: BigText(
                  text: "Select from Gallery",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font16,
                ),
                onPressed: pickPhotoFromGallery,
              ),
              TextButton(
                  onPressed: () => Get.back(),
                  child: BigText(
                    text: "Cancel",
                    color: AppColors.mainColor,
                  ))
            ],
          );
        });
  }

  capturePhotoWithCamera() async {
    navigator!.pop();
    final imageFile = (await ImagePicker().pickImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0));
    if (imageFile != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
      Get.toNamed(RouteHelper.pharmacyPostDrug);
    } else {
      Get.snackbar('Profile Picture', 'errrooooooooooooooooooooooor!');
    }

    _file = Rx<File?>(File(imageFile!.path));
  }

  pickPhotoFromGallery() async {
    navigator!.pop();
    final imageFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (imageFile != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
      Get.toNamed(RouteHelper.pharmacyPostDrug);
    } else {
      Get.snackbar('Profile Picture', 'errrooooooooooooooooooooooor!');
    }

    _file = Rx<File?>(File(imageFile!.path));
  }
}
