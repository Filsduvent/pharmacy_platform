// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_final_fields, unused_field, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_plateform/base/custom_loader.dart';
import 'package:pharmacy_plateform/pharmacist/controllers/post_drug_controller.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/home/pharmacy_drug_details.dart';
import '../../../../models/drug_model.dart';
import '../../../../routes/route_helper.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/app_icon.dart';
import '../../../../widgets/big_text.dart';
import '../widgets/Pharmacy_app_text_field _Date.dart';
import '../widgets/Pharmacy_app_text_field.dart';
import '../widgets/qrcode_content_update.dart';
import '../widgets/qrcode_field_widget.dart';

class UpdateDrugScreen extends StatefulWidget {
  const UpdateDrugScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateDrugScreen> createState() => _UpdateDrugScreenState();
}

class _UpdateDrugScreenState extends State<UpdateDrugScreen> {
  var titleController =
      TextEditingController(text: postDrugController.data['title']);
  var descriptionController =
      TextEditingController(text: postDrugController.data['description']);
  var priceController =
      TextEditingController(text: postDrugController.data['price'].toString());
  var quantityController = TextEditingController(
      text: postDrugController.data['quantity'].toString());
  var _date =
      TextEditingController(text: postDrugController.data['expiring_date']);
  var _mandate = TextEditingController(
      text: postDrugController.data['manufacturing_date']);

  var selectedType;
  List<String> _accountType = ['Pills', 'Injectables', 'Sirop', 'Gellule'];
  var category = postDrugController.data['categories'];
  String _data = postDrugController.data['id'];
  DateTime _dateTime = DateTime.now();
  List<DropdownMenuItem> categoriesItems = [];
  //PostDrugController postDrugController = Get.put(PostDrugController());
  @override
  void initState() {
    var titleController =
        TextEditingController(text: postDrugController.data['title']);
    var descriptionController =
        TextEditingController(text: postDrugController.data['description']);
    var priceController = TextEditingController(
        text: postDrugController.data['price'].toString());
    var quantityController = TextEditingController(
        text: postDrugController.data['quantity'].toString());
    var _date =
        TextEditingController(text: postDrugController.data['expiring_date']);
    var _mandate = TextEditingController(
        text: postDrugController.data['manufacturing_date']);
    var category = postDrugController.data['categories'].toString();
    String _data = postDrugController.data['id'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize / 1.3,
                //color: Colors.grey.withOpacity(0.1),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            postDrugController.data['photo_url'])))),
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
            left: Dimensions.width45 * 8,
            child: GestureDetector(
              onTap: () => postDrugController.pickImageUpdate(context),
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
            top: (Dimensions.popularFoodImgSize - 20) / 1.3,
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
                              text: _data,
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
                        // Category
                        Container(
                          width: Dimensions.width45 * 10,
                          margin: EdgeInsets.only(
                              left: Dimensions.height10,
                              right: Dimensions.height10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1,
                                  // spreadRadius: 7,
                                  offset: Offset(0, 2),
                                  color: Colors.grey.withOpacity(0.3)),
                            ],
                          ),
                          child: Container(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width20,
                                  right: Dimensions.height20),
                              margin: EdgeInsets.only(
                                  left: Dimensions.height10 / 2,
                                  right: Dimensions.height10 / 2),
                              child: DropdownButton(
                                items: _accountType
                                    .map((value) => DropdownMenuItem(
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          value: value,
                                        ))
                                    .toList(),
                                onChanged: (selectedAccountType) {
                                  setState(() {
                                    selectedType = selectedAccountType;
                                    category = selectedAccountType.toString();
                                  });
                                },
                                value: selectedType,
                                isExpanded: false,
                                hint: Text(
                                  category,
                                  style: TextStyle(color: Colors.black87),
                                ),
                              )),
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
                          onTap: () {
                            // Only update if new data was entered
                            setState(() {
                              final drugChangedTitle =
                                  postDrugController.data['title'] !=
                                      titleController.text;
                              final drugChangedManDate = postDrugController
                                      .data['manufactured_date'] !=
                                  _mandate.text;
                              final drugChangedExpDate =
                                  postDrugController.data['expiring_date'] !=
                                      _date.text;
                              final drugChangedId =
                                  postDrugController.data['id'] != _data;
                              final drugChangedPhotoUrl =
                                  postDrugController.data['photo_url'] !=
                                      postDrugController.drugPhotoUpdate;
                              final drugChangedCategory =
                                  postDrugController.data['categories'] !=
                                      category;
                              final drugChangedPrice =
                                  postDrugController.data['price'] !=
                                      priceController.text;
                              final drugChangedDesc =
                                  postDrugController.data['description'] !=
                                      descriptionController.text;

                              final drugUpdate = drugChangedTitle ||
                                  drugChangedManDate ||
                                  drugChangedExpDate ||
                                  drugChangedId ||
                                  drugChangedPhotoUrl ||
                                  drugChangedCategory ||
                                  drugChangedPrice ||
                                  drugChangedDesc;
                              if (drugUpdate) {
                                postDrugController.updateDrugDataList(
                                  _data,
                                  titleController.text,
                                  _mandate.text,
                                  _date.text,
                                  postDrugController.drugPhotoUpdate,
                                  category,
                                  int.parse(priceController.text),
                                  int.parse(quantityController.text),
                                  descriptionController.text,
                                );
                              }
                            });
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: AppColors.mainColor),
                            child: Center(
                              child: BigText(
                                text: "Update",
                                size: Dimensions.font20 + Dimensions.font20 / 2,
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
      );
    }));
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
}
