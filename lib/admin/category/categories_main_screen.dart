// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/categories_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CategoriesMainScreen extends StatefulWidget {
  const CategoriesMainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesMainScreen> createState() => _CategoriesMainScreenState();
}

class _CategoriesMainScreenState extends State<CategoriesMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('Categories').snapshots(),
          builder: (c, snapshot) {
            return Stack(
              children: [
                // color cover back ground
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.popularFoodImgSize,
                    color: AppColors.mainColor,
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
                            Get.toNamed(RouteHelper.getAdminHomeScreen());
                          },
                          child: AppIcon(
                            icon: Icons.arrow_back_ios,
                            iconColor: AppColors.mainColor,
                          )),
                      AppIcon(
                        icon: Icons.search,
                        iconColor: AppColors.mainColor,
                      )
                    ],
                  ),
                ),

                //The container with the number of items in firebase
                Positioned(
                  top: Dimensions.height20 * 5,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Container(
                    height: Dimensions.height45 * 1.3,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.secondColor,
                      borderRadius: BorderRadius.circular(29.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0.8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(
                                text: "Number of categories : ",
                                color: Colors.white,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                    bottom: Dimensions.height10,
                                    left: Dimensions.width10,
                                    right: Dimensions.width10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Dimensions.width10 / 2,
                                    ),
                                    BigText(
                                        text: snapshot.hasData
                                            ? snapshot.data!.docs.length
                                                .toString()
                                            : "0"),
                                    SizedBox(
                                      width: Dimensions.width10 / 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                        top: Dimensions.height10 / 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          topLeft: Radius.circular(Dimensions.radius20),
                        ),
                        color: Colors.white),

                    // the content of the white background

                    child: snapshot.hasData
                        ? Stack(
                            children: [
                              ListView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var listCategory =
                                        snapshot.data!.docs.map((category) {
                                      return CategoriesModel.fromjson(category);
                                    }).toList();
                                    // final recentdata =
                                    //     recentdrugController.recentDrugList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        //Get.toNamed(RouteHelper.getRecentDrug(index, "home"));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: Dimensions.width20,
                                            right: Dimensions.width20,
                                            bottom: Dimensions.height10),
                                        child: Row(
                                          children: [
                                            //image section
                                            Container(
                                              width:
                                                  Dimensions.listViewImgSize *
                                                      0.8,
                                              height:
                                                  Dimensions.listViewImgSize *
                                                      0.8,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                color: Colors.white38,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        listCategory[index]
                                                            .image
                                                            .toString())),
                                              ),
                                            ),
                                            //text container
                                            Expanded(
                                              child: Container(
                                                height: Dimensions
                                                        .listViewTextContSize *
                                                    0.8,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        Dimensions.radius20),
                                                    bottomRight:
                                                        Radius.circular(
                                                            Dimensions
                                                                .radius20),
                                                  ),
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: Dimensions.width20,
                                                      right:
                                                          Dimensions.width10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      BigText(
                                                          text: listCategory[
                                                                  index]
                                                              .name
                                                              .toString()),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height10,
                                                      ),
                                                      BigText(
                                                        text:
                                                            listCategory[index]
                                                                .description
                                                                .toString(),
                                                        color: AppColors
                                                            .secondColor,
                                                        size: Dimensions.font16,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
              ],
            );
          }),
      // floatingactionbutton
      floatingActionButton: buildNavigateButton(),
    );
  }

  buildNavigateButton() => FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: AppColors.secondColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15)),
        onPressed: () {
          categoryController.pickImage(context);
        },
      );
}
