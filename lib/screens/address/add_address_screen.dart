// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pharmacist/view/screens/widgets/Pharmacy_app_text_field.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _nameController = TextEditingController();
    var _phoneNumberController = TextEditingController();
    var _provinceController = TextEditingController();
    var _communeController = TextEditingController();
    var _zoneController = TextEditingController();
    var _quarterController = TextEditingController();
    var _avenueController = TextEditingController();
    var _houseNumberController = TextEditingController();
    return SafeArea(
        child: Scaffold(
      //appBar
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Add Address", size: 24, color: Colors.white),
      ),

      //The Body
      body: Container(
        padding: EdgeInsets.only(
          left: Dimensions.width20,
          right: Dimensions.width20,
        ),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),

                  //The Name
                  PharmacyAppTextField(
                    textController: _nameController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    hintText: "Complet Name",
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  //Phone Number
                  PharmacyAppTextField(
                    textController: _phoneNumberController,
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    hintText: "Phone Number",
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  //Province
                  PharmacyAppTextField(
                    textController: _provinceController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Province state",
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  //Commune
                  PharmacyAppTextField(
                    textController: _communeController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: " Commune",
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  //Zone
                  PharmacyAppTextField(
                    textController: _zoneController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Zone",
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  //Quarter
                  PharmacyAppTextField(
                    textController: _quarterController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Quarter",
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  //Avenue
                  PharmacyAppTextField(
                    textController: _avenueController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Avenue",
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  //House Number
                  PharmacyAppTextField(
                    textController: _houseNumberController,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    hintText: "House Number",
                  ),
                  SizedBox(
                    height: Dimensions.height20,
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

      //floatingActionButton

      floatingActionButton: BuildAddAddressButton(),
    ));
  }

  Widget BuildAddAddressButton() => FloatingActionButton.extended(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius15)),
      backgroundColor: AppColors.mainColor,
      label: BigText(
        text: 'Done',
        color: Colors.white,
      ),
      icon: const Icon(Icons.check),
      onPressed: () {
        Get.toNamed(RouteHelper.getAddAddressScreen());
      });
}
