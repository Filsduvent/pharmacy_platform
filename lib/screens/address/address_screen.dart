// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //appBar
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Address", size: 24, color: Colors.white),
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
        text: 'Add Address',
        color: Colors.white,
      ),
      icon: const Icon(Icons.location_on),
      onPressed: () {
        Get.toNamed(RouteHelper.getAddAddressScreen());
      });
}
