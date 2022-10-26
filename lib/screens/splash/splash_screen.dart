// ignore_for_file: unnecessary_new, prefer_const_constructors
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  /*Future<void> _loadResource() async {
    await Get.find<SlideDrugController>();
    await Get.find<RecentDrugController>();
  }*/
  String? role = "";

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          role = snapshot.data()!["role"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
    //_loadResource();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(const Duration(seconds: 3), () {
      if (firebaseAuth.currentUser != null && role == "Admin") {
        Get.offNamed(RouteHelper.getAdminHomeScreen());
      } else if (firebaseAuth.currentUser != null && role == "Pharmacy owner") {
        Get.offNamed(RouteHelper.getMainPharmacyPage());
      } else if (firebaseAuth.currentUser != null && role == "Customer") {
        Get.offNamed(RouteHelper.getInitial());
      } else {
        Get.offNamed(RouteHelper.getOnBoardingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset(
              "assets/image/pharmacy_platform_logo.jpg",
              width: Dimensions.splashImg * 3,
            )),
          ),
          // SizedBox(
          //   height: Dimensions.height45 * 8,
          // ),
          // SmallText(
          //   text: "Powered by Son Of Wind",
          //   size: Dimensions.font20,
          // ),
        ],
      ),
    );
  }
}
