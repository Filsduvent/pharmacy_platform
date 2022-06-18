// ignore_for_file: sort_child_properties_last, unnecessary_null_comparison

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';

import '../../base/show_custom_snackbar.dart';
import '../../utils/app_constants.dart';
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

  // upload image to firebase storage
  Future<String> _uploadToStorage(File image, String id) async {
    Reference ref = firebaseStorage.ref().child('drugPhoto').child(id);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadDrugItem(
    String id,
    String title,
    String manufacturingDate,
    String expiringDate,
    File? photoUrl,
    String categories,
    String price,
    String description,
  ) async {
    try {
      /*if (id.isNotEmpty &&
          title.isNotEmpty &&
          manufacturingDate.isNotEmpty &&
          expiringDate.isNotEmpty &&
          photoUrl != null &&
          categories.isNotEmpty &&
          price.isNotEmpty &&
          description.isNotEmpty) {
        showCustomSnackBar("Fill empty fields", title: "Fields");
      } */
      if (id.isEmpty) {
        showCustomSnackBar("Fill your id please", title: "id");
      } else if (title.isEmpty) {
        showCustomSnackBar("Fill your title please", title: "title");
      } else if (manufacturingDate.isEmpty) {
        showCustomSnackBar("Fill manufacturing date  please",
            title: "man date");
      } else if (expiringDate.isEmpty) {
        showCustomSnackBar("Fill your expiring date please", title: "exp date");
      } else if (categories.isEmpty) {
        showCustomSnackBar("Fill your category please", title: "category");
      } else if (price.isEmpty) {
        showCustomSnackBar("Fill your price please", title: "price");
      } else if (description.isEmpty) {
        showCustomSnackBar("Fill your description please",
            title: "description");
      } else if (photoUrl == null) {
        showCustomSnackBar("Choose an image", title: "Image");
      } else {
        String uid = firebaseAuth.currentUser!.uid;
        DocumentSnapshot userDoc =
            await firestore.collection('Users').doc(uid).get();

        String downloadUrl = await _uploadToStorage(photoUrl, id);

        Drug drug = Drug(
          id: id,
          title: title,
          manufacturingDate: manufacturingDate,
          expiringDate: expiringDate,
          photoUrl: downloadUrl,
          categories: categories,
          price: price as int,
          uid: uid,
          publishedDate: DateTime.now().toString(),
          status: "Available",
          description: description,
        );
        firestore.collection('Medicines').doc(id).set(
              drug.toJson(),
            );
        Get.toNamed(RouteHelper.getPharmacyMedecinePage());
      }
    } catch (e) {
      showCustomSnackBar(
        'Error Uploading Item',
        title: "Create drug item",
      );
    }
  }
}
