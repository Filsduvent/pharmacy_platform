// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, sort_child_properties_last
import 'package:pharmacy_plateform/controllers/recent_drug_controller.dart';
import 'package:pharmacy_plateform/controllers/slide_drug_controller.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class RecentDrugDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecentDrugDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var drug = Get.find<RecentDrugController>().recentDrugList[pageId];
    final SlideDrugController slideDrugController =
        Get.put(SlideDrugController());
    Future.delayed(Duration.zero, () {
      slideDrugController.initData(drug, Get.find<CartController>());
    });
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (page == "cartpage") {
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.clear),
                  ),
                  //AppIcon(icon: Icons.shopping_cart_outlined),

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
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(
                      child:
                          BigText(size: Dimensions.font26, text: drug.title!)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20),
                      )),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.mainColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  drug.photoUrl!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      child: ExpandableTextWidget(
                          text:
                              "This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've usedThis video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list. firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list." //drug.description!
                          )),
                ],
              ),
            ),
          ],
        ),

        // Bottom part
        bottomNavigationBar: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        slideDrugController.setQuantity(false.obs);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          icon: Icons.remove),
                    ),
                    BigText(
                      text:
                          "\$ ${drug.price} X ${slideDrugController.inCartItems}",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    GestureDetector(
                      onTap: () {
                        slideDrugController.setQuantity(true.obs);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          icon: Icons.add),
                    )
                  ],
                ),
              ),
              Container(
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        slideDrugController.addItem(drug);
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
