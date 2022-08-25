// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/user_model.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/date_format.dart';

import '../../../models/drug_model.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_column.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/expandable_text_widget.dart';

class InvalidDrugDetailsScreen extends StatefulWidget {
  final int pageId;
  final String page;
  final Drug drug;
  const InvalidDrugDetailsScreen(
      {Key? key, required this.pageId, required this.page, required this.drug})
      : super(key: key);

  @override
  State<InvalidDrugDetailsScreen> createState() =>
      _InvalidDrugDetailsScreenState();
}

class _InvalidDrugDetailsScreenState extends State<InvalidDrugDetailsScreen> {
  final Rx<bool> _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;

  Future<Map> _pause() async {
    Stream<QuerySnapshot> result = await firestore
        .collection('Users')
        .where('role', isEqualTo: "Pharmacy owner")
        .where('uid',
            isEqualTo: /* drugList[widget.pageId].uid*/ widget.drug.uid)
        .snapshots();

    Map pharmaInfo = {};

    result.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        pharmaInfo['name'] = field.docs[index]['pharmaName'];
        pharmaInfo['address'] = field.docs[index]['address'];
      });
    });

    return pharmaInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: _pause(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              var tmp = snapshot.data as Map;
              return Stack(
                children: [
                  // photo cover back ground
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.maxFinite,
                      height: Dimensions.popularFoodImgSize,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.drug.photoUrl))),
                    ),
                  ),

                  //Two buttons
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              // Get.toNamed(
                              //     RouteHelper.getAdminDrugMainScreen()
                              //  );
                              Get.back();
                            },
                            child: AppIcon(icon: Icons.arrow_back_ios)),
                      ],
                    ),
                  ),

                  //the white background on wich we have all details
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: Dimensions.popularFoodImgSize - 20,
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
                          color: Colors.white),

                      // the content of the white background

                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppColumn(text: widget.drug.title),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                children: [
                                  BigText(
                                    text: "Category ${tmp["address"]}",
                                  ),
                                  SizedBox(
                                    width: Dimensions.width30,
                                  ),
                                  BigText(
                                    text: widget.drug.categories,
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                children: [
                                  BigText(
                                    text: "Manufacturing date",
                                  ),
                                  SizedBox(
                                    width: Dimensions.width30,
                                  ),
                                  BigText(
                                    text: widget.drug.manufacturingDate,
                                    color: AppColors.yellowColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                children: [
                                  BigText(
                                    text: "Expiring date",
                                  ),
                                  SizedBox(
                                    width: Dimensions.width30,
                                  ),
                                  BigText(
                                    text: widget.drug.expiringDate,
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                children: [
                                  BigText(
                                    text: "Posted at",
                                  ),
                                  SizedBox(
                                    width: Dimensions.width20,
                                  ),
                                  BigText(
                                    text: widget.drug.publishedDate,
                                    color: AppColors.yellowColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                children: [
                                  BigText(
                                    text: "Price ",
                                  ),
                                  SizedBox(
                                    width: Dimensions.width30,
                                  ),
                                  Row(
                                    children: [
                                      BigText(
                                        text: 'BIF',
                                        color: Colors.redAccent,
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10 / 2,
                                      ),
                                      BigText(
                                        text: widget.drug.price.toString(),
                                        color: AppColors.mainColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                children: [
                                  BigText(
                                    text: "Quantity",
                                  ),
                                  SizedBox(
                                    width: Dimensions.width30,
                                  ),
                                  BigText(
                                    text: widget.drug.quantity.toString(),
                                    color: AppColors.yellowColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                children: [
                                  BigText(
                                    text: "Units",
                                  ),
                                  SizedBox(
                                    width: Dimensions.width30,
                                  ),
                                  BigText(
                                    text: widget.drug.units,
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                children: [
                                  BigText(
                                    text: "Status",
                                  ),
                                  SizedBox(
                                    width: Dimensions.width30,
                                  ),
                                  BigText(
                                    text: widget.drug.status,
                                    color: AppColors.yellowColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                children: [
                                  BigText(
                                    text: "Visibility",
                                  ),
                                  SizedBox(
                                    width: Dimensions.width30,
                                  ),
                                  BigText(
                                    text: widget.drug.visibility.toString(),
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              BigText(
                                text: "Description",
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              ExpandableTextWidget(
                                  text: widget.drug.description),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              BigText(
                                text: "Pharmacy informations",
                                color: AppColors.secondColor,
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              /*
                          StreamBuilder<QuerySnapshot>(
                              stream: firestore
                                  .collection('Users')
                                  .where('role', isEqualTo: "Pharmacy owner")
                                  .where('uid',
                                      isEqualTo:
                                          /* drugList[widget.pageId].uid*/ widget
                                              .drug.uid)
                                  .snapshots(),
                              builder: (c, snapshot) {
                                List<dynamic>? pharmaInfo =
                                    snapshot.data?.docs.map((pharmacy) {
                                  return User.fromSnap(pharmacy);
                                }).toList();
                                return snapshot.hasData
                                    ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              BigText(
                                                text: "Pharmacy Name",
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width30,
                                              ),
                                              BigText(
                                                  text: pharmaInfo![widget.pageId]
                                                      .username),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Dimensions.height20,
                                          ),
                                          Row(
                                            children: [
                                              BigText(
                                                text: "Email",
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width30,
                                              ),
                                              BigText(
                                                  text: pharmaInfo[widget.pageId]
                                                      .email),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Dimensions.height20,
                                          ),
                                          Row(
                                            children: [
                                              BigText(
                                                text: " Phone",
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width30,
                                              ),
                                              BigText(
                                                  text: pharmaInfo[widget.pageId]
                                                      .phone),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Dimensions.height20,
                                          ),
                                          Row(
                                            children: [
                                              BigText(
                                                text: "Address",
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width30,
                                              ),
                                              BigText(
                                                  text: pharmaInfo[widget.pageId]
                                                      .address),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Dimensions.height20,
                                          ),
                                        ],
                                      )
                                    : Container();
                              }),*/
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),

      //Bottom section

      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20 * 2),
              topLeft: Radius.circular(Dimensions.radius20 * 2),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  updateVisibilityField(/*widget.drugId*/ widget.drug.id);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(
                    text: 'Invalidate',
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future updateVisibilityField(String id) async {
    _isLoaded.value = true;
    await firestore
        .collection('Medicines')
        .doc(id)
        .update({"visibility": false}).then((value) => Get.back());
  }
}
