// ignore_for_file: deprecated_member_use, prefer_final_fields, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_plateform/models/categories_model.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:pharmacy_plateform/pharmacist/controllers/post_drug_controller.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import '../../../../base/custom_loader.dart';
import '../../../../base/show_custom_snackbar.dart';
import '../../../../models/units_model.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/styles.dart';
import '../../../../widgets/app_icon.dart';
import '../../../../widgets/big_text.dart';
import '../widgets/Pharmacy_app_text_field _Date.dart';
import '../widgets/Pharmacy_app_text_field.dart';
import '../widgets/qrcode_field_widget.dart';

class AddNewDrugScreen extends StatefulWidget {
  const AddNewDrugScreen({Key? key}) : super(key: key);

  @override
  State<AddNewDrugScreen> createState() => _AddNewDrugScreenState();
}

class _AddNewDrugScreenState extends State<AddNewDrugScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();
  var _date = TextEditingController();
  var _mandate = TextEditingController();
  File? imageFile;
  bool _isLoaded = false;

  var selectedType;
  var selectedUnits;
  var category = "";
  var units = "";
  String _data = "";
  // List<DropdownMenuItem> categoriesItems = [];
  PostDrugController postDrugController = Get.put(PostDrugController());

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
                          color: Colors.transparent,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageFile == null
                                ? const AssetImage(
                                    "assets/image/medicine_icon1.jpg")
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  QrcodeFieldWidget(
                                      bigText: BigText(
                                    text: _data,
                                    color: Colors.black.withOpacity(0.6),
                                  )),
                                  //Qrcode bouton
                                  GestureDetector(
                                    onTap: () => _scan(),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: Dimensions.height20,
                                          bottom: Dimensions.height20,
                                          left: Dimensions.width20 - 5,
                                          right: Dimensions.width20 - 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.qr_code,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ),
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

                              //categories from firebase
                              StreamBuilder<QuerySnapshot>(
                                stream: firestore
                                    .collection("Categories")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    const Text("Loading..");
                                  } else {
                                    List<DropdownMenuItem> categoriesItems = [];
                                    for (int i = 0;
                                        i < snapshot.data!.docs.length;
                                        i++) {
                                      var categoryList =
                                          snapshot.data!.docs.map((cat) {
                                        return CategoriesModel.fromjson(cat);
                                      }).toList();
                                      CategoriesModel snap = categoryList[i];
                                      // DocumentSnapshot snap =
                                      //     snapshot.data!.docs[i];
                                      categoriesItems.add(DropdownMenuItem(
                                        value: "${snap.name}",
                                        child: Text(
                                          snap.name!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ));
                                    }
                                    return Container(
                                      clipBehavior: Clip.none,
                                      margin: EdgeInsets.only(
                                          left: Dimensions.height10,
                                          right: Dimensions.height10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius30),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 1,
                                              // spreadRadius: 7,
                                              offset: const Offset(0, 2),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: Dimensions.width30 - 7),
                                          DropdownButton<dynamic>(
                                            items: categoriesItems,
                                            onChanged: (categoriesValue) {
                                              setState(() {
                                                selectedType = categoriesValue;
                                                category =
                                                    categoriesValue.toString();
                                              });
                                            },
                                            value: selectedType,
                                            isExpanded: false,
                                            hint: const Text(
                                                'Choose categegory Type',
                                                style: TextStyle(
                                                    color: Colors.black54)),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              // // Category
                              // Container(
                              //   clipBehavior: Clip.none,
                              //   margin: EdgeInsets.only(
                              //       left: Dimensions.height10,
                              //       right: Dimensions.height10),
                              //   padding: const EdgeInsets.all(5),
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius: BorderRadius.circular(
                              //         Dimensions.radius30),
                              //     boxShadow: [
                              //       BoxShadow(
                              //           blurRadius: 1,
                              //           // spreadRadius: 7,
                              //           offset: const Offset(0, 2),
                              //           color: Colors.grey.withOpacity(0.3)),
                              //     ],
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       SizedBox(
                              //         width: Dimensions.width30 - 7,
                              //       ),
                              //       DropdownButton(
                              //         items: _accountType
                              //             .map((value) => DropdownMenuItem(
                              //                   value: value,
                              //                   child: Text(
                              //                     value,
                              //                     style: TextStyle(
                              //                         color: Colors.black,
                              //                         fontFamily: robotoRegular
                              //                             .toString()),
                              //                   ),
                              //                 ))
                              //             .toList(),
                              //         onChanged: (selectedAccountType) {
                              //           setState(() {
                              //             selectedType = selectedAccountType;
                              //             category =
                              //                 selectedAccountType.toString();
                              //           });
                              //         },
                              //         value: selectedType,
                              //         isExpanded: false,
                              //         hint: const Text(
                              //           'Choose categegory Type',
                              //           style: TextStyle(color: Colors.black54),
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: Dimensions.height20,
                              // ),

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

                              //Quantity
                              PharmacyAppTextField(
                                textController: quantityController,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                hintText: "Quantity",
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //Units
                              StreamBuilder<QuerySnapshot>(
                                stream:
                                    firestore.collection("Units").snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    const Text("Loading..");
                                  } else {
                                    List<DropdownMenuItem> unitsItems = [];
                                    for (int i = 0;
                                        i < snapshot.data!.docs.length;
                                        i++) {
                                      var unitsList =
                                          snapshot.data!.docs.map((un) {
                                        return UnitsModel.fromjson(un);
                                      }).toList();
                                      UnitsModel snap = unitsList[i];
                                      // DocumentSnapshot snap =
                                      //     snapshot.data!.docs[i];
                                      unitsItems.add(DropdownMenuItem(
                                        value: "${snap.name}",
                                        child: Text(
                                          snap.name!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ));
                                    }
                                    return Container(
                                      clipBehavior: Clip.none,
                                      margin: EdgeInsets.only(
                                          left: Dimensions.height10,
                                          right: Dimensions.height10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius30),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 1,
                                              // spreadRadius: 7,
                                              offset: const Offset(0, 2),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: Dimensions.width30 - 7),
                                          DropdownButton<dynamic>(
                                            items: unitsItems,
                                            onChanged: (unitsValue) {
                                              final snackBar = SnackBar(
                                                content: Text(
                                                  'Selected Currency value is $unitsValue',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: robotoRegular
                                                          .toString()),
                                                ),
                                              );
                                              Scaffold.of(context)
                                                  .showSnackBar(snackBar);
                                              setState(() {
                                                selectedUnits = unitsValue;
                                                units = unitsValue.toString();
                                              });
                                            },
                                            value: selectedUnits,
                                            isExpanded: false,
                                            hint: const Text('Choose unit type',
                                                style: TextStyle(
                                                    color: Colors.black54)),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  return Container();
                                },
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
                                  try {
                                    if (_data.isEmpty) {
                                      showCustomSnackBar("Fill your id please",
                                          title: "id");
                                    } else if (titleController.text.isEmpty) {
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
                                    } else if (imageFile == null) {
                                      showCustomSnackBar("Choose an image",
                                          title: "Image");
                                    } else if (category.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill your category please",
                                          title: "category");
                                    } else if (priceController.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill your price please",
                                          title: "price");
                                    } else if (quantityController
                                        .text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill your quantity please",
                                          title: "quantity");
                                    } else if (units.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the unit of the drug please",
                                          title: "units");
                                    } else if (descriptionController
                                        .text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill your description please",
                                          title: "description");
                                    } else {
                                      setState(() {
                                        _isLoaded = true;
                                      });
                                      String uid =
                                          firebaseAuth.currentUser!.uid;

                                      String downloadUrl =
                                          await _uploadToStorage(
                                              imageFile!, _data);

                                      Drug drug = Drug(
                                          id: _data,
                                          title: titleController.text,
                                          manufacturingDate: _mandate.text,
                                          expiringDate: _date.text,
                                          photoUrl: downloadUrl,
                                          categories: category,
                                          price:
                                              int.parse(priceController.text),
                                          quantity: int.parse(
                                              quantityController.text),
                                          uid: uid,
                                          publishedDate:
                                              DateTime.now().toString(),
                                          status: "Available",
                                          description:
                                              descriptionController.text,
                                          visibility: false,
                                          units: units);

                                      firestore
                                          .collection('Medicines')
                                          .doc(_data)
                                          .set(
                                            drug.toJson(),
                                          )
                                          .then((value) async {
                                        Get.toNamed(RouteHelper
                                            .getPharmacyMedecinePage());
                                        setState(() {
                                          _isLoaded = false;
                                        });
                                      });
                                    }
                                  } catch (e) {
                                    showCustomSnackBar(
                                      e.toString(),
                                      title: "Create drug item",
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
                                      text: "Add",
                                      size: Dimensions.font20 +
                                          Dimensions.font20 / 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
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

  _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "Cancel", true, ScanMode.BARCODE)
        .then((value) => setState(() => _data = value));
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

  Future<String> _uploadToStorage(File image, String id) async {
    Reference ref = firebaseStorage.ref().child('drugPhoto').child(id);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
