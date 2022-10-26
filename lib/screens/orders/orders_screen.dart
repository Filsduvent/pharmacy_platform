// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/screens/orders/my_orders_history_screen.dart';
import 'package:pharmacy_plateform/screens/orders/my_orders_screen.dart';
import 'package:pharmacy_plateform/utils/colors.dart';

import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);
  late bool _isLoggedIn;

  String? status = "";

  Future _getDataFromDatabase() async {
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
    super.initState();
    _isLoggedIn = firebaseAuth.currentUser != null;
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      // Get.find<SlideDrugController>()
      //     .slideDrugList; //function to display all the orders from firebase;
    }
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My orders'),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
      ),
      body: firebaseAuth.currentUser != null && status == "Activated"
          ? Column(
              children: [
                Container(
                  width: Dimensions.screenWidth,
                  child: TabBar(
                      indicatorColor: AppColors.mainColor,
                      indicatorWeight: 3,
                      labelColor: AppColors.mainColor,
                      unselectedLabelColor: AppColors.yellowColor,
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: "Current",
                        ),
                        Tab(
                          text: "History",
                        )
                      ]),
                ),
                Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    MyOrdersScreen(),
                    MyOrdersHistoryScreen(),
                  ]),
                )
              ],
            )
          : Container(
              color: Colors.white,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height30 * 10,
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/image/account.png"))),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 5,
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
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
  }
}
