// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import '../../../utils/colors.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/icon_and_text_widget.dart';
import '../../../widgets/small_text.dart';

class PharmacyMedicinesScreen extends StatelessWidget {
  const PharmacyMedicinesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // color cover back ground
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              color: Colors.black12,
            ),
          ),

          //Two buttons

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

          //the white background on wich we have all delails
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 120,
            child: Container(
              padding: EdgeInsets.only(
                  // left: Dimensions.width20,
                  // right: Dimensions.width20,
                  top: Dimensions.height10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white),

              // the content of the white background

              child: Stack(
                children: [
                  GridView.builder(
                      itemCount: 10,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        /* return Card(
                        color: Colors.red,
                      );*/

                        return GestureDetector(
                          onTap: () {},
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: Dimensions.width30 * 9,
                                  height: Dimensions.pageViewContainer / 1.4,
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  padding: EdgeInsets.all(0.8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius30),
                                      color: index.isEven
                                          ? Color(0xFF69c5df)
                                          : Color(0xFF9294cc),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/pharmacyplatform-45bdc.appspot.com/o/pills4.webp?alt=media&token=f6d8f90d-cfb5-4192-b9b9-d9d61bf0d9f8'))),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height:
                                      Dimensions.pageViewTextContainer / 1.5,
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width20,
                                      right: Dimensions.width20,
                                      bottom: Dimensions.height10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFFe8e8e8),
                                            blurRadius: 5.0,
                                            offset: Offset(0, 5)),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0, -5),
                                        ),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(5, 0),
                                        )
                                      ]),
                                  child: Container(
                                    width: Dimensions.pageView,
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height10 / 3,
                                        left: Dimensions.width15 / 3,
                                        right: Dimensions.width15 / 3),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SmallText(
                                          text: "Palumil",
                                          color: AppColors.mainBlackColor,
                                          size: Dimensions.font20,
                                        ),
                                        SizedBox(
                                            height: Dimensions.height10 / 3),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SmallText(
                                              text: "\$1287",
                                              size: Dimensions.font20,
                                              color: Colors.redAccent,
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10 / 3,
                                            ),
                                            SmallText(
                                              text: "available",
                                              size: Dimensions.font20,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: Dimensions.height10 / 3),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.circle_sharp,
                                              color: AppColors.iconColor1,
                                              size: Dimensions.iconSize16,
                                            ),
                                            Icon(
                                              Icons.location_on,
                                              color: AppColors.mainColor,
                                              size: Dimensions.iconSize16,
                                            ),
                                            Icon(
                                              Icons.access_time_rounded,
                                              color: AppColors.iconColor2,
                                              size: Dimensions.iconSize16,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  /*child: Container(
                                  padding: EdgeInsets.only(
                                      top: Dimensions.height10,
                                      left: Dimensions.width15,
                                      right: Dimensions.width15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BigText(text: "Palumil"),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        children: [
                                          Wrap(
                                            children: List.generate(5, (index) {
                                              return Icon(Icons.star,
                                                  color: AppColors.mainColor,
                                                  size: 15);
                                            }),
                                          ),
                                          SizedBox(
                                            width: Dimensions.width10,
                                          ),
                                          SmallText(text: "4.5"),
                                          SizedBox(
                                            width: Dimensions.width10,
                                          ),
                                          SmallText(text: "1287"),
                                          SizedBox(
                                            width: Dimensions.width10,
                                          ),
                                          SmallText(text: "comments"),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: "1.7km",
                                              iconColor: AppColors.mainColor),
                                          IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              text: "32min",
                                              iconColor: AppColors.iconColor2)
                                        ],
                                      )
                                    ],
                                  ),
                                ),*/
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),

      //Bottom section
/*
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: BigText(
                  text: 'Delete',
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: BigText(
                  text: 'Update',
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
              ),
            ),
          ],
        ),
      ),*/
    );
  }
}
