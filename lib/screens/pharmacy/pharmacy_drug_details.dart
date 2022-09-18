// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers

import 'package:pharmacy_plateform/controllers/cart_controller.dart';
import 'package:pharmacy_plateform/controllers/slide_drug_controller.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import 'package:pharmacy_plateform/widgets/app_icon.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/drug_model.dart';
import '../../models/user_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/expandable_text_widget.dart';

class PharmacyDrugDetailsScreen extends StatelessWidget {
  final int pageId;
  final String page;
  final Drug drug;
  final User user;
  const PharmacyDrugDetailsScreen(
      {Key? key,
      required this.pageId,
      required this.page,
      required this.drug,
      required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var drugs = Get.find<SlideDrugController>().slideDrugList[pageId];
    final SlideDrugController slideDrugController =
        Get.put(SlideDrugController());
    //final CartController cartController = Get.put(CartController(Get.find()));
    Future.delayed(Duration.zero, () {
      slideDrugController.initData(drug, Get.find<CartController>());
    });

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
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
                        fit: BoxFit.cover, image: NetworkImage(drug.photoUrl))),
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
                        if (page == "cartpage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          // Get.toNamed(RouteHelper.getInitial());
                          Get.back();
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<SlideDrugController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: BigText(
                                    text: slideDrugController.totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            //the white background on wich we have all delails
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
                        AppColumn(text: drug.title),
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
                              text: drug.categories,
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
                              text: drug.manufacturingDate,
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
                              text: drug.expiringDate,
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
                              text: drug.publishedDate,
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
                                  text: drug.price.toString(),
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
                              text: drug.quantity.toString(),
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
                              text: drug.units,
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
                              text: drug.status,
                              color: AppColors.yellowColor,
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
                        ExpandableTextWidget(text: drug.description),
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
                                BigText(text: user.pharmaName),
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
                                BigText(text: user.email),
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
                                  text: user.phone,
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
                                BigText(text: user.address),
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
        ),

        //Bottom section

        bottomNavigationBar: Obx(() {
          return Container(
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
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          slideDrugController.setQuantity(false.obs);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(text: ("${slideDrugController.inCartItems}")),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          slideDrugController.setQuantity(true.obs);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (slideDrugController.inCartItems > drug.quantity) {
                      Get.snackbar(
                        "Item count",
                        "Your requested quantity is greater than the available one please check the quantity",
                        backgroundColor: AppColors.mainColor,
                        colorText: Colors.white,
                        icon: const Icon(
                          Icons.alarm,
                          color: Colors.white,
                        ),
                        barBlur: 20,
                        isDismissible: true,
                        duration: const Duration(seconds: 5),
                      );
                    } else {
                      slideDrugController.addItem(drug);
                      addItemToCartById(drug.id);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    child: BigText(
                      text: '\$ ${drug.price} | Add to cart',
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
          );
        }));
  }
}

void checkItemInCart(String id) {
  AppConstants.sharedPreferences!
          .getStringList(AppConstants.userCartList)!
          .contains(id)
      ? null
      : addItemToCartById(id);
}

void addItemToCartById(String id) {
  List<String> tempCartList = AppConstants.sharedPreferences!
      .getStringList(AppConstants.userCartList) as List<String>;
  tempCartList.add(id);

  firestore
      .collection('Users')
      .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID))
      .update({AppConstants.userCartList: tempCartList});

  AppConstants.sharedPreferences!
      .setStringList(AppConstants.userCartList, tempCartList);
}
