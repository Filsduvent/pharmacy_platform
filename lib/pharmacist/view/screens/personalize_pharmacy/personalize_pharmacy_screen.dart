// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, unused_import

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../base/show_custom_snackbar.dart';
import '../../../../routes/route_helper.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/app_icon.dart';
import '../../../../widgets/big_text.dart';
// ignore: library_prefixes
import 'package:firebase_storage/firebase_storage.dart' as fStorages;

class PersonalizePharmacyScreen extends StatefulWidget {
  const PersonalizePharmacyScreen({Key? key}) : super(key: key);

  @override
  State<PersonalizePharmacyScreen> createState() =>
      _PersonalizePharmacyScreenState();
}

class _PersonalizePharmacyScreenState extends State<PersonalizePharmacyScreen> {
  File? imageFilex;
  var nameController;
  var addressController;
  String? name = "";
  String? image = "";
  String? address = "";
  String? pharmaImageUrl;

  //Get data from the firebase
  // ignore: unused_element
  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["pharmaName"];
          image = snapshot.data()!["pharmaIcon"];
          address = snapshot.data()!["address"];
        });
      }
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize * 1.8,
              //color: Colors.grey.withOpacity(0.1),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageFilex == null
                        ? NetworkImage(image!)
                        : Image.file(imageFilex!).image,
                  ))),
        ),
        //The back button

        Positioned(
          top: Dimensions.height20 * 2,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getMainPharmacyPage());
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios)),
            ],
          ),
        ),

        // choose photo icon
        Positioned(
          top: Dimensions.height45 * 12,
          left: Dimensions.width45 * 7.5,
          child: GestureDetector(
            onTap: () => _showImageDialog(),
            child: AppIcon(
              icon: Icons.add_a_photo,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height30,
              size: Dimensions.height30 * 2,
            ),
          ),
        ),

        // The white background
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: (Dimensions.popularFoodImgSize) * 1.8,
          child: Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20),
                topLeft: Radius.circular(Dimensions.radius20),
              ),
              color: Colors.grey.withOpacity(0.1),
            ),

            // The content of the white background

            child: Column(children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Pharmacy Name
                      Container(
                        padding: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.width10,
                            bottom: Dimensions.width10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                                color: Colors.grey.withOpacity(0.3),
                              )
                            ]),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppIcon(
                                icon: Icons.local_pharmacy_sharp,
                                backgroundColor: AppColors.yellowColor,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10 * 5 / 2,
                                size: Dimensions.height10 * 5,
                              ),
                              SizedBox(
                                width: Dimensions.width20,
                              ),
                              BigText(text: name!),
                              SizedBox(
                                width: Dimensions.width30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    nameController =
                                        TextEditingController(text: name);
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: BigText(
                                        text: 'Change Name Here',
                                        color: AppColors.secondColor,
                                        size: Dimensions.font20,
                                      ),
                                      content: TextField(
                                        autofocus: false,
                                        controller: nameController,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        decoration: const InputDecoration(
                                          hintText: 'Type in the pharmacy name',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: BigText(
                                            text: "Cancel",
                                            color: AppColors.yellowColor,
                                            size: Dimensions.font20,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _updatePharmaName();
                                          },
                                          child: BigText(
                                            text: "Edit",
                                            color: AppColors.mainColor,
                                            size: Dimensions.font20,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: AppIcon(
                                  icon: Icons.edit,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      //Pharmacy address
                      Container(
                        padding: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.width10,
                            bottom: Dimensions.width10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                                color: Colors.grey.withOpacity(0.3),
                              )
                            ]),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppIcon(
                                icon: Icons.location_on,
                                backgroundColor: AppColors.yellowColor,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10 * 5 / 2,
                                size: Dimensions.height10 * 5,
                              ),
                              SizedBox(
                                width: Dimensions.width20,
                              ),
                              BigText(text: address!),
                              SizedBox(
                                width: Dimensions.width30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    addressController =
                                        TextEditingController(text: address);
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: BigText(
                                        text: 'Change address Here',
                                        color: AppColors.secondColor,
                                        size: Dimensions.font20,
                                      ),
                                      content: TextField(
                                        autofocus: false,
                                        controller: addressController,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.done,
                                        decoration: const InputDecoration(
                                          hintText:
                                              'Type in the pharmacy address',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: BigText(
                                            text: "Cancel",
                                            color: AppColors.yellowColor,
                                            size: Dimensions.font20,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _updatePharmaAddress();
                                          },
                                          child: BigText(
                                            text: "Edit",
                                            color: AppColors.mainColor,
                                            size: Dimensions.font20,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: AppIcon(
                                  icon: Icons.edit,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    ));
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: BigText(
              text: "Please select an option",
              color: AppColors.mainBlackColor,
              size: Dimensions.font20,
            ),
            children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt),
                    const Padding(padding: EdgeInsets.all(7.0)),
                    BigText(
                      text: " Camera",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font16,
                    ),
                  ],
                ),
                onPressed: () {
                  _getFromCamera();
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.image),
                    const Padding(padding: EdgeInsets.all(7.0)),
                    BigText(
                      text: " Gallery",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font16,
                    ),
                  ],
                ),
                onPressed: () {
                  _getFromGallery();
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.cancel),
                    const Padding(padding: EdgeInsets.all(7.0)),
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

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageFilex = File(croppedImage.path);
        _updatePharmaIconInFirestore();
      });
    }
  }

  void _updatePharmaIconInFirestore() async {
    String fileId = DateTime.now().microsecondsSinceEpoch.toString();
    fStorages.Reference reference = fStorages.FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(fileId);
    fStorages.UploadTask uploadTask = reference.putFile(File(imageFilex!.path));
    fStorages.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) async {
      pharmaImageUrl = url;
    });

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'pharmaIcon': pharmaImageUrl});
  }

  Future _updatePharmaName() async {
    try {
      if (nameController.text.isEmpty) {
        showCustomSnackBar("Fill your pharmacy name please", title: "name");
      } else {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'pharmaName': nameController.text}).then((value) {
          Navigator.of(context).pop();
          Get.toNamed(RouteHelper.getMainPharmacyPage());
        });
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Editing pharmacy profile",
      );
    }
  }

  Future _updatePharmaAddress() async {
    try {
      if (addressController.text.isEmpty) {
        showCustomSnackBar("Fill your address please", title: "address");
      } else {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'address': addressController.text}).then((value) {
          Navigator.of(context).pop();
          Get.toNamed(RouteHelper.getMainPharmacyPage());
        });
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Editing pharmacy profile",
      );
    }
  }
}
