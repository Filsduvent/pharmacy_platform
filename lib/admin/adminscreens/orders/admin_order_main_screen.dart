// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/admin/adminscreens/orders/admin_order_history_screen.dart';
import 'package:pharmacy_plateform/admin/adminscreens/orders/admin_running_order.screen.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_icon.dart';

class AdminOrderMainScreen extends StatefulWidget {
  const AdminOrderMainScreen({Key? key}) : super(key: key);

  @override
  State<AdminOrderMainScreen> createState() => _AdminOrderMainScreenState();
}

class _AdminOrderMainScreenState extends State<AdminOrderMainScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

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
        title: const Text(
          'Admin Orders Management',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getAdminHomeScreen());
          },
          child: Container(
            child: AppIcon(
              icon: Icons.arrow_back_ios,
              backgroundColor: Colors.white,
              iconColor: AppColors.mainColor,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: Dimensions.screenWidth,
            color: Colors.white,
            child: TabBar(
                indicatorColor: AppColors.secondColor,
                indicatorWeight: 3,
                labelColor: AppColors.mainColor,
                unselectedLabelColor: AppColors.secondColor,
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: "Running",
                  ),
                  Tab(
                    text: "History",
                  )
                ]),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              AdminRunningOrderScreen(),
              AdminOrderHistoryScreen(),
            ]),
          )
        ],
      ),
    );
  }
}
