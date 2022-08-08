// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unused_field, prefer_final_fields, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_plateform/base/custom_loader.dart';
import 'package:pharmacy_plateform/pharmacist/controllers/post_drug_controller.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/widgets/Pharmacy_app_text_field.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/styles.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/app_icon.dart';

import '../../../../widgets/big_text.dart';
import '../widgets/Pharmacy_app_text_field _Date.dart';
import '../widgets/qrcode_field_widget.dart';

class PostDrugForm extends StatefulWidget {
  const PostDrugForm({Key? key}) : super(key: key);

  @override
  State<PostDrugForm> createState() => _PostDrugFormState();
}

class _PostDrugFormState extends State<PostDrugForm> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();
  var _date = TextEditingController();
  var _mandate = TextEditingController();

  var selectedType;
  var selectedUnits;
  List<String> _accountType = ['Pills', 'Injectables', 'Sirop', 'Gellule'];
  var category = "Pills";
  var units = "";
  String _data = "";
  DateTime _dateTime = DateTime.now();
  List<DropdownMenuItem> categoriesItems = [];
  PostDrugController postDrugController = Get.put(PostDrugController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !postDrugController.isLoaded
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
                              image: FileImage(postDrugController.drugPhoto)))),
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
                                          left: Dimensions.width20,
                                          right: Dimensions.width20),
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
                              // Category
                              Container(
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
                                    SizedBox(
                                      width: Dimensions.width30 - 7,
                                    ),
                                    DropdownButton(
                                      items: _accountType
                                          .map((value) => DropdownMenuItem(
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: robotoRegular
                                                          .toString()),
                                                ),
                                                value: value,
                                              ))
                                          .toList(),
                                      onChanged: (selectedAccountType) {
                                        setState(() {
                                          selectedType = selectedAccountType;
                                          category =
                                              selectedAccountType.toString();
                                        });
                                      },
                                      value: selectedType,
                                      isExpanded: false,
                                      hint: Text(
                                        'Choose categegory Type',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    )
                                  ],
                                ),
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
                                    Text("Loading..");
                                  } else {
                                    List<DropdownMenuItem> unitsItems = [];
                                    for (int i = 0;
                                        i < snapshot.data!.docs.length;
                                        i++) {
                                      DocumentSnapshot snap =
                                          snapshot.data!.docs[i];
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
                                            hint: Text('Choose unit type',
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
                                onTap: () {
                                  postDrugController.uploadDrugItem(
                                    _data,
                                    titleController.text,
                                    _mandate.text,
                                    _date.text,
                                    postDrugController.drugPhoto,
                                    category,
                                    int.parse(priceController.text),
                                    int.parse(quantityController.text),
                                    units,
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
}
