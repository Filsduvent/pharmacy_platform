// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/base/no_data_page.dart';
import 'package:pharmacy_plateform/screens/pharmacy/pharmacy_drug_screen.dart';
import '../../models/user_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          title: BigText(text: "Pharmacy", size: 24, color: Colors.white),
        ),

        //Body
        body: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('Users')
                .where('role', isEqualTo: "Pharmacy owner")
                .where('status', isEqualTo: "Activated")
                .snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData
                  ? SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.height30,
                            bottom: Dimensions.height30),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              List<dynamic> Pharma =
                                  snapshot.data!.docs.map((user) {
                                return User.fromSnap(user);
                              }).toList();
                              User user = Pharma[index];

                              return user.pharmaName == "Default Name"
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        // Get.toNamed(RouteHelper.getAdminUserDetailsScreen(
                                        //   index,
                                        //   "details",
                                        //   Pharma[index].uid,
                                        // ));
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           PharmacyDrugScreen(
                                        //               pageId: index,
                                        //               page: "all",
                                        //               user: user),
                                        //     ));
                                        Get.to(
                                          PharmacyDrugScreen(
                                              pageId: index,
                                              page: "all",
                                              user: user),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: Dimensions.width10,
                                            right: Dimensions.width10,
                                            bottom: Dimensions.height20),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius30),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 1,
                                                offset: const Offset(0, 2),
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                              )
                                            ]),
                                        child: Row(
                                          children: [
                                            //image section
                                            Container(
                                              width:
                                                  Dimensions.listViewImgSize *
                                                      1.1,
                                              height:
                                                  Dimensions.listViewImgSize *
                                                      1.1,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius30),
                                                color: Colors.white38,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        user.pharmaIcon)),
                                              ),
                                            ),
                                            //text container
                                            Expanded(
                                              child: Container(
                                                width: (Dimensions
                                                            .listViewTextContSize +
                                                        20) *
                                                    1.1,
                                                height: (Dimensions
                                                            .listViewTextContSize +
                                                        20) *
                                                    1.1,
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
                                                  color: Colors.white,
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
                                                          text:
                                                              user.pharmaName),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height10,
                                                      ),
                                                      BigText(
                                                        text: user.email,
                                                        color: AppColors
                                                            .secondColor,
                                                        size: Dimensions.font16,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height10,
                                                      ),
                                                      BigText(
                                                        text: user.phone,
                                                        color: AppColors
                                                            .secondColor,
                                                        size: Dimensions.font16,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          IconAndTextWidget(
                                                              icon: Icons.email,
                                                              text: 'mail',
                                                              iconColor: AppColors
                                                                  .iconColor1),
                                                          IconAndTextWidget(
                                                              icon: Icons
                                                                  .location_on,
                                                              text: 'location',
                                                              iconColor: AppColors
                                                                  .mainColor),
                                                          IconAndTextWidget(
                                                              icon: Icons
                                                                  .medical_information,
                                                              text: 'drug',
                                                              iconColor: AppColors
                                                                  .iconColor2),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PharmacyDrugScreen(
                                                              pageId: index,
                                                              page: "all",
                                                              user: user),
                                                    ));
                                              },
                                              child: Container(
                                                width: Dimensions.width20,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color:
                                                          AppColors.mainColor,
                                                      size:
                                                          Dimensions.iconSize16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                            }),
                      ),
                    )
                  : const NoDataPage(
                      text: "No drug available",
                      imgPath: "assets/image/No_data.png",
                    );
            }));
  }
}
