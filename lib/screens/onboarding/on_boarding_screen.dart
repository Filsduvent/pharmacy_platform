//ignore_for_file: avoid_unnecessary_containers, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pharmacy_plateform/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/on_boarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final obController = OnBoardingController();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
              pages: obController.pages,
              liquidController: obController.controller,
              onPageChangeCallback: obController.onPageChangedCallback,
              slideIconWidget: const Icon(Icons.arrow_back_ios),
              enableSideReveal: true),
          //  Positioned(
          //         bottom: 40,
          //         child: OutlinedButton(
          //             onPressed: () {
          //               obController.animatedToNextSlide();
          //             },
          //             style: ElevatedButton.styleFrom(
          //               side: const BorderSide(color: Colors.black26),
          //               shape: const CircleBorder(),
          //               padding: const EdgeInsets.all(20.0),
          //               onPrimary: Colors.white,
          //             ),
          //             child: Container(
          //               padding: const EdgeInsets.all(20.0),
          //               decoration: BoxDecoration(
          //                   color: AppColors.secondColor,
          //                   shape: BoxShape.circle),
          //               child: const Icon(Icons.arrow_forward_ios),
          //             ))),

          Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                  onPressed: () {
                    obController.skip();
                    // Get.offNamed(RouteHelper.getInitial());
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: AppColors.yellowColor),
                  ))),
          Obx(() {
            return Positioned(
                bottom: 20,
                child: AnimatedSmoothIndicator(
                  activeIndex: obController.currentPage.value,
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: AppColors.secondColor,
                    dotHeight: 20,
                  ),
                ));
          }),
        ],
      ),
    );
  }
}
