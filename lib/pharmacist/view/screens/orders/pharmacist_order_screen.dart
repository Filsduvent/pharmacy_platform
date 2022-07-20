// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/orders/pharmacist_order_history.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/orders/pharmacy_shift_orders.dart';
import 'package:pharmacy_plateform/screens/orders/my_orders_history_screen.dart';
import 'package:pharmacy_plateform/screens/orders/my_orders_screen.dart';
import 'package:pharmacy_plateform/utils/colors.dart';

import '../../../../utils/app_constants.dart';
import '../../../../utils/dimensions.dart';

class PharmacistOrderScreen extends StatefulWidget {
  const PharmacistOrderScreen({Key? key}) : super(key: key);

  @override
  State<PharmacistOrderScreen> createState() => _PharmacistOrderScreenState();
}

class _PharmacistOrderScreenState extends State<PharmacistOrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;
  @override
  @override
  void initState() {
    super.initState();
    _isLoggedIn = firebaseAuth.currentUser != null;
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My orders'),
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
                tabs: const [
                  Tab(
                    text: "Current",
                  ),
                  Tab(
                    text: "History",
                  )
                ]),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              PharmacyShiftOrders(),
              PharmacistOrderHistory(),
            ]),
          )
        ],
      ),
    );
  }
}
