// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();

  final Rx<bool> _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;

  late Rx<File> _file;
  File get drugPhoto => _file.value;

  //pick image dialog to upload in storage

  pickImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (con) {
          return SimpleDialog(
            title: BigText(
              text: "Select an Image",
              color: AppColors.mainBlackColor,
              size: Dimensions.font20,
            ),
            children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.camera_alt),
                    Padding(padding: EdgeInsets.all(7.0)),
                    BigText(
                      text: " Camera",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font16,
                    ),
                  ],
                ),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.image),
                    Padding(padding: EdgeInsets.all(7.0)),
                    BigText(
                      text: " Gallery",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font16,
                    ),
                  ],
                ),
                onPressed: pickPhotoFromGallery,
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.cancel),
                    Padding(padding: EdgeInsets.all(7.0)),
                    BigText(
                      text: " Cancel",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font16,
                    ),
                  ],
                ),
                onPressed: () => Get.back(),
              ),
            ],
          );
        });
  }

  //capture to add in storage

  capturePhotoWithCamera() async {
    navigator!.pop();
    final imageFile = (await ImagePicker().pickImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0));
    if (imageFile != null) {
      Get.snackbar('Category Picture',
          'You have successfully selected your category picture!');
      Get.toNamed(RouteHelper.getPostCategoryForm());
    } else {
      Get.snackbar('Category Picture', 'Please try again!');
    }

    _file = Rx<File>(File(imageFile!.path));
  }

// pick from galery to add in storage

  pickPhotoFromGallery() async {
    navigator!.pop();
    final imageFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (imageFile != null) {
      Get.snackbar('Category Picture',
          'You have successfully selected your category picture!');
      Get.toNamed(RouteHelper.getPostCategoryForm());
    } else {
      Get.snackbar('Category Picture', 'Please try again!');
    }

    _file = Rx<File>(File(imageFile!.path));
    _isLoaded.value = false;
  }

  //Upload category items to firebase

  /* Future uploadDrugItem(
    String name,
    File? photoUrl,
    String description,
  ) async {
    _isLoaded.value = true;
    try {
      if (name.isEmpty) {
        showCustomSnackBar("Fill the category name please", title: "Name");
      } else if (description.isEmpty) {
        showCustomSnackBar("Fill the category description please",
            title: "Description");
      } else if (photoUrl == null) {
        showCustomSnackBar("Choose an image", title: "Image");
      } else {
        String downloadUrl = await _uploadToStorage(photoUrl, name);

        CategoriesModel category = CategoriesModel(
          id: name,
          name: name,
          image: downloadUrl,
          description: description,
        );
        firestore.collection('Medicines').doc(name).set(
              category.tojson(),
            );
        
       // Get.toNamed(RouteHelper.getPharmacyMedecinePage());
        _isLoaded.value = false;
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Create category item",
      );
    }
  }
  */
}
