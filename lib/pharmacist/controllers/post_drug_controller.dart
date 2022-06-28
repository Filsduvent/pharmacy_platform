// ignore_for_file: sort_child_properties_last, unnecessary_null_comparison, avoid_print, prefer_const_constructors

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
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/show_custom_snackbar.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';

class PostDrugController extends GetxController {
  static PostDrugController instance = Get.find();

  final Rx<List<Drug>> _drugList = Rx<List<Drug>>([]);
  List<Drug> get drugList => _drugList.value;

  final Rx<List<Drug>> _drugListDel = Rx<List<Drug>>([]);
  List<Drug> get drugListDel => _drugListDel.value;

  final Rx<bool> _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;

  late Rx<File> _file;
  File get drugPhoto => _file.value;

  Rx<File?>? _fileUpdate;
  File? get drugPhotoUpdate => _fileUpdate?.value;

  RxMap _data = {}.obs;
  RxMap get data => _data;

//Method to fetch all data

  @override
  onInit() async {
    super.onInit();
    _drugList.bindStream(FirebaseFirestore.instance
        .collection('Medicines')
        .where('uid',
            isEqualTo:
                AppConstants.sharedPreferences!.getString(AppConstants.userUID))
        .where('visibility', isEqualTo: true)
        //.limit(5)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Drug> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Drug.fromSnap(element),
        );

        _isLoaded.value = true;
      }
      return retVal;
    }));

    _drugListDel.bindStream(FirebaseFirestore.instance
        .collection('Medicines')
        .where('uid',
            isEqualTo:
                AppConstants.sharedPreferences!.getString(AppConstants.userUID))
        .where('visibility', isEqualTo: false)
        //.limit(5)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Drug> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Drug.fromSnap(element),
        );

        _isLoaded.value = true;
      }
      return retVal;
    }));
  }

// onReady method

  @override
  void onReady() {
    super.onReady();
    getDrugData();
  }

  //Get Drug data from firebase
  Future<void> getDrugData() async {
    try {
      final response = await firestore
          .collection('Medicines')
          .doc(AppConstants.sharedPreferences!.getString(AppConstants.drugId))
          .get();

      if (response.exists) {
        _data.value = response.data() as Map;
      }
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

//pick image dialog to Update in storage

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
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
      Get.toNamed(RouteHelper.pharmacyPostDrug);
    } else {
      Get.snackbar('Profile Picture', 'errrooooooooooooooooooooooor!');
    }

    _file = Rx<File>(File(imageFile!.path));
  }

// pick from galery to add in storage

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

    _file = Rx<File>(File(imageFile!.path));
  }

  // upload image to firebase storage

  Future<String> _uploadToStorage(File image, String id) async {
    Reference ref = firebaseStorage.ref().child('drugPhoto').child(id);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //Upload drug item to cloud firestore

  Future<void> uploadDrugItem(
    String id,
    String title,
    String manufacturingDate,
    String expiringDate,
    File? photoUrl,
    String categories,
    int price,
    String description,
  ) async {
    _isLoaded.value = true;
    try {
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
      } else if (price == null) {
        showCustomSnackBar("Fill your price please", title: "price");
      } else if (description.isEmpty) {
        showCustomSnackBar("Fill your description please",
            title: "description");
      } else if (photoUrl == null) {
        showCustomSnackBar("Choose an image", title: "Image");
      } else {
        String uid = firebaseAuth.currentUser!.uid;

        String downloadUrl = await _uploadToStorage(photoUrl, id);

        Drug drug = Drug(
          id: id,
          title: title,
          manufacturingDate: manufacturingDate,
          expiringDate: expiringDate,
          photoUrl: downloadUrl,
          categories: categories,
          price: price,
          uid: uid,
          publishedDate: DateTime.now().toString(),
          status: "Available",
          description: description,
          visibility: true,
        );
        firestore
            .collection('Medicines')
            .doc(id)
            .set(
              drug.toJson(),
            )
            .then((value) async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString(AppConstants.drugId, id);
        });
        Get.toNamed(RouteHelper.getPharmacyMedecinePage());
        _isLoaded.value = false;
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Create drug item",
      );
    }
  }
  /*==============================================Update Drug=====================================*/

  //pick image dialog to Update in storage

  pickImageUpdate(uContext) {
    return showDialog(
        context: uContext,
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
                onPressed: capturePhotoWithCameraUpdate,
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
                onPressed: pickPhotoFromGalleryUpdate,
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

  //capture to Update in storage

  capturePhotoWithCameraUpdate() async {
    navigator!.pop();
    final imageFiles = (await ImagePicker().pickImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0));
    if (imageFiles != null) {
      Get.snackbar(
          'Medicine Picture', 'You have successfully selected your  picture!');
    } else {
      Get.snackbar('Medicine Picture', 'errrooooooooooooooooooooooor!');
    }

    _fileUpdate = Rx<File?>(File(imageFiles!.path));
  }

  // pick from galery to Update in storage

  pickPhotoFromGalleryUpdate() async {
    navigator!.pop();
    final imageFiles =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (imageFiles != null) {
      Get.snackbar('Medicine Picture',
          'You have successfully selected your profile picture!');
    } else {
      Get.snackbar('Medicine Picture', 'errrooooooooooooooooooooooor!');
    }

    _fileUpdate = Rx<File?>(File(imageFiles!.path));
  }

  // upload to Update image to firebase storage

  Future<String> _uploadToStorageUpdate(File images, String id) async {
    Reference ref = firebaseStorage.ref().child('drugPhoto').child(id);

    UploadTask uploadTask = ref.putFile(images);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //Update Drug data method

  Future updateDrugDataList(
    String id,
    String title,
    String manufacturingDate,
    String expiringDate,
    File? photoUrl,
    String categories,
    int price,
    String description,
  ) async {
    try {
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
      } else if (price == null) {
        showCustomSnackBar("Fill your price please", title: "price");
      } else if (description.isEmpty) {
        showCustomSnackBar("Fill your description please",
            title: "description");
      } else if (photoUrl == null) {
        showCustomSnackBar("Choose an image", title: "Image");
      } else {
        String uid = firebaseAuth.currentUser!.uid;

        String downloadUrlUpdate = await _uploadToStorageUpdate(photoUrl, id);

        Drug drug = Drug(
          id: id,
          title: title,
          manufacturingDate: manufacturingDate,
          expiringDate: expiringDate,
          photoUrl: downloadUrlUpdate,
          categories: categories,
          price: price,
          uid: uid,
          publishedDate: DateTime.now().toString(),
          status: "Available",
          description: description,
          visibility: true,
        );
        firestore.collection('Medicines').doc(id).update(
              drug.toJson(),
            );
        Get.offAllNamed(RouteHelper.getPharmacyMedecinePage());
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Updating drug item",
      );
    }
    _isLoaded.value = false;
  }

/*========================================Delete=============================*/
  Future<void> deleteDrug() async {
    try {
      await firestore
          .collection('Medicines')
          .doc(AppConstants.sharedPreferences!.getString(AppConstants.drugId))
          .delete();
      Get.toNamed(RouteHelper.getPharmacyMedecinePage());
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Deleting drug item",
      );
    }
  }

  Future deleteByChangeVisibility() async {
    try {
      _isLoaded.value = true;
      await firestore
          .collection('Medicines')
          .doc(AppConstants.sharedPreferences!.getString(AppConstants.drugId))
          .update({
        'visibility': false,
      });
      Get.offAllNamed(RouteHelper.getPharmacyMedecinePage());
      _isLoaded.value = false;
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Deleting drug item",
      );
    }
  }
}
