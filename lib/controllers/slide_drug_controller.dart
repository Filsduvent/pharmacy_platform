// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class SlideDrugController extends GetxController {
  static SlideDrugController instance = Get.find();
  final Rx<List<Drug>> _slideDrugList = Rx<List<Drug>>([]);

  List<Drug> get slideDrugList => _slideDrugList.value;
  CartController _cart = CartController(cartRepo: Get.find());
  // CartController? get cart => _cart;

  final Rx<bool> _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;

  final RxInt _quantity = 0.obs;
  int get quantity => _quantity.value;

  final RxInt _inCartItems = 0.obs;
  int get inCartItems => _inCartItems.value + _quantity.value;

  @override
  onInit() async {
    super.onInit();
    _slideDrugList.bindStream(FirebaseFirestore.instance
        .collection('drug')
        //.limit(5)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Drug> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Drug.fromSnap(element),
        );
        _isLoaded.value = true;
      }
      return retVal;
    }));
  }

  void setQuantity(isIncrement) {
    if (isIncrement.value) {
      _quantity.value = checkQuantity(_quantity.value + 1);
    } else {
      _quantity.value = checkQuantity(_quantity.value - 1);
    }
  }

  int checkQuantity(quantity) {
    if ((_inCartItems.value + quantity) < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        icon: const Icon(
          Icons.alarm,
          color: Colors.white,
        ),
        barBlur: 20,
        isDismissible: true,
        duration: const Duration(seconds: 5),
      );
      if (_inCartItems.value > 0) {
        _quantity.value = -_inCartItems.value;
        return _quantity.value;
      }
      return 0;
    } else if ((_inCartItems.value + quantity) > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        icon: const Icon(
          Icons.alarm,
          color: Colors.white,
        ),
        barBlur: 20,
        isDismissible: true,
        duration: const Duration(seconds: 5),
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initData(Drug drug, CartController cart) async {
    _quantity.value = 0;
    _inCartItems.value = 0;
    _cart = cart;
    bool exist = false;
    exist = _cart.existInCart(drug);
    //print("exist or not $exist");

    if (exist) {
      _inCartItems.value = _cart.getQuantity(drug);
    }
    // print("The quantity in the cart is ${_inCartItems.value}");
  }

  void addItem(Drug drug) {
    _cart.addItem(drug, _quantity.value);
    _quantity.value = 0;
    _inCartItems.value = _cart.getQuantity(drug);
    _cart.items.forEach((key, value) {
      print("The id is ${value.id} The quantity is ${value.quantity}");
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
