// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations
import 'package:pharmacy_plateform/pharmacist/view/screens/actions_on_drug/post_drug.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/home/main_pharmacy_screen.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/home/pharmacy_drug_details.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/home/pharmacy_medecines_screen.dart';
import 'package:pharmacy_plateform/screens/authentication/signin_screen.dart';
import 'package:pharmacy_plateform/screens/drug/popular_drug_detail.dart';
import 'package:pharmacy_plateform/screens/home/home_page.dart';
import 'package:get/get.dart';

import '../screens/cart/cart_page.dart';
import '../screens/drug/recent_drug_detail.dart';
import '../screens/splash/splash_screen.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = '/';
  static const String popularDrug = '/popular-drug';
  static const String recentDrug = '/recent-drug';
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
//Routers for pharmacist
  static const String mainPharmacyPage = "/main-pharmacy-page";
  static const String pharmacyMedecinePage = "/pharmacy-medecine-page";
  static const String pharmacyDetailsPage = '/pharmacy-details-page';
  static const String pharmacyPostDrug = '/pharmacy-post-drug';

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularDrug(int pageId, String page) =>
      '$popularDrug?pageId=$pageId&page=$page';
  static String getRecentDrug(int pageId, String page) =>
      '$recentDrug?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  //Routers for pharmacist
  static String getMainPharmacyPage() => '$mainPharmacyPage';
  static String getPharmacyMedecinePage() => '$pharmacyMedecinePage';
  static String getPharmacyDetailsPage(int pageId, String page) =>
      '$pharmacyDetailsPage?pageId=$pageId&page=$page';
  static String getPharmacyPostDrug() => '$pharmacyPostDrug';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: signIn,
        page: () {
          return SignInScreen();
        },
        transition: Transition.fade),
    GetPage(
        name: popularDrug,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return PopularDrugDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recentDrug,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return RecentDrugDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),

    //Routers for the pharmacist
    GetPage(
        name: mainPharmacyPage,
        page: () {
          return MainPharmacyScreen();
        },
        transition: Transition.fade),

    GetPage(
        name: pharmacyMedecinePage,
        page: () {
          return PharmacyMedicinesScreen();
        },
        transition: Transition.fade),

    GetPage(
        name: pharmacyDetailsPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return PharmacyDrugDetails(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),

    GetPage(
        name: pharmacyPostDrug,
        page: () {
          return PostDrugForm();
        },
        transition: Transition.zoom),
  ];
}
