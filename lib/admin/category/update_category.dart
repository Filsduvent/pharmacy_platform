// ignore_for_file: prefer_typing_uninitialized_variables, unused_field, prefer_const_constructors, use_build_context_synchronously, library_prefixes

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_plateform/models/categories_model.dart';
import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../pharmacist/view/screens/widgets/Pharmacy_app_text_field.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final CategoriesModel category;

  const UpdateCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  var nameController;
  var descriptionController;
  File? imagexFile;
  bool _isLoaded = false;
  String? catImageUrl;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.category.name);
    descriptionController =
        TextEditingController(text: widget.category.description);
  }

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
                      height: Dimensions.popularFoodImgSize / 1.2,
                      //color: Colors.grey.withOpacity(0.1),
                      //color: Colors.transparent,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imagexFile == null
                            ? NetworkImage(widget.category.image!)
                            : Image.file(imagexFile!).image,
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
                  left: Dimensions.width45 * 7.5,
                  child: GestureDetector(
                    onTap: () {
                      _showImageDialog();
                    },
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
                                onTap: () async {
                                  final catChangedname = widget.category.name !=
                                      nameController.text;
                                  final catChangeddesc =
                                      widget.category.description !=
                                          descriptionController.text;

                                  final catUpdate =
                                      catChangedname || catChangeddesc;

                                  if (catUpdate) {
                                    try {
                                      if (nameController.text.isEmpty) {
                                        showCustomSnackBar(
                                            "Fill the category name please",
                                            title: "Name");
                                      } else if (descriptionController
                                          .text.isEmpty) {
                                        showCustomSnackBar(
                                            "Fill the category description please",
                                            title: "Description");
                                      } else {
                                        setState(() {
                                          _isLoaded = true;
                                        });
                                        await FirebaseFirestore.instance
                                            .collection("Categories")
                                            .doc(widget.category.id)
                                            .update({
                                          'name': nameController.text,
                                          'description':
                                              descriptionController.text,
                                        }).whenComplete(() {
                                          updateCategoryNameOnUserExixtingPost();

                                          Get.toNamed(RouteHelper
                                              .getCategoriesMainScreen());
                                        });
                                      }
                                    } catch (e) {
                                      showCustomSnackBar(
                                        e.toString(),
                                        title: "Editing category item",
                                      );
                                      setState(() {
                                        _isLoaded = false;
                                      });
                                    }
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
        imagexFile = File(croppedImage.path);
        _updateImageInFirestore();
      });
    }
  }

  void _updateImageInFirestore() async {
    String fileId = widget.category.id!;
    fStorage.Reference reference = fStorage.FirebaseStorage.instance
        .ref()
        .child('categoryPhoto')
        .child(fileId);
    fStorage.UploadTask uploadTask = reference.putFile(File(imagexFile!.path));
    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) async {
      catImageUrl = url;
    });

    await FirebaseFirestore.instance
        .collection("Categories")
        .doc(widget.category.id)
        .update({'image': catImageUrl});
  }

  updateCategoryNameOnUserExixtingPost() async {
    await FirebaseFirestore.instance
        .collection('Medicines')
        .where('categories', isEqualTo: widget.category.name)
        .get()
        .then((snapshot) {
      for (int index = 0; index < snapshot.docs.length; index++) {
        String categoryNameInPost = snapshot.docs[index]['categories'];

        if (categoryNameInPost != nameController.text) {
          FirebaseFirestore.instance
              .collection('Medicines')
              .doc(snapshot.docs[index].id)
              .update({
            'categories': nameController.text,
          });
        }
      }
    });
  }
}
