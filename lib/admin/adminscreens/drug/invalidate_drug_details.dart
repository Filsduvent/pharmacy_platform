// ignore_for_file: sort_child_properties_last, prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/base/custom_loader.dart';
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
  bool _isLoaded = false;
  String? pharmaName = "";
  String? email = "";
  String? phone = "";
  String? address = "";

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.drug.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          pharmaName = snapshot.data()!["pharmaName"];
          email = snapshot.data()!["email"];
          phone = snapshot.data()!["phone"];
          address = snapshot.data()!["address"];
        });
      }
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: !_isLoaded
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
                                  text: "Category",
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
                            ExpandableTextWidget(text: widget.drug.description),
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
                            Column(
                              children: [
                                Row(
                                  children: [
                                    BigText(
                                      text: "Pharmacy Name",
                                      color: AppColors.yellowColor,
                                    ),
                                    SizedBox(
                                      width: Dimensions.width30,
                                    ),
                                    BigText(text: pharmaName!),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                Row(
                                  children: [
                                    BigText(
                                      text: "Email",
                                      color: AppColors.mainColor,
                                    ),
                                    SizedBox(
                                      width: Dimensions.width30,
                                    ),
                                    BigText(text: email!),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                Row(
                                  children: [
                                    BigText(
                                      text: " Phone",
                                      color: AppColors.yellowColor,
                                    ),
                                    SizedBox(
                                      width: Dimensions.width30,
                                    ),
                                    BigText(
                                      text: phone!,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                Row(
                                  children: [
                                    BigText(
                                      text: "Address",
                                      color: AppColors.mainColor,
                                    ),
                                    SizedBox(
                                      width: Dimensions.width30,
                                    ),
                                    BigText(text: address!),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                              ],
                            ),
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
            )
          : CustomLoader(),

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
                  updateVisibilityField(widget.drug.id);
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
    setState(() {
      _isLoaded = true;
    });
    await firestore
        .collection('Medicines')
        .doc(id)
        .update({"visibility": false}).then((value) {
      Get.back();
      setState(() {
        _isLoaded = false;
      });
    });
  }
}
