// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});
/*
  List<String> cart = [];

  Future<void> addToCartList(List<CartModel> cartList, Drug drug,
      CartModel cartModel, int quantity) async {
    cart = [];

    cartList.forEach((element) {
      cartModel = CartModel(
          id: drug.id,
          title: drug.title,
          price: drug.price,
          photoUrl: drug.photoUrl,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          drug: drug);
      cart.add(jsonEncode(cartModel));
      sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
      //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
      getCartList(drug, cartModel, quantity);
    });
  }

  Future<List<CartModel>> getCartList(
      Drug drug, CartModel cartModel, int quantity) async {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartList $carts");
    }
    List<CartModel> cartList = [];
    carts.forEach((element) {
      cartModel = CartModel(
          id: drug.id.toString(),
          title: drug.title.toString(),
          price: drug.price.toInt(),
          photoUrl: drug.photoUrl.toString(),
          quantity: quantity.toInt(),
          isExist: true,
          time: DateTime.now().toString(),
          drug: drug);
      try {
        cartList.add(CartModel.fromMap(jsonDecode(element)));
      } on SocketException {
        print('check internet');
        rethrow;
      } on FormatException {
        print('problem while retriving data');
        rethrow;
      } catch (ex) {
        print('error happened');
        rethrow;
      }
    });
    return cartList;
  }*/

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    //sharedPreferences.remove(AppConstants.CART_LIST);
    //sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    //return;
    var time = DateTime.now().toString();
    cart = [];
    // convert objects to string bcs sharedpreference only accepts string

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    firestore
        .collection('Users')
        .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID))
        .update({AppConstants.userCartList: cart});

    sharedPreferences.setStringList(AppConstants.userCartList, cart);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    //getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstants.userCartList)) {
      carts = sharedPreferences.getStringList(AppConstants.userCartList)!;
      print("inside getCartList $carts");
    }
    List<CartModel> cartList = [];
    carts.forEach(
        (element) => cartList.add(CartModel.fromMap(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      //cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromMap(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("history list ${cart[i]}");
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    print("The length of history list is ${getCartHistoryList().length}");

    for (int j = 0; j < getCartHistoryList().length; j++) {
      print("The time for the order is ${getCartHistoryList()[j].time}");
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.userCartList);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
