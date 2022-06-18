// ignore_for_file: constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pharmacy_plateform/controllers/auth_controller.dart';
import 'package:pharmacy_plateform/controllers/cart_controller.dart';
import 'package:pharmacy_plateform/controllers/categories_controller.dart';
import 'package:pharmacy_plateform/controllers/profile_controller.dart';
import 'package:pharmacy_plateform/pharmacist/controllers/navigation_controller.dart';
import 'package:pharmacy_plateform/pharmacist/controllers/post_drug_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/slide_drug_controller.dart';

class AppConstants {
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
  static const String userCartList = "userCart";

  static SharedPreferences? sharedPreferences;

  static const String userName = "username";
  static const String userEmail = "email";
  static const String userPhone = "phone";
  static const String userAddress = "address";
  static const String userStatus = "status";
  static const String userPassword = "password";
  static const String userProfilePhoto = "profilePhoto";
  static const String userUID = "uid";
}

//FireBase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//Controller
var authController = AuthController.instance;
var profileController = ProfileController.instance;
var cartController = CartController.instance;
var navigationController = NavigationController.instance;
var slideDrugController = SlideDrugController.instance;
var postDrugController = PostDrugController.instance;
var categoriesController = CategoriesController.instance;
