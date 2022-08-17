// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/user_model.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/account_widget.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';

class ValidSimpleUserDetails extends StatefulWidget {
  final int pageId;
  final String page;
  final String userId;
  const ValidSimpleUserDetails(
      {Key? key,
      required this.pageId,
      required this.page,
      required this.userId})
      : super(key: key);

  @override
  State<ValidSimpleUserDetails> createState() => _ValidSimpleUserDetailsState();
}

class _ValidSimpleUserDetailsState extends State<ValidSimpleUserDetails> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('Users')
              .where('role', isEqualTo: "Customer")
              .where('status', isEqualTo: "Activated")
              .snapshots(),
          builder: (c, snapshot) {
            List<dynamic>? customer = snapshot.data?.docs.map((user) {
              return User.fromSnap(user);
            }).toList();

            return snapshot.hasData
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
                                  image: NetworkImage(
                                      customer![widget.pageId].profilePhoto))),
                        ),
                      ),

                      //The button

                      Positioned(
                        top: Dimensions.height45,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  //   Get.toNamed(
                                  //       RouteHelper.getAdminPharmacistScreen());
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

                          child: Column(children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    //name
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.person,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text: customer[widget.pageId]
                                                .username)),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //phone
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.phone,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text:
                                                customer[widget.pageId].phone)),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //email
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.email,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text:
                                                customer[widget.pageId].email)),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //address
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.location_on,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text: customer[widget.pageId]
                                                .address)),

                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //role
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.functions,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text:
                                                customer[widget.pageId].role)),

                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),

                                    //status
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: Dimensions.width20,
                                          top: Dimensions.width10,
                                          bottom: Dimensions.width10),
                                      child: Row(children: [
                                        AppIcon(
                                          icon: Icons.connected_tv,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        SizedBox(
                                          width: Dimensions.width20,
                                        ),
                                        BigText(
                                            text:
                                                customer[widget.pageId].status),
                                        SizedBox(
                                          width: Dimensions.width30 * 4,
                                        ),
                                        buildSwitch(customer[widget.pageId].uid,
                                            customer[widget.pageId].status),
                                      ]),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius30),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              offset: Offset(0, 2),
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "assets/image/No_data.png",
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width * 0.22,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text(
                        "No data found",
                        style: TextStyle(
                            fontSize: Dimensions.font26,
                            color: Theme.of(context).disabledColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
          }),
    );
  }

  Widget buildSwitch(String id, String status) => Transform.scale(
        scale: 1.5,
        child: Switch.adaptive(
          activeColor: AppColors.mainColor,
          inactiveThumbColor: AppColors.yellowColor,
          inactiveTrackColor: Colors.orange.withOpacity(0.3),
          value: value,
          onChanged: (value) {
            if (status == "Activated") {
              firestore
                  .collection('Users')
                  .doc(id)
                  .update({"status": "Deactivated"});
            } else {
              firestore
                  .collection('Users')
                  .doc(id)
                  .update({"status": "Activated"});
            }
            // Get.toNamed(RouteHelper.getAdminPharmacistScreen());
            Get.back();
            setState(() {
              this.value = value;
            });
          },
        ),
      );
}
