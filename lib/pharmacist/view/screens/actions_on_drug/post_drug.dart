// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/widgets/Pharmacy_app_text_field.dart';
import '../../../../utils/app_constants.dart';
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
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var confirmController = TextEditingController();
  var _date = TextEditingController();

  bool isObscure = true;
  bool isVisible = true;

  var selectedType;
  List<String> _accountType = [
    'Admin',
    'Pharmacy owner',
    'Customer',
    'Provider'
  ];
  var role = "Customer";
  String _data = "";
  DateTime _dateTime = DateTime.now();
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
              height: Dimensions.popularFoodImgSize / 1.2,
              //color: Colors.grey.withOpacity(0.1),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(postDrugController.drugPhoto!)))),
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
          top: Dimensions.height45 * 4.7,
          left: Dimensions.width45 * 8,
          child: GestureDetector(
            onTap: () => postDrugController.pickImage(context),
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

                      //The Qrcode
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
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
                        textController: nameController,
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        hintText: "Title",
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

                      // Manufacturing  Date

                      PharmacyAppTextFieldDate(
                        textController: _date,
                        textInputType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        hintText: "Select Manufacturing Date",
                        onTap: () async {
                          _showDatePicker();
                        },
                      ),

                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      //Categorie
                      PharmacyAppTextField(
                        textController: phoneController,
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        hintText: "Category",
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      //Price
                      PharmacyAppTextField(
                        textController: addressController,
                        textInputType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.done,
                        hintText: "Price",
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),

                      //sign up button

                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Add",
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
    ));
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
}
