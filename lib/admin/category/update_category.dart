import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class UpdateCategoryScreen extends StatefulWidget {
  final CategoriesModel category;

  UpdateCategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  late bool isLoading;
  var nameController;
  var descriptionController;
  var image;
  Rx<File?>? _file;
  File? get catPhoto => _file?.value;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.category.name);
    descriptionController =
        TextEditingController(text: widget.category.description);
    image = widget.category.image;
    isLoading = false;
  }

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
                      //color: Colors.transparent,
                      decoration: (image is String)
                          ? BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(image.toString())))
                          : BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: FileImage(image)))),
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
                            // Get.toNamed(RouteHelper.getCategoryDetailsScreen(
                            //   widget.pageId,
                            //   "details",
                            //   widget.catId,
                            // ));
                            Get.back();
                          },
                          child: AppIcon(
                            icon: Icons.arrow_back_ios,
                            iconColor: AppColors.mainColor,
                          )),
                    ],
                  ),
                ),

                // choose photo icon
                Positioned(
                  top: Dimensions.height45 * 4.5,
                  left: Dimensions.width45 * 8,
                  child: GestureDetector(
                    onTap: () {
                      pickImage(context);
                    }, // => //postDrugController.pickImageUpdate(context),
                    child: AppIcon(
                      icon: Icons.add_a_photo,
                      backgroundColor: Colors.white,
                      iconColor: AppColors.mainColor,
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
                                  final catChangedPhotoUrl =
                                      widget.category.image != catPhoto;
                                  final catChangedname = widget.category.name !=
                                      nameController.text;
                                  final catChangeddesc =
                                      widget.category.description !=
                                          descriptionController.text;

                                  final catUpdate = catChangedPhotoUrl ||
                                      catChangedname ||
                                      catChangeddesc;

                                  if (catUpdate) {
                                    uploadCategoryItem(
                                      nameController.text,
                                      _file?.value as File,
                                      descriptionController.text,
                                    );
                                  }
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
                                      text: "Edit",
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

  //capture to add in storage

  capturePhotoWithCamera() async {
    navigator!.pop();
    final imageFile = (await ImagePicker().pickImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0));
    if (imageFile != null) {
      Get.snackbar('Category Picture',
          'You have successfully selected your category picture!');
      Get.to(UpdateCategoryScreen(
        category: widget.category,
      ));
    } else {
      Get.snackbar('Category Picture', 'Please try again!');
    }

    _file = Rx<File?>(File(imageFile!.path));
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

    _file = Rx<File?>(File(imageFile!.path));
  }

  Future<String> _uploadToStorage(File image, String name) async {
    Reference ref = firebaseStorage.ref().child('categoryPhoto').child(name);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // The update function reo sasa
  Future uploadCategoryItem(
    String name,
    File? photoUrl,
    String description,
  ) async {
    try {
      if (name.isEmpty) {
        showCustomSnackBar("Fill the category name please", title: "Name");
      } else if (description.isEmpty) {
        showCustomSnackBar("Fill the category description please",
            title: "Description");
      } else {
        // File p = photoUrl as File;
        String downloadUrl = await _uploadToStorage(photoUrl as File, name);

        CategoriesModel category = CategoriesModel(
          id: name,
          name: name,
          image: downloadUrl,
          description: description,
        );
        firestore.collection('Categories').doc(name).update(
              category.tojson(),
            );

        Get.toNamed(RouteHelper.getCategoriesMainScreen());
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Updating category item",
      );
    }
  }
}
