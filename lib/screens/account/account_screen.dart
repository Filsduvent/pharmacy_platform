// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/base/custom_loader.dart';
import 'package:pharmacy_plateform/controllers/profile_controller.dart';
import 'package:pharmacy_plateform/models/user_model.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            //appBar
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColors.mainColor,
              title: BigText(text: "Profile", size: 24, color: Colors.white),
            ),

            //Body
            body: firebaseAuth.currentUser != null
                ? Stack(
                    children: [
                      Positioned(
                          left: 0,
                          right: 0,
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.popularFoodImgSize / 1.6,
                          )),
                      Positioned(
                        left: Dimensions.height30 * 4,
                        right: Dimensions.height30 * 4,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: Dimensions.height20 * 0.7,
                          ),
                          child: Center(
                            child: AppConstants.sharedPreferences!.getString(
                                        AppConstants.userProfilePhoto) ==
                                    null
                                ? AppIcon(
                                    icon: Icons.person,
                                    backgroundColor: AppColors.mainColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height45 +
                                        Dimensions.height30,
                                    size: Dimensions.height15 * 10,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      child: CircleAvatar(
                                        radius: Dimensions.radius30 * 2 +
                                            Dimensions.radius15,
                                        backgroundImage: NetworkImage(
                                          AppConstants.sharedPreferences!
                                              .getString(
                                                  AppConstants.userProfilePhoto)
                                              .toString(),
                                        ),
                                        backgroundColor: AppColors.mainColor,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: (Dimensions.popularFoodImgSize - 20) / 1.6,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              top: Dimensions.height20 * 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                topLeft: Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.grey.withOpacity(0.1)),

                          //All content field
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
                                            text: AppConstants
                                                .sharedPreferences!
                                                .getString(
                                                    AppConstants.userName)
                                                .toString())),
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
                                            text: AppConstants
                                                .sharedPreferences!
                                                .getString(
                                                    AppConstants.userPhone)
                                                .toString())),
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
                                            text: AppConstants
                                                .sharedPreferences!
                                                .getString(
                                                    AppConstants.userEmail)
                                                .toString())),
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
                                            text: AppConstants
                                                .sharedPreferences!
                                                .getString(
                                                    AppConstants.userAddress)
                                                .toString())),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //message
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.message_outlined,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "Messages")),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //logout
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Are you sure?'),
                                              content: BigText(
                                                text:
                                                    "You are Quitting the App",
                                                color: AppColors.mainBlackColor,
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      //print('Im tapeeeeeeeed');
                                                      if (firebaseAuth
                                                              .currentUser !=
                                                          null) {
                                                        authController
                                                            .clearShareData();
                                                        cartController.clear();
                                                        cartController
                                                            .clearCartHistory();
                                                        authController.logOut();
                                                      }
                                                    },
                                                    child: BigText(
                                                      text: "Yes",
                                                      color: Colors.redAccent,
                                                    )),
                                                TextButton(
                                                    onPressed: () => Get.back(),
                                                    child: BigText(
                                                      text: "No",
                                                      color:
                                                          AppColors.mainColor,
                                                    ))
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.logout,
                                            backgroundColor: Colors.redAccent,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(text: "Logout")),
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
                : Container(
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 8,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("assets/image/account.png"))),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 5,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Center(
                              child: BigText(
                                text: "Sign in",
                                color: Colors.white,
                                size: Dimensions.font26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
          );
        });
  }
}
