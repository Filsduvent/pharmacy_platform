import 'package:pharmacy_plateform/controllers/address_changer_controller.dart';
import 'package:pharmacy_plateform/controllers/address_controller.dart';
import 'package:pharmacy_plateform/controllers/auth_controller.dart';
import 'package:pharmacy_plateform/controllers/categories_controller.dart';
import 'package:pharmacy_plateform/controllers/profile_controller.dart';
import 'package:pharmacy_plateform/controllers/recent_drug_controller.dart';
import 'package:pharmacy_plateform/controllers/slide_drug_controller.dart';
import 'package:pharmacy_plateform/pharmacist/controllers/navigation_controller.dart';
import 'package:pharmacy_plateform/pharmacist/controllers/post_drug_controller.dart';
import 'package:pharmacy_plateform/repository/cart_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //repos
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => SlideDrugController());
  Get.lazyPut(() => RecentDrugController());
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => CategoriesController());
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => ProfileController());
  Get.lazyPut(() => NavigationController());
  Get.lazyPut(() => PostDrugController());
  Get.lazyPut(() => AddressController());
  Get.lazyPut(() => AddressChangerController());
}
