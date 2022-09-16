// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_final_fields, unused_field, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_plateform/base/custom_loader.dart';
import '../../../../base/show_custom_snackbar.dart';
import '../../../../models/drug_model.dart';
import '../../../../routes/route_helper.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/app_icon.dart';
import '../../../../widgets/big_text.dart';
import '../widgets/Pharmacy_app_text_field _Date.dart';
import '../widgets/Pharmacy_app_text_field.dart';
import '../widgets/qrcode_content_update.dart';
// ignore: library_prefixes
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class UpdateDrugScreen extends StatefulWidget {
  final Drug drug;
  const UpdateDrugScreen({
    Key? key,
    required this.drug,
  }) : super(key: key);

  @override
  State<UpdateDrugScreen> createState() => _UpdateDrugScreenState();
}

class _UpdateDrugScreenState extends State<UpdateDrugScreen> {
  var titleController;
  var descriptionController;
  var priceController;
  var quantityController;
  var _date;
  var _mandate;

  DateTime _dateTime = DateTime.now();
  List<DropdownMenuItem> categoriesItems = [];
  File? imagexFile;
  bool _isLoaded = false;
  String? drugImageUrl;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.drug.title);
    descriptionController =
        TextEditingController(text: widget.drug.description);
    priceController = TextEditingController(text: widget.drug.price.toString());
    quantityController =
        TextEditingController(text: widget.drug.quantity.toString());
    _date = TextEditingController(text: widget.drug.expiringDate);
    _mandate = TextEditingController(text: widget.drug.manufacturingDate);

    super.initState();
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
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imagexFile == null
                              ? NetworkImage(widget.drug.photoUrl)
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
                            child: AppIcon(icon: Icons.arrow_back_ios)),
                      ],
                    ),
                  ),

                  // choose photo icon
                  Positioned(
                    top: Dimensions.height45 * 4.5,
                    left: Dimensions.width45 * 7.5,
                    child: GestureDetector(
                      onTap: () => _showImageDialog(),
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
                    top: (Dimensions.popularFoodImgSize) / 1.2,
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

                                //The Qrcode
                                Row(
                                  children: [
                                    QrCodeContentUpdate(
                                        bigText: BigText(
                                      text: widget.drug.id,
                                      color: Colors.black.withOpacity(0.6),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                //The title

                                PharmacyAppTextField(
                                  textController: titleController,
                                  textInputType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  hintText: "Title",
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                // Manufacturing  Date

                                PharmacyAppTextFieldDate(
                                  textController: _mandate,
                                  textInputType: TextInputType.datetime,
                                  textInputAction: TextInputAction.next,
                                  hintText: "Select Manufacturing Date",
                                  onTap: () async {
                                    _showDatePickers();
                                  },
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                // Expiring Date
                                PharmacyAppTextFieldDate(
                                  textController: _date,
                                  textInputType: TextInputType.datetime,
                                  textInputAction: TextInputAction.next,
                                  hintText: "Select Expiring Date",
                                  onTap: () async {
                                    _showDatePicker();
                                  },
                                ),

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                //Price
                                PharmacyAppTextField(
                                  textController: priceController,
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  hintText: "Price",
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                //quantity
                                PharmacyAppTextField(
                                  textController: quantityController,
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  hintText: "quantity",
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                //Description
                                PharmacyAppTextField(
                                  textController: descriptionController,
                                  textInputType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  hintText: "Description",
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                //sign up button

                                GestureDetector(
                                  onTap: () async {
                                    // Only update if new data was entered

                                    final drugChangedTitle =
                                        widget.drug.title !=
                                            titleController.text;
                                    final drugChangedManDate =
                                        widget.drug.manufacturingDate !=
                                            _mandate.text;
                                    final drugChangedExpDate =
                                        widget.drug.expiringDate != _date.text;
                                    final drugChangedId =
                                        widget.drug.id != widget.drug.id;

                                    final drugChangedPrice =
                                        widget.drug.price !=
                                            priceController.text;
                                    final drugChangedQuantity =
                                        widget.drug.quantity !=
                                            quantityController.text;

                                    final drugChangedDesc =
                                        widget.drug.description !=
                                            descriptionController.text;

                                    final drugUpdate = drugChangedTitle ||
                                        drugChangedManDate ||
                                        drugChangedExpDate ||
                                        drugChangedId ||
                                        drugChangedPrice ||
                                        drugChangedQuantity ||
                                        drugChangedDesc;
                                    if (drugUpdate) {
                                      try {
                                        if (titleController.text.isEmpty) {
                                          showCustomSnackBar(
                                              "Fill your title please",
                                              title: "title");
                                        } else if (_mandate.text.isEmpty) {
                                          showCustomSnackBar(
                                              "Fill manufacturing date  please",
                                              title: "man date");
                                        } else if (_date.text.isEmpty) {
                                          showCustomSnackBar(
                                              "Fill your expiring date please",
                                              title: "exp date");
                                        } else if (priceController
                                            .text.isEmpty) {
                                          showCustomSnackBar(
                                              "Fill your price please",
                                              title: "price");
                                        } else if (quantityController
                                            .text.isEmpty) {
                                          showCustomSnackBar(
                                              "Fill your quantity please",
                                              title: "quantity");
                                        } else if (descriptionController
                                            .text.isEmpty) {
                                          showCustomSnackBar(
                                              "Fill your description please",
                                              title: "description");
                                        } else {
                                          setState(() {
                                            _isLoaded = true;
                                          });
                                          await FirebaseFirestore.instance
                                              .collection("Medicines")
                                              .doc(widget.drug.id)
                                              .update({
                                            'title': titleController.text,
                                            'manufacturing_date': _mandate.text,
                                            'expiring_date': _date.text,
                                            'price':
                                                int.parse(priceController.text),
                                            'quantity': int.parse(
                                                quantityController.text),
                                            'description':
                                                descriptionController.text,
                                          });
                                          Get.toNamed(RouteHelper
                                              .getPharmacyMedecinePage());
                                        }
                                      } catch (e) {
                                        showCustomSnackBar(
                                          e.toString(),
                                          title: "Editing drug item",
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
                                        text: "Update",
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
            : CustomLoader());
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      setState(() {
        _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _showDatePickers() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      setState(() {
        _mandate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
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
    String fileId = widget.drug.id;
    fStorage.Reference reference = fStorage.FirebaseStorage.instance
        .ref()
        .child('drugPhoto')
        .child(fileId);
    fStorage.UploadTask uploadTask = reference.putFile(File(imagexFile!.path));
    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) async {
      drugImageUrl = url;
    });

    await FirebaseFirestore.instance
        .collection("Medicines")
        .doc(widget.drug.id)
        .update({'photo_url': drugImageUrl});
  }
}
