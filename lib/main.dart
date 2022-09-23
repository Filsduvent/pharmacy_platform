import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/controllers/cart_controller.dart';
import 'package:pharmacy_plateform/controllers/slide_drug_controller.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/dependencies.dart' as dep;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppConstants.sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<SlideDrugController>(builder: (_) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        //home: SignInScreen(),
        initialRoute: RouteHelper.getSplashPage(),
        getPages: RouteHelper.routes,
      );
    });
  }
}
