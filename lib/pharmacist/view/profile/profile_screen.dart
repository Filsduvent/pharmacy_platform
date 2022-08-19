import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/route_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/account_widget.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';

class PharmacistProfileScreen extends StatefulWidget {
  const PharmacistProfileScreen({Key? key}) : super(key: key);

  @override
  State<PharmacistProfileScreen> createState() =>
      _PharmacistProfileScreenState();
}

class _PharmacistProfileScreenState extends State<PharmacistProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          title: BigText(text: "Profile", size: 24, color: Colors.white),
          leading: GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getMainPharmacyPage());
            },
            child: Container(
              child: AppIcon(
                icon: Icons.arrow_back_ios,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
              ),
            ),
          ),
          elevation: 0,
        ),

        //Body
        body: Stack(
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
                  child: AppConstants.sharedPreferences!
                              .getString(AppConstants.userProfilePhoto) ==
                          null
                      ? AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height45 + Dimensions.height30,
                          size: Dimensions.height15 * 10,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            child: CircleAvatar(
                              radius:
                                  Dimensions.radius30 * 2 + Dimensions.radius15,
                              backgroundImage: NetworkImage(
                                AppConstants.sharedPreferences!
                                    .getString(AppConstants.userProfilePhoto)
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
                                  text: AppConstants.sharedPreferences!
                                      .getString(AppConstants.userName)
                                      .toString())),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //phone
                          AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.phone,
                                backgroundColor: AppColors.yellowColor,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10 * 5 / 2,
                                size: Dimensions.height10 * 5,
                              ),
                              bigText: BigText(
                                  text: AppConstants.sharedPreferences!
                                      .getString(AppConstants.userPhone)
                                      .toString())),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //email
                          AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.email,
                                backgroundColor: AppColors.yellowColor,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10 * 5 / 2,
                                size: Dimensions.height10 * 5,
                              ),
                              bigText: BigText(
                                  text: AppConstants.sharedPreferences!
                                      .getString(AppConstants.userEmail)
                                      .toString())),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //address
                          AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.location_on,
                                backgroundColor: AppColors.yellowColor,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10 * 5 / 2,
                                size: Dimensions.height10 * 5,
                              ),
                              bigText: BigText(
                                  text: AppConstants.sharedPreferences!
                                      .getString(AppConstants.userAddress)
                                      .toString())),

                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //role
                          AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.functions,
                                backgroundColor: AppColors.yellowColor,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10 * 5 / 2,
                                size: Dimensions.height10 * 5,
                              ),
                              bigText: BigText(
                                  text: AppConstants.sharedPreferences!
                                      .getString(AppConstants.userRole)
                                      .toString())),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //status
                          AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.connected_tv,
                                backgroundColor: AppColors.yellowColor,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10 * 5 / 2,
                                size: Dimensions.height10 * 5,
                              ),
                              bigText: BigText(
                                  text: AppConstants.sharedPreferences!
                                      .getString(AppConstants.userStatus)
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
                                    title: const Text('Are you sure?'),
                                    content: BigText(
                                      text: "Exit",
                                      color: AppColors.mainBlackColor,
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            //print('Im tapeeeeeeeed');
                                            if (firebaseAuth.currentUser !=
                                                null) {
                                              authController.clearShareData();
                                              cartControllers.clear();
                                              cartControllers
                                                  .clearCartHistory();

                                              emptyCartNow() {
                                                AppConstants.sharedPreferences!
                                                    .setStringList(
                                                        AppConstants
                                                            .userCartList,
                                                        ["garbageValue"]);
                                                List<String> tempList =
                                                    AppConstants
                                                            .sharedPreferences!
                                                            .getStringList(
                                                                AppConstants
                                                                    .userCartList)
                                                        as List<String>;

                                                firestore
                                                    .collection('Users')
                                                    .doc(AppConstants
                                                        .sharedPreferences!
                                                        .getString(AppConstants
                                                            .userUID))
                                                    .update({
                                                  AppConstants.userCartList:
                                                      tempList,
                                                }).then((value) {
                                                  AppConstants
                                                      .sharedPreferences!
                                                      .setStringList(
                                                          AppConstants
                                                              .userCartList,
                                                          tempList);
                                                });
                                              }

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
                                            color: AppColors.mainColor,
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
                                  iconSize: Dimensions.height10 * 5 / 2,
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
        ));
  }
}
