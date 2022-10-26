// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/pharmacist/model/menu_item.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/drawer/menu_items.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/colors.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';
import '../../../../routes/route_helper.dart';
import '../widgets/navigation_drawer_widget.dart';

class MainPharmacyScreen extends StatefulWidget {
  const MainPharmacyScreen({Key? key}) : super(key: key);

  @override
  State<MainPharmacyScreen> createState() => _MainPharmacyScreenState();
}

class _MainPharmacyScreenState extends State<MainPharmacyScreen> {
  String? status = "";
  Future _getStatusFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: BigText(text: "Pharmacist Dashboard", color: Colors.white),
        elevation: 0,
        centerTitle: true,
        actions: [
          PopupMenuButton<MenuItems>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    ...MenuItemsList.itemsFirst.map(buildItem).toList(),
                    PopupMenuDivider(),
                    ...MenuItemsList.itemsSecond.map(buildItem).toList(),
                  ])
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * .40,
            decoration:
                BoxDecoration(color: AppColors.mainColor /*Color(0xFFf5CEBB)*/),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: 10),
                  //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(29.5),
                  //   ),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       hintText: "Search",
                  //       icon: Icon(Icons.search),
                  //       border: InputBorder.none,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: Dimensions.height45 * 2,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.secondColor,
                      borderRadius: BorderRadius.circular(29.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: firestore
                                .collection('Medicines')
                                .where('uid',
                                    isEqualTo: AppConstants.sharedPreferences!
                                        .getString(AppConstants.userUID))
                                .snapshots(),
                            builder: (c, snapshot) {
                              return Padding(
                                padding: EdgeInsets.all(0.8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: "Medicine store : ",
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
                              );
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20 * 6,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        CategoryCard(
                          imgSrc: "assets/image/medicine.png",
                          title: "MEDICINES",
                          press: () {
                            if (status == "Activated") {
                              Get.toNamed(
                                  RouteHelper.getPharmacyMedecinePage());
                            } else {
                              if (firebaseAuth.currentUser != null) {
                                authController.clearShareData();
                                cartControllers.clear();
                                cartControllers.clearCartHistory();
                                authController.logOut();
                              }
                            }
                          },
                        ),
                        CategoryCard(
                            imgSrc: "assets/image/orders.png",
                            title: "ORDERS",
                            press: () {
                              if (status == "Activated") {
                                Get.toNamed(
                                    RouteHelper.getPharmacistOrderScreen());
                              } else {
                                if (firebaseAuth.currentUser != null) {
                                  authController.clearShareData();
                                  cartControllers.clear();
                                  cartControllers.clearCartHistory();
                                  authController.logOut();
                                }
                              }
                            }),
                        CategoryCard(
                            imgSrc: "assets/image/profiles.png",
                            title: "PROFILE",
                            press: () {
                              if (status == "Activated") {
                                Get.toNamed(
                                    RouteHelper.getPharmacistProfileScreen());
                              } else {
                                if (firebaseAuth.currentUser != null) {
                                  authController.clearShareData();
                                  cartControllers.clear();
                                  cartControllers.clearCartHistory();
                                  authController.logOut();
                                }
                              }
                            }),
                        CategoryCard(
                            imgSrc: "assets/image/personalize.png",
                            title: "PERSONALIZE",
                            press: () {
                              if (status == "Activated") {
                                Get.toNamed(
                                    RouteHelper.getPersonalizePharmacyScreen());
                              } else {
                                if (firebaseAuth.currentUser != null) {
                                  authController.clearShareData();
                                  cartControllers.clear();
                                  cartControllers.clearCartHistory();
                                  authController.logOut();
                                }
                              }
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  PopupMenuItem<MenuItems> buildItem(MenuItems item) =>
      PopupMenuItem<MenuItems>(
        value: item,
        child: Row(
          children: [
            Icon(
              item.icon,
              color: Colors.black,
              size: 20,
            ),
            SizedBox(
              width: 12,
            ),
            Text(item.text),
          ],
        ),
      );

  void onSelected(BuildContext context, MenuItems item) {
    switch (item) {
      case MenuItemsList.itemProfile:
        if (status == "Activated") {
          Get.toNamed(RouteHelper.getPharmacistProfileScreen());
        } else {
          if (firebaseAuth.currentUser != null) {
            authController.clearShareData();
            cartControllers.clear();
            cartControllers.clearCartHistory();
            authController.logOut();
          }
        }
        break;
      case MenuItemsList.itemSignOut:
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
                      if (firebaseAuth.currentUser != null) {
                        authController.clearShareData();
                        cartControllers.clear();
                        cartControllers.clearCartHistory();
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
        break;
    }
  }
}

class CategoryCard extends StatelessWidget {
  final String imgSrc;
  final String title;
  final VoidCallback press;
  const CategoryCard({
    Key? key,
    required this.imgSrc,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 17,
                spreadRadius: -23,
                color: Color(0XFFE6E6E6),
              )
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Spacer(),
                  Image.asset(imgSrc),
                  Spacer(),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
