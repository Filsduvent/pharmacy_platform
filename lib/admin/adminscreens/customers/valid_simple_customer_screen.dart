// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/admin/adminscreens/customers/val_simple_user_details.dart';
import 'package:pharmacy_plateform/models/user_model.dart';
import '../../../base/no_data_page.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/icon_and_text_widget.dart';

class ValidSimpleCustomerScreen extends StatefulWidget {
  const ValidSimpleCustomerScreen({Key? key}) : super(key: key);

  @override
  State<ValidSimpleCustomerScreen> createState() =>
      _ValidSimpleCustomerScreenState();
}

class _ValidSimpleCustomerScreenState extends State<ValidSimpleCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('Users')
                    .where('role', isEqualTo: "Customer")
                    .where('status', isEqualTo: "Activated")
                    .snapshots(),
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

                      //The container with the number of items in firebase
                      Positioned(
                        top: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        child: Container(
                          height: Dimensions.height45 * 1.3,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.secondColor,
                            borderRadius: BorderRadius.circular(29.5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: "Valid simple customers : ",
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
                        top: Dimensions.popularFoodImgSize - 190,
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
                          child: snapshot.hasData &&
                                  snapshot.data!.docs.isNotEmpty
                              ? Stack(
                                  children: [
                                    ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          List<dynamic> customer =
                                              snapshot.data!.docs.map((user) {
                                            return User.fromSnap(user);
                                          }).toList();
                                          User customers = customer[index];
                                          return GestureDetector(
                                            onTap: () {
                                              // Get.toNamed(RouteHelper
                                              //     .getValidSimpleUserDetailsScreen(
                                              //   index,
                                              //   "details",
                                              //   customer[index].uid,
                                              // ));
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ValidSimpleUserDetails(
                                                            pageId: index,
                                                            page: "details",
                                                            user: customers),
                                                  ));
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
                                                    width: Dimensions
                                                        .listViewImgSize,
                                                    height: Dimensions
                                                        .listViewImgSize,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                                  .radius20 /
                                                              2),
                                                      color: Colors.white38,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              customers
                                                                  .profilePhoto)),
                                                    ),
                                                  ),
                                                  //text container
                                                  Expanded(
                                                    child: Container(
                                                      height: Dimensions
                                                              .listViewTextContSize +
                                                          20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  Dimensions
                                                                      .radius20),
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
                                                            left: Dimensions
                                                                .width20,
                                                            right: Dimensions
                                                                .width10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            BigText(
                                                                text: customers
                                                                    .username),
                                                            SizedBox(
                                                              height: Dimensions
                                                                  .height10,
                                                            ),
                                                            BigText(
                                                              text: customers
                                                                  .email,
                                                              color: AppColors
                                                                  .secondColor,
                                                              size: Dimensions
                                                                  .font16,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            SizedBox(
                                                              height: Dimensions
                                                                  .height10,
                                                            ),
                                                            BigText(
                                                              text: customers
                                                                  .phone,
                                                              color: AppColors
                                                                  .secondColor,
                                                              size: Dimensions
                                                                  .font16,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            SizedBox(
                                                              height: Dimensions
                                                                  .height10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                IconAndTextWidget(
                                                                    icon: Icons
                                                                        .email,
                                                                    text:
                                                                        'Mail',
                                                                    iconColor:
                                                                        AppColors
                                                                            .iconColor1),
                                                                IconAndTextWidget(
                                                                    icon: Icons
                                                                        .location_on,
                                                                    text:
                                                                        'Location',
                                                                    iconColor:
                                                                        AppColors
                                                                            .mainColor),
                                                                IconAndTextWidget(
                                                                    icon: Icons
                                                                        .medical_information,
                                                                    text:
                                                                        'Drugs',
                                                                    iconColor:
                                                                        AppColors
                                                                            .iconColor2),
                                                              ],
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
                              : NoDataPage(
                                  text: "No customer found",
                                  imgPath: "assets/image/customer.png",
                                ),
                        ),
                      ),
                    ],
                  );
                })));
  }
}
