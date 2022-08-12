// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';

import '../../../models/drug_model.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_column.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/expandable_text_widget.dart';

class AdminValidDetailsScreen extends StatefulWidget {
  final int pageId;
  final String page;
  final String drugId;
  const AdminValidDetailsScreen(
      {Key? key,
      required this.pageId,
      required this.page,
      required this.drugId})
      : super(key: key);

  @override
  State<AdminValidDetailsScreen> createState() =>
      _AdminValidDetailsScreenState();
}

class _AdminValidDetailsScreenState extends State<AdminValidDetailsScreen> {
  final Rx<bool> _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('Medicines')
              .where('visibility', isEqualTo: false)
              .snapshots(),
          builder: (c, snapshot) {
            var drugList = snapshot.data?.docs.map((category) {
              return Drug.fromSnap(category);
            }).toList();
            //  var drug = drugList![widget.pageId];
            return snapshot.hasData
                ? Stack(
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
                                  image: NetworkImage(
                                      drugList![widget.pageId].photoUrl))),
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
                                  Get.toNamed(
                                      RouteHelper.getAdminDrugMainScreen());
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

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppColumn(text: drugList[widget.pageId].title),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              BigText(text: "Description"),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: ExpandableTextWidget(
                                      text:
                                          drugList[widget.pageId].description),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        updateVisibilityField(
                                            drugList[widget.pageId].id);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: Dimensions.height20,
                                            bottom: Dimensions.height20,
                                            left: Dimensions.width20,
                                            right: Dimensions.width20),
                                        child: BigText(
                                          text: 'Validate',
                                          color: Colors.white,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: AppColors.mainColor,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container();
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
                  updateVisibilityField(widget.drugId);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(
                    text: 'Validate',
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
        .update({"visibility": true}).then(
            (value) => Get.toNamed(RouteHelper.getAdminDrugMainScreen()));
  }
}
