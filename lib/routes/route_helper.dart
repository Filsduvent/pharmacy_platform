// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations
import 'package:pharmacy_plateform/admin/adminscreens/home/admin_home_screen.dart';
import 'package:pharmacy_plateform/admin/category/post_category.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/actions_on_drug/post_drug.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/actions_on_drug/update_drug.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/home/main_pharmacy_screen.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/home/pharmacy_drug_details.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/home/pharmacy_medecines_screen.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/orders/pharmacist_order_details.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/orders/pharmacist_order_screen.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/orders/pharmacy_shift_orders.dart';
import 'package:pharmacy_plateform/screens/address/add_address_screen.dart';
import 'package:pharmacy_plateform/screens/address/address_screen.dart';
import 'package:pharmacy_plateform/screens/authentication/signin_screen.dart';
import 'package:pharmacy_plateform/screens/drug/popular_drug_detail.dart';
import 'package:pharmacy_plateform/screens/home/home_page.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/screens/orders/order_details_screen.dart';
import 'package:pharmacy_plateform/screens/orders/place_order.dart';
import '../admin/category/categories_main_screen.dart';
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
  static const String addressScreen = "/address-screen";
  static const String addAddressScreen = "/add-address";
  static const String placeOrder = "/place-order";
  static const String orderDetailsScreen = "/order-details-screen";

//Routers for pharmacist
  static const String mainPharmacyPage = "/main-pharmacy-page";
  static const String pharmacyMedecinePage = "/pharmacy-medecine-page";
  static const String pharmacyDetailsPage = '/pharmacy-details-page';
  static const String pharmacyPostDrug = '/pharmacy-post-drug';
  static const String pharmacyUpdateDrug = '/pharmacy-update-drug';
  static const String pharmacistOrderDetails = '/pharmacist-order-details';
  static const String pharmacyShiftOrders = "/pharmacy-shift-orders";
  static const String pharmacyOrderScreen = "/pharmacy-order-screen";

  //Routes for Admin
  static const String adminHomeScreen = "/admin-home-screen";
  static const String categoriesMainScreen = "/categories-main-screen";
  static const String postCategoryForm = "/post-category-form";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularDrug(int pageId, String page) =>
      '$popularDrug?pageId=$pageId&page=$page';
  static String getRecentDrug(int pageId, String page) =>
      '$recentDrug?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getAddressScreen() => '$addressScreen';
  static String getAddAddressScreen() => '$addAddressScreen';
  static String getPlaceOrder({required String addressId}) =>
      '$placeOrder?addressId=$addressId';
  static String getOrderDetailsScreen(String orderID) =>
      '$orderDetailsScreen?orderID=$orderID';
  //Routers for pharmacist
  static String getMainPharmacyPage() => '$mainPharmacyPage';
  static String getPharmacyMedecinePage() => '$pharmacyMedecinePage';
  static String getPharmacyDetailsPage(int pageId, String page, String medId) =>
      '$pharmacyDetailsPage?pageId=$pageId&page=$page&medId=$medId';
  static String getPharmacyPostDrug() => '$pharmacyPostDrug';
  static String getPharmacyUpdateDrugPage(String medId, int pageId) =>
      '$pharmacyUpdateDrug?medId=$medId&pageId=$pageId';
  static String getPharmacistOrderDetailsScreen(
          String orderID, String orderBy, String addressId) =>
      '$pharmacistOrderDetails?orderID=$orderID&orderBy=$orderBy&addressId=$addressId';
  static String getPharmacyShiftOrders() => '$pharmacyShiftOrders';
  static String getPharmacistOrderScreen() => '$pharmacyOrderScreen';

  //Routes for admin
  static String getAdminHomeScreen() => '$adminHomeScreen';
  static String getCategoriesMainScreen() => '$categoriesMainScreen';
  static String getPostCategoryForm() => '$postCategoryForm';

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

    GetPage(
        name: addressScreen,
        page: () {
          return AddressScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: addAddressScreen,
        page: () {
          return AddAddressScreen();
        },
        transition: Transition.zoom),

    GetPage(
        name: placeOrder,
        page: () {
          var addressId = Get.parameters['addressId'];

          return PlaceOrder(addressId: addressId!);
        },
        transition: Transition.fadeIn),

    GetPage(
        name: orderDetailsScreen,
        page: () {
          var orderID = Get.parameters['orderID'];

          return OrderDetailsScreen(orderID: orderID!);
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
          var medId = Get.parameters["medId"];
          return PharmacyDrugDetails(
            pageId: int.parse(pageId!),
            page: page!,
            medId: medId!,
          );
        },
        transition: Transition.fadeIn),

    GetPage(
        name: pharmacyPostDrug,
        page: () {
          return PostDrugForm();
        },
        transition: Transition.zoom),

    GetPage(
        name: pharmacyUpdateDrug,
        page: () {
          var medId = Get.parameters["medId"];
          var pageId = Get.parameters['pageId'];
          return UpdateDrugScreen(
            medId: medId!,
            pageId: int.parse(pageId!),
          );
        },
        transition: Transition.zoom),

    GetPage(
        name: pharmacistOrderDetails,
        page: () {
          var orderID = Get.parameters['orderID'];
          var orderBy = Get.parameters['orderBy'];
          var addressId = Get.parameters['addressId'];
          return PharmacistOrderDetails(
              orderID: orderID!, orderBy: orderBy!, addressId: addressId!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: pharmacyShiftOrders,
        page: () {
          return PharmacyShiftOrders();
        },
        transition: Transition.fade),
    GetPage(
        name: pharmacyOrderScreen,
        page: () {
          return PharmacistOrderScreen();
        },
        transition: Transition.fade),

    //Routes for admin
    GetPage(
        name: adminHomeScreen,
        page: () {
          return AdminHomeScreen();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: categoriesMainScreen,
        page: () {
          return CategoriesMainScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: postCategoryForm,
        page: () {
          return PostCategoryForm();
        },
        transition: Transition.zoom),
  ];
}
