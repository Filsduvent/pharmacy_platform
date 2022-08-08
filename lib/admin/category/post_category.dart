// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unused_field, prefer_final_fields, sort_child_properties_last

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/admin/admincontrollers/category_controller.dart';
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
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();

  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading
          ? Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                      width: double.maxFinite,
                      height: Dimensions.popularFoodImgSize / 1.2,
                      //color: Colors.grey.withOpacity(0.1),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(categoryController.drugPhoto)))),
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
                          child: AppIcon(icon: Icons.arrow_back_ios)),
                    ],
                  ),
                ),

                // The white background
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: (Dimensions.popularFoodImgSize - 20) / 1.2,
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
                                onTap: () {
                                  uploadCategoryItem(
                                    nameController.text,
                                    categoryController.drugPhoto,
                                    descriptionController.text,
                                  );
                                },
                                child: Container(
                                  width: Dimensions.screenWidth / 2,
                                  height: Dimensions.screenHeight / 13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius30),
                                      color: AppColors.mainColor),
                                  child: Center(
                                    child: BigText(
                                      text: "Add",
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

  Future<String> _uploadToStorage(File image, String name) async {
    Reference ref = firebaseStorage.ref().child('categoryPhoto').child(name);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future uploadCategoryItem(
    String name,
    File? photoUrl,
    String description,
  ) async {
    _isLoading.value = true;
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
        firestore.collection('Categories').doc(name).set(
              category.tojson(),
            );

        Get.toNamed(RouteHelper.getCategoriesMainScreen());
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Create category item",
      );
    }
    setState(() {
      _isLoading.value = false;
    });
  }
}
