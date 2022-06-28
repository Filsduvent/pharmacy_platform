// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/screens/orders/view_orders.dart';
import 'package:pharmacy_plateform/utils/colors.dart';

import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = firebaseAuth.currentUser != null;
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      //Get.find<OrderController>().getOrderList(); function to display all the orders from firebase;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My orders'),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
      ),
      body: Column(
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
              ViewOrders(isCurrent: true),
              ViewOrders(isCurrent: false),
            ]),
          )
        ],
      ),
    );
  }
}
