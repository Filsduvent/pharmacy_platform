// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:pharmacy_plateform/admin/adminscreens/customers/pharmacist_screen.dart';
import 'package:pharmacy_plateform/admin/adminscreens/customers/simple_customer_screen.dart';
import 'package:pharmacy_plateform/admin/adminscreens/drug/admin_drug_main_screen.dart';
import 'package:pharmacy_plateform/admin/adminscreens/drug/admin_valid_details_screen.dart';
import 'package:pharmacy_plateform/admin/adminscreens/home/admin_home_screen.dart';
import 'package:pharmacy_plateform/admin/adminscreens/orders/admin_order_details_screen.dart';
import 'package:pharmacy_plateform/admin/adminscreens/orders/admin_order_main_screen.dart';
import 'package:pharmacy_plateform/admin/adminscreens/profile/profile_screen.dart';
import 'package:pharmacy_plateform/admin/category/post_category.dart';
import 'package:pharmacy_plateform/admin/category/update_category.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/actions_on_drug/add_new_drug.dart';
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
import '../admin/adminscreens/customers/inv_user_details_screen.dart';
import '../admin/adminscreens/customers/val_simple_user_details.dart';
import '../admin/adminscreens/units/admin_units_main_screen.dart';
import '../admin/category/categories_main_screen.dart';
import '../admin/category/category_details_screen.dart';
import '../pharmacist/view/profile/profile_screen.dart';
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
  static const String pharmacistProfileScreen = "/pharmacist-profile-screen";
  static const String pharmacyAddNewDrug = '/pharmacy-add-new-drug';

  //Routes for Admin
  static const String adminHomeScreen = "/admin-home-screen";
  static const String categoriesMainScreen = "/categories-main-screen";
  static const String postCategoryForm = "/post-category-form";
  static const String categoryDetailsScreen = "/category-details-screen";
  static const String updateCategoryScreen = "/update-category-screen";
  static const String adminDrugMainScreen = "/admin-drug-main-screen";
  static const String adminValidDetailsScreen = "/admin-valid-details-screen";
  static const String adminOrderMainScreen = "/admin-order-main-screen";
  static const String adminOrderDetailsScreen = "/admin-order-details-screen";
  static const String adminUnitsMainScreen = "/admin-units-main-screen";
  static const String adminProfileScreen = "/admin-profile-screen";
  static const String adminPharmacistScreen = "/admin-pharmacist-screen";
  static const String adminUserDetailsScreen = "/admin-user-details-screen";
  static const String adminInvalidUserDetailsScreen =
      "/admin-invalid-user-details-screen";
  static const String validSimpleUserDetailsScreen =
      "/valid-simple-user-details-screen";
  static const String invalidSimpleUserDetailsScreen =
      "/invalid-simple-user-details-screen";
  static const String simpleCustomerScreen = "/simple-customer-screen";

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
  static String getPharmacistProfileScreen() => '$pharmacistProfileScreen';
  static String getPharmacyAddNewDrug() => '$pharmacyAddNewDrug';

  //Routes for admin
  static String getAdminHomeScreen() => '$adminHomeScreen';
  static String getCategoriesMainScreen() => '$categoriesMainScreen';
  static String getPostCategoryForm() => '$postCategoryForm';
  static String getUpdateCategoryScreen(String catId, int pageId, String image,
          String name, String description) =>
      '$updateCategoryScreen?catId=$catId&pageId=$pageId&image=$image&name=$name&description=$description';
  static String getCategoryDetailsScreen(
          int pageId, String page, String catId) =>
      '$categoryDetailsScreen?pageId=$pageId&page=$page&catId=$catId';
  static String getAdminDrugMainScreen() => '$adminDrugMainScreen';
  static String getAdminValidDetailsScreen(
          int pageId, String page, String drugId) =>
      '$adminValidDetailsScreen?pageId=$pageId&page=$page&drugId=$drugId';
  static String getAdminOrderMainScreen() => '$adminOrderMainScreen';
  static String getAdminOrderDetailsScreen(
          String orderID, String orderBy, String addressId) =>
      '$adminOrderDetailsScreen?orderID=$orderID&orderBy=$orderBy&addressId=$addressId';
  static String getAdminUnitsMainScreen() => '$adminUnitsMainScreen';
  static String getAdminProfileScreen() => '$adminProfileScreen';
  static String getAdminPharmacistScreen() => '$adminPharmacistScreen';
  static String getAdminUserDetailsScreen(
          int pageId, String page, String userId) =>
      '$adminUserDetailsScreen?pageId=$pageId&page=$page&userId=$userId';
  static String getAdminInvalidUserDetailsScreen(
          int pageId, String page, String userId) =>
      '$adminInvalidUserDetailsScreen?pageId=$pageId&page=$page&userId=$userId';
  static String getValidSimpleUserDetailsScreen(
          int pageId, String page, String userId) =>
      '$validSimpleUserDetailsScreen?pageId=$pageId&page=$page&userId=$userId';
  static String getInvalidSimpleUserDetailsScreen(
          int pageId, String page, String userId) =>
      '$invalidSimpleUserDetailsScreen?pageId=$pageId&page=$page&userId=$userId';
  static String getSimpleCustomerScreen() => '$simpleCustomerScreen';

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

    // GetPage(
    //     name: pharmacyDetailsPage,
    //     page: () {
    //       var pageId = Get.parameters['pageId'];
    //       var page = Get.parameters["page"];
    //       var medId = Get.parameters["medId"];
    //       return PharmacyDrugDetails(
    //         pageId: int.parse(pageId!),
    //         page: page!,
    //         medId: medId!,
    //       );
    //     },
    //     transition: Transition.fadeIn),

    GetPage(
        name: pharmacyPostDrug,
        page: () {
          return PostDrugForm();
        },
        transition: Transition.zoom),

    // GetPage(
    //     name: pharmacyUpdateDrug,
    //     page: () {
    //       var medId = Get.parameters["medId"];
    //       var pageId = Get.parameters['pageId'];
    //       return UpdateDrugScreen(
    //         medId: medId!,
    //         pageId: int.parse(pageId!),
    //       );
    //     },
    //     transition: Transition.zoom),

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
    GetPage(
        name: pharmacistProfileScreen,
        page: () {
          return PharmacistProfileScreen();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: pharmacyAddNewDrug,
        page: () {
          return AddNewDrugScreen();
        },
        transition: Transition.zoom),

    //Routes for admin
    GetPage(
        name: adminHomeScreen,
        page: () {
          return AdminHomeScreen();
        },
        transition: Transition.zoom),
    GetPage(
        name: categoriesMainScreen,
        page: () {
          return CategoriesMainScreen();
        },
        transition: Transition.zoom),

    GetPage(
        name: postCategoryForm,
        page: () {
          return PostCategoryForm();
        },
        transition: Transition.zoom),

    /* GetPage(
        name: categoryDetailsScreen,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          var catId = Get.parameters["catId"];

          return CategoryDetailsScreen(
            pageId: int.parse(pageId!),
            page: page!,
            catId: catId!,
          );
        },
        transition: Transition.fadeIn),

    GetPage(
        name: updateCategoryScreen,
        page: () {
          var catId = Get.parameters["catId"];
          var pageId = Get.parameters['pageId'];
          var image = Get.parameters['image'];
          var name = Get.parameters['name'];
          var description = Get.parameters['description'];

          return UpdateCategoryScreen(
            catId: catId!,
            pageId: int.parse(pageId!),
            image: image!,
            name: name!,
            description: description!,
          );
        },
        transition: Transition.zoom),*/
    GetPage(
        name: adminDrugMainScreen,
        page: () {
          return AdminDrugMainScreen();
        },
        transition: Transition.zoom),

    // GetPage(
    //     name: adminValidDetailsScreen,
    //     page: () {
    //       var pageId = Get.parameters['pageId'];
    //       var page = Get.parameters["page"];
    //       var drugId = Get.parameters["drugId"];

    //       return AdminValidDetailsScreen(
    //         pageId: int.parse(pageId!),
    //         page: page!,
    //         drugId: drugId!,

    //       );
    //     },
    //     transition: Transition.fadeIn),

    GetPage(
        name: adminOrderMainScreen,
        page: () {
          return AdminOrderMainScreen();
        },
        transition: Transition.zoom),

    GetPage(
        name: adminOrderDetailsScreen,
        page: () {
          var orderID = Get.parameters['orderID'];
          var orderBy = Get.parameters['orderBy'];
          var addressId = Get.parameters['addressId'];
          return AdminOrderDetailsScreen(
              orderID: orderID!, orderBy: orderBy!, addressId: addressId!);
        },
        transition: Transition.fade),

    GetPage(
        name: adminUnitsMainScreen,
        page: () {
          return AdminUnitsMainScreen();
        },
        transition: Transition.zoom),

    GetPage(
        name: adminProfileScreen,
        page: () {
          return ProfileScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: adminPharmacistScreen,
        page: () {
          return PharmacistScreen();
        },
        transition: Transition.zoom),
/*
    GetPage(
        name: adminUserDetailsScreen,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          var userId = Get.parameters["userId"];
          return UserDetailsScreen(
            pageId: int.parse(pageId!),
            page: page!,
            userId: userId!,
          );
        },
        transition: Transition.fadeIn),*/

    /* GetPage(
        name: adminInvalidUserDetailsScreen,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          var userId = Get.parameters["userId"];
          return InvalidUserDetailsScreen(
            pageId: int.parse(pageId!),
            page: page!,
            userId: userId!,
          );
        },
        transition: Transition.fadeIn),

    GetPage(
        name: validSimpleUserDetailsScreen,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          var userId = Get.parameters["userId"];
          return ValidSimpleUserDetails(
            pageId: int.parse(pageId!),
            page: page!,
            userId: userId!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: invalidSimpleUserDetailsScreen,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          var userId = Get.parameters["userId"];
          return InvalidSimpleUserDetails(
            pageId: int.parse(pageId!),
            page: page!,
            userId: userId!,
          );
        },
        transition: Transition.fadeIn),*/
    GetPage(
        name: simpleCustomerScreen,
        page: () {
          return SimpleCustomerScreen();
        },
        transition: Transition.zoom),
  ];
}
