// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unused_field, prefer_final_fields, sort_child_properties_last, use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_plateform/models/categories_model.dart';
import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../pharmacist/view/screens/widgets/Pharmacy_app_text_field.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class PostCategoryForm extends StatefulWidget {
  const PostCategoryForm({Key? key}) : super(key: key);

  @override
  State<PostCategoryForm> createState() => _PostCategoryFormState();
}

class _PostCategoryFormState extends State<PostCategoryForm> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  File? imageFile;
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isLoaded
          ? Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                      width: double.maxFinite,
                      height: Dimensions.popularFoodImgSize * 1.4,
                      //color: Colors.grey.withOpacity(0.1),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageFile == null
                                ? const AssetImage("assets/image/category.png")
                                : Image.file(imageFile!).image,
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
                            Get.toNamed(RouteHelper.getCategoriesMainScreen());
                          },
                          child: AppIcon(
                            icon: Icons.arrow_back_ios,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                          )),
                    ],
                  ),
                ),

                // choose photo icon
                Positioned(
                  top: Dimensions.height45 * 9,
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
                  top: (Dimensions.popularFoodImgSize) * 1.4,
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

                    //All content field
                    child: Column(children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Dimensions.screenHeight * 0.05,
                              ),

                              //The name

                              PharmacyAppTextField(
                                textController: nameController,
                                textInputType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                hintText: "Title",
                              ),
                              SizedBox(
                                height: Dimensions.height20 * 2,
                              ),

                              //Description
                              PharmacyAppTextField(
                                textController: descriptionController,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                hintText: "Description",
                              ),

                              SizedBox(
                                height: Dimensions.height20 * 2,
                              ),

                              //sign up button

                              GestureDetector(
                                onTap: () async {
                                  try {
                                    if (nameController.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the category name please",
                                          title: "Name");
                                    } else if (nameController.text.length >
                                        13) {
                                      showCustomSnackBar(
                                          "The category name can't have more than 13 characters",
                                          title: "Name");
                                    } else if (descriptionController
                                        .text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the category description please",
                                          title: "Description");
                                    } else if (imageFile == null) {
                                      showCustomSnackBar("Choose an image",
                                          title: "Image");
                                    } else {
                                      setState(() {
                                        _isLoaded = true;
                                      });
                                      String downloadUrl =
                                          await _uploadToStorage(
                                              imageFile!,
                                              DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString());

                                      CategoriesModel category =
                                          CategoriesModel(
                                        id: DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString(),
                                        name: nameController.text,
                                        image: downloadUrl,
                                        description: descriptionController.text,
                                      );
                                      firestore
                                          .collection('Categories')
                                          .doc(DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString())
                                          .set(
                                            category.tojson(),
                                          );

                                      Get.toNamed(RouteHelper
                                          .getCategoriesMainScreen());
                                      setState(() {
                                        _isLoaded = false;
                                      });
                                    }
                                  } catch (e) {
                                    showCustomSnackBar(
                                      e.toString(),
                                      title: "Create category item",
                                    );
                                  }
                                  // uploadCategoryItem(
                                  //   nameController.text,
                                  //   categoryController.drugPhoto,
                                  //   descriptionController.text,
                                  // );
                                },
                                child: Container(
                                  width: Dimensions.screenWidth / 2,
                                  height: Dimensions.screenHeight / 13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius30),
                                      color: AppColors.secondColor),
                                  child: Center(
                                    child: BigText(
                                      text: "Add ",
                                      size: Dimensions.font20 +
                                          Dimensions.font20 / 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: Dimensions.screenHeight * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            )
          : CustomLoader(),
    );
  }

  // upload image to firebase storage

  Future<String> _uploadToStorage(File image, String id) async {
    Reference ref = firebaseStorage.ref().child('categoryPhoto').child(id);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // choose photo dialog

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
        imageFile = File(croppedImage.path);
      });
    }
  }
}
