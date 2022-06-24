// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_plateform/models/cart_model.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/user_model.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';

import '../repository/cart_repo.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  static CartController instance = Get.find();
  Map<String, CartModel> _items = {};

  Map<String, CartModel> get items => _items;

  Map _data = {};

  Map get data => _data;

  //Only for storage and sharedpreferences
  List<CartModel> storageItems = [];

  final Rx<List<User>> _cartDrugList = Rx<List<User>>([]);

  List<User> get cartDrugList => _cartDrugList.value;

  @override
  onInit() async {
    super.onInit();
    _cartDrugList.bindStream(FirebaseFirestore.instance
        .collection('Users')
        //.limit(5)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          User.fromSnap(element),
        );
      }
      return retVal;
    }));
  }

  void onReady() {
    super.onReady();
    getCartContentData();
  }

  Future<void> getCartContentData() async {
    try {
      final response = await firestore
          .collection('Users')
          .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID))
          .get();

      if (response.exists) {
        _data = response.data() as Map;
      }
      // print("************************* ${data}");
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  void addItem(Drug drug, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(drug.id)) {
      _items.update(drug.id, (value) {
        totalQuantity = value.quantity! + quantity;
        update();
        return CartModel(
            id: value.id,
            title: value.title?.toString(),
            price: value.price,
            photoUrl: value.photoUrl?.toString(),
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            drug: drug);
      });

      if (totalQuantity <= 0) {
        _items.remove(drug.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(drug.id, () {
          return CartModel(
              id: drug.id,
              title: drug.title,
              price: drug.price,
              photoUrl: drug.photoUrl,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              drug: drug);
        });
      } else {
        Get.snackbar(
          "Item count",
          "You should at least add an item in the cart",
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
      }
    }

    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(Drug drug) {
    if (_items.containsKey(drug.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(Drug drug) {
    var quantity = 0;
    if (_items.containsKey(drug.id)) {
      _items.forEach((key, value) {
        if (key == drug.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity = totalQuantity + value.quantity!;
    });

    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print("Length of cart items ${storageItems.length}");

    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].drug!.id, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<String, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }
}
