// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
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

class PharmacyDrugDetailsScreen extends StatefulWidget {
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
  State<PharmacyDrugDetailsScreen> createState() =>
      _PharmacyDrugDetailsScreenState();
}

class _PharmacyDrugDetailsScreenState extends State<PharmacyDrugDetailsScreen> {
  String? status = "";
  Future _getStatusFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID))
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          status = snapshot.data()!["status"];
        });
      }
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    _getStatusFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    var drugs = Get.find<SlideDrugController>().slideDrugList[widget.pageId];
    final SlideDrugController slideDrugController =
        Get.put(SlideDrugController());
    //final CartController cartController = Get.put(CartController(Get.find()));
    Future.delayed(Duration.zero, () {
      slideDrugController.initData(drugs, Get.find<CartController>());
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
                        if (widget.page == "cartpage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          // Get.toNamed(RouteHelper.getInitial());
                          Get.back();
                        }
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: AppColors.secondColor,
                      )),
                  GetBuilder<SlideDrugController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            iconColor: AppColors.secondColor,
                          ),
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
                              color: Color(0xFFccc7c5),
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
                              color: Color(0xFFccc7c5),
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
                              color: Color(0xFFccc7c5),
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
                              color: Color(0xFFccc7c5),
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
                                  color: AppColors.mainColor,
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
                              color: Color(0xFFccc7c5),
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
                              color: Color(0xFFccc7c5),
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
                              color: Color(0xFFccc7c5),
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
                          color: AppColors.mainBlackColor,
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
                                  color: AppColors.mainBlackColor,
                                ),
                                SizedBox(
                                  width: Dimensions.width30,
                                ),
                                BigText(
                                  text: widget.user.pharmaName,
                                  color: Color(0xFFccc7c5),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            Row(
                              children: [
                                BigText(
                                  text: "Email",
                                  color: AppColors.mainBlackColor,
                                ),
                                SizedBox(
                                  width: Dimensions.width30,
                                ),
                                BigText(
                                  text: widget.user.email,
                                  color: Color(0xFFccc7c5),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            Row(
                              children: [
                                BigText(
                                  text: " Phone",
                                  color: AppColors.mainBlackColor,
                                ),
                                SizedBox(
                                  width: Dimensions.width30,
                                ),
                                BigText(
                                  text: widget.user.phone,
                                  color: Color(0xFFccc7c5),
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
                                  color: AppColors.mainBlackColor,
                                ),
                                SizedBox(
                                  width: Dimensions.width30,
                                ),
                                BigText(
                                  text: widget.user.address,
                                  color: Color(0xFFccc7c5),
                                ),
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
                    if (firebaseAuth.currentUser != null &&
                        status == "Activated") {
                      if (slideDrugController.inCartItems >
                          widget.drug.quantity) {
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
                        slideDrugController.addItem(widget.drug);
                        addItemToCartById(widget.drug.id);
                      }
                    } else {
                      Get.toNamed(RouteHelper.getSignInPage());
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    child: BigText(
                      text: '\$ ${widget.drug.price} | Add to cart',
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
