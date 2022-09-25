// ignore_for_file: unnecessary_new, prefer_const_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
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

  @override
  void initState() {
    super.initState();
    //_loadResource();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
        const Duration(seconds: 3),
        () => /* Get.offNamed(RouteHelper.getInitial())*/ Get
            .offNamed(RouteHelper.getOnBoardingScreen()));
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
              "assets/image/pillslogo.png",
              width: Dimensions.splashImg,
            )),
          ),
          Center(
              child: Text(
            "Order your Medicines",
            style: TextStyle(fontSize: Dimensions.font16),
          )),
        ],
      ),
    );
  }
}
