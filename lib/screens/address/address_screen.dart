// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/controllers/address_changer_controller.dart';
import 'package:pharmacy_plateform/models/address_model.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/screens/address/address_card.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';

import '../../base/no_data_page.dart';
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

      //Body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Select Address",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          GetBuilder<AddressChangerController>(builder: (controller) {
            return Flexible(
              child: StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection('Users')
                      .doc(AppConstants.sharedPreferences!
                          .getString(AppConstants.userUID))
                      .collection('Address')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                        ? ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Addresscard(
                                  model: AddressModel.fromJson(
                                      snapshot.data?.docs[index].data()
                                          as Map<String, dynamic>),
                                  addressId:
                                      snapshot.data?.docs[index].id as String,
                                  currentIndex: addressChangerController.count,
                                  value: index);
                            })
                        : NoDataPage(
                            text: "Empty address",
                            imgPath: "assets/image/delivery_man_marker.png",
                          );
                    ;
                  }),
            );
          })
        ],
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
        text: 'Add New Address',
        color: Colors.white,
      ),
      icon: const Icon(Icons.add_location),
      onPressed: () {
        Get.toNamed(RouteHelper.getAddAddressScreen());
      });

  noAddressCard() {
    return Card(
      color: Colors.pink.withOpacity(0.5),
      child: Container(
        height: 100.0,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_location,
              color: Colors.white,
            ),
            const Text("No shipment address has been saved,"),
            const Text(
                "Please add your shipment Address so that we can deliver medicine for you."),
          ],
        ),
      ),
    );
  }
}
