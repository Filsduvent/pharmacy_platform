// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_final_fields, unused_field, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:pharmacy_plateform/base/custom_loader.dart';
import 'package:pharmacy_plateform/pharmacist/controllers/post_drug_controller.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/home/pharmacy_drug_details.dart';

import '../../../../controllers/slide_drug_controller.dart';
import '../../../../models/drug_model.dart';
import '../../../../routes/route_helper.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/styles.dart';
import '../../../../widgets/app_icon.dart';
import '../../../../widgets/big_text.dart';
import '../widgets/Pharmacy_app_text_field _Date.dart';
import '../widgets/Pharmacy_app_text_field.dart';
import '../widgets/qrcode_content_update.dart';
import '../widgets/qrcode_field_widget.dart';

class UpdateDrugScreen extends StatefulWidget {
  String medId;
  int pageId;
  UpdateDrugScreen({
    Key? key,
    required this.medId,
    required this.pageId,
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

  var selectedType;
  var selectedUnits;
  List<String> _accountType = ['Pills', 'Injectables', 'Sirop', 'Gellule'];
  var category;
  var unit;
  // String _data = widget.medId;
  DateTime _dateTime = DateTime.now();
  List<DropdownMenuItem> categoriesItems = [];
  PostDrugController postDrugController = Get.put(PostDrugController());
  @override
  void initState() {
    var drug = Get.find<PostDrugController>().drugList[widget.pageId];
    Get.put(PostDrugController());
    titleController = TextEditingController(text: drug.title);
    descriptionController = TextEditingController(text: drug.description);
    priceController = TextEditingController(text: drug.price.toString());
    quantityController = TextEditingController(text: drug.quantity.toString());
    _date = TextEditingController(text: drug.expiringDate);
    _mandate = TextEditingController(text: drug.manufacturingDate);
    category = drug.categories.toString();
    unit = drug.units.toString();

    // String _data = postDrugController.data['id'];
    // File image = postDrugController.data['photo_url'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      var drug = Get.find<PostDrugController>().drugList[widget.pageId];
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
                        image: NetworkImage(drug.photoUrl)))),
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
                              text: widget.medId,
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
                        //Units
                        StreamBuilder<QuerySnapshot>(
                          stream: firestore.collection("Units").snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              Text("Loading..");
                            } else {
                              List<DropdownMenuItem> unitsItems = [];
                              for (int i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                DocumentSnapshot snap = snapshot.data!.docs[i];
                                unitsItems.add(DropdownMenuItem(
                                  child: Text(
                                    snap.id,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  value: "${snap.id}",
                                ));
                              }
                              return Container(
                                clipBehavior: Clip.none,
                                margin: EdgeInsets.only(
                                    left: Dimensions.height10,
                                    right: Dimensions.height10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius30),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1,
                                        // spreadRadius: 7,
                                        offset: Offset(0, 2),
                                        color: Colors.grey.withOpacity(0.3)),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: Dimensions.width30 - 7),
                                    DropdownButton<dynamic>(
                                      items: unitsItems,
                                      onChanged: (unitsValue) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Selected Currency value is $unitsValue',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    robotoRegular.toString()),
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          selectedUnits = unitsValue;
                                          unit = unitsValue.toString();
                                        });
                                      },
                                      value: selectedUnits,
                                      isExpanded: false,
                                      hint: Text(unit,
                                          style:
                                              TextStyle(color: Colors.black87)),
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
                          onTap: () {
                            // Only update if new data was entered
                            setState(() {
                              final drugChangedTitle =
                                  drug.title != titleController.text;
                              final drugChangedManDate =
                                  drug.manufacturingDate != _mandate.text;
                              final drugChangedExpDate =
                                  drug.expiringDate != _date.text;
                              final drugChangedId = drug.id != widget.medId;
                              final drugChangedPhotoUrl = drug.photoUrl !=
                                  postDrugController.drugPhotoUpdate;
                              final drugChangedCategory =
                                  drug.categories != category;
                              final drugChangedPrice =
                                  drug.price != priceController.text;
                              final drugChangedQuantity =
                                  drug.quantity != quantityController.text;
                              final drugChangedUnit = drug.units != unit;
                              final drugChangedDesc = drug.description !=
                                  descriptionController.text;

                              final drugUpdate = drugChangedTitle ||
                                  drugChangedManDate ||
                                  drugChangedExpDate ||
                                  drugChangedId ||
                                  drugChangedPhotoUrl ||
                                  drugChangedCategory ||
                                  drugChangedPrice ||
                                  drugChangedQuantity ||
                                  drugChangedUnit ||
                                  drugChangedDesc;
                              if (drugUpdate) {
                                postDrugController.updateDrugDataList(
                                  widget.medId,
                                  titleController.text,
                                  _mandate.text,
                                  _date.text,
                                  postDrugController.drugPhotoUpdate!,
                                  category,
                                  int.parse(priceController.text),
                                  int.parse(quantityController.text),
                                  unit,
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
