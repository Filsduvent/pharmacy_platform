// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, sort_child_properties_last
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy_plateform/controllers/recent_drug_controller.dart';
import 'package:pharmacy_plateform/controllers/slide_drug_controller.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../models/drug_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class RecentDrugDetail extends StatefulWidget {
  final int pageId;
  final String page;
  final Drug drug;
  const RecentDrugDetail(
      {Key? key, required this.pageId, required this.page, required this.drug})
      : super(key: key);

  @override
  State<RecentDrugDetail> createState() => _RecentDrugDetailState();
}

class _RecentDrugDetailState extends State<RecentDrugDetail> {
  String? pharmaName = "";
  String? email = "";
  String? phone = "";
  String? address = "";
  String? status = "";

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

  Future _getStatusFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
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

    _getDataFromDatabase();
    _getStatusFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    var drug = Get.find<RecentDrugController>().recentDrugList[widget.pageId];
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
                      if (widget.page == "cartpage") {
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(
                      icon: Icons.clear,
                      iconColor: AppColors.secondColor,
                    ),
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
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(
                      child:
                          BigText(size: Dimensions.font26, text: drug.title)),
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
                  drug.photoUrl,
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
                              color: const Color(0xFFccc7c5),
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
                              color: const Color(0xFFccc7c5),
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
                              color: const Color(0xFFccc7c5),
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
                              color: const Color(0xFFccc7c5),
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
                              color: const Color(0xFFccc7c5),
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
                              color: const Color(0xFFccc7c5),
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
                              color: const Color(0xFFccc7c5),
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
                                  text: pharmaName!,
                                  color: const Color(0xFFccc7c5),
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
                                  text: email!,
                                  color: const Color(0xFFccc7c5),
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
                                    color: AppColors.mainBlackColor),
                                SizedBox(
                                  width: Dimensions.width30,
                                ),
                                BigText(
                                  text: phone!,
                                  color: const Color(0xFFccc7c5),
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
                                  text: address!,
                                  color: const Color(0xFFccc7c5),
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
                          backgroundColor: AppColors.secondColor,
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
                          backgroundColor: AppColors.secondColor,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   padding: EdgeInsets.only(
                    //       top: Dimensions.height20,
                    //       bottom: Dimensions.height20,
                    //       left: Dimensions.width20,
                    //       right: Dimensions.width20),
                    //   decoration: BoxDecoration(
                    //     borderRadius:
                    //         BorderRadius.circular(Dimensions.radius20),
                    //     color: Colors.white,
                    //   ),
                    //   child: Icon(
                    //     Icons.favorite,
                    //     color: AppColors.mainColor,
                    //   ),
                    // ),
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
