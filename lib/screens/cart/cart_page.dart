// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_import, unused_local_variable, no_leading_underscores_for_local_identifiers
import 'dart:convert';

import 'package:pharmacy_plateform/base/no_data_page.dart';
import 'package:pharmacy_plateform/controllers/cart_controller.dart';
import 'package:pharmacy_plateform/controllers/slide_drug_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/cart_model.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import '../../controllers/recent_drug_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CartModel> retVal = [];
    final SlideDrugController slideDrugController =
        Get.put(SlideDrugController());
    return Scaffold(
      body: Stack(
        children: [
          //header
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // AppIcon(
                //   icon: Icons.arrow_back_ios,
                //   iconColor: Colors.white,
                //   backgroundColor: AppColors.mainColor,
                //   iconSize: Dimensions.iconSize24,
                // ),

                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
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
                          icon: Icons.shopping_cart,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          iconSize: Dimensions.iconSize24,
                        ),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.secondColor,
                                ),
                              )
                            : Container(),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text:
                                      slideDrugController.totalItems.toString(),
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

          //body
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.isNotEmpty
                ? Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height15),
                      //color: Colors.red,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                            builder: (cartController) {
                          var _cartList = cartController.getItems;

                          // final getCart = cartControllers.data;

                          // print(
                          //     "============ LOG: ${getCart['userCart'].toString().substring(3000)}");
                          // final cartContents =
                          //     jsonDecode(getCart['userCart'].toString())
                          //         as List;

                          // final cartContents = jsonDecode(cartControllers
                          //     .cartDrugList[0].userCart
                          //     .toString()) as List;

                          // print("------------------ ${getCart.runtimeType}");

                          // print(
                          //     "le client a dans son cart ${cartContents.length} produit.");

                          return ListView.builder(
                              itemCount: _cartList.length,
                              itemBuilder: (_, index) {
                                // print(
                                //     "===============> ${cartContents[index]['title']} - ${cartContents[index]['time']}");
                                return Container(
                                  width: double.maxFinite,
                                  height: Dimensions.height20 * 5,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var slideIndex =
                                              Get.find<SlideDrugController>()
                                                  .slideDrugList
                                                  .indexOf(
                                                      _cartList[index].drug!);

                                          if (slideIndex >= 0) {
                                            Get.toNamed(
                                                RouteHelper.getPopularDrug(
                                                    slideIndex, "cartpage"));
                                          } else {
                                            var recentIndex =
                                                Get.find<RecentDrugController>()
                                                    .recentDrugList
                                                    .indexOf(
                                                        _cartList[index].drug!);
                                            if (recentIndex < 0) {
                                              Get.snackbar(
                                                "History product",
                                                "Product review is not available for history products",
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                colorText: Colors.white,
                                              );
                                            } else {
                                              Get.toNamed(
                                                  RouteHelper.getRecentDrug(
                                                      recentIndex, "cartpage"));
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                              bottom: Dimensions.height10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      /*cartContents[index][
                                                          'photoUrl'] */
                                                      cartController
                                                              .getItems[index]
                                                              .photoUrl ??
                                                          "")),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      Expanded(
                                          child: Container(
                                        height: Dimensions.height20 * 5,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                text: /*cartContents[index]
                                                    ['title']*/
                                                    cartController
                                                            .getItems[index]
                                                            .title ??
                                                        "",
                                                color: Colors.black54,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text:
                                                        "BIF ${cartController.getItems[index].price.toString() /*cartContents[index]['price'].toString()*/}",
                                                    color: AppColors.mainColor,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            Dimensions.height10,
                                                        bottom:
                                                            Dimensions.height10,
                                                        left:
                                                            Dimensions.width10,
                                                        right:
                                                            Dimensions.width10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius20),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController
                                                                .addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .drug!,
                                                                    -1);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        BigText(
                                                            text: _cartList[
                                                                    index]
                                                                .quantity
                                                                .toString()), // popularProduct.inCartItems.toString()),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController
                                                                .addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .drug!,
                                                                    1);
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]),
                                      ))
                                    ],
                                  ),
                                );
                              });
                        }),
                      ),
                    ))
                : NoDataPage(text: "Your cart is empty!");
          })
        ],
      ),
      // bottom section
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
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
          child: cartController.getItems.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height15,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          BigText(
                              text:
                                  "BIF ${cartController.totalAmount.toString()} "),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (firebaseAuth.currentUser != null) {
                          Get.offAllNamed(RouteHelper.getAddressScreen());
                          //cartController.addToHistory();
                        } else {
                          Get.toNamed(RouteHelper.getSignInPage());
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height15,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.secondColor,
                        ),
                        child: BigText(
                          text: 'Check out',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        );
      }),
    );
  }
}
