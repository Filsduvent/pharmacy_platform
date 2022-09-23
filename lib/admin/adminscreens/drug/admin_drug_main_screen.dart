// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/admin/adminscreens/drug/invalidate_drug_screen.dart';
import 'package:pharmacy_plateform/admin/adminscreens/drug/validate_drug_screen.dart';
import 'package:pharmacy_plateform/widgets/app_icon.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class AdminDrugMainScreen extends StatefulWidget {
  const AdminDrugMainScreen({Key? key}) : super(key: key);

  @override
  State<AdminDrugMainScreen> createState() => _AdminDrugMainScreenState();
}

class _AdminDrugMainScreenState extends State<AdminDrugMainScreen>
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
          'Admin Medicine Controller',
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
                    text: "Invalid drug",
                  ),
                  Tab(
                    text: "Valid drugs",
                  )
                ]),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              InvalidateDrugScreen(),
              ValidateDrugScreen(),
            ]),
          )
        ],
      ),
    );
  }
}
