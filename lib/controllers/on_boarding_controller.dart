// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import '../models/model_on_boarding.dart';
import '../utils/colors.dart';
import '../widgets/on_boarding_page_widget.dart';

class OnBoardingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
          image: "assets/image/medicine.png",
          title: "Get Started",
          subTitle:
              "Let's start your journey with our amazing pharmacy platform",
          counterText: "1/3",
          bgColor: AppColors.tOnBoardingPage1Color,
          onPressed: () {}),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
          image: "assets/image/shopping_app.png",
          title: "No limit orders",
          subTitle:
              "Be able to order any drug you are in need of and order it from any pharmacy you want",
          counterText: "2/3",
          bgColor: AppColors.tOnBoardingPage1Color,
          onPressed: () {}),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: "assets/image/onboard_3.png",
        title: "Delivery service",
        subTitle:
            "No need to travel, get the drug you need on your doorstep by only one click",
        counterText: "3/3",
        bgColor: AppColors.tOnBoardingPage1Color,
        onPressed: () => Get.offNamed(
          RouteHelper.getInitial(),
        ),
      ),
    )
  ];

  onPageChangedCallback(int activePageIndex) =>
      currentPage.value = activePageIndex;

  skip() => controller.jumpToPage(page: 2);

  animatedToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }
}
