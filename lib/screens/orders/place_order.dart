// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/cart_model.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colors.dart';

class PlaceOrder extends StatefulWidget {
  final String addressId;
  const PlaceOrder({Key? key, required this.addressId}) : super(key: key);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset('assets/image/truck.png'),
            ),
            SizedBox(height: 10.0),
            FlatButton(
                color: AppColors.mainColor,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.deepOrange,
                onPressed: () => addOrderDetails(),
                child: BigText(text: "Place order", color: Colors.white))
          ],
        ),
      ),
    ));
  }

  addOrderDetails() async {
    var _cartList = cartControllers.getItems;
    var _tmp = [];

    for (var product in _cartList) {
      _tmp.add({"id": product.id, "quantity": product.quantity});

      final response =
          await firestore.collection('Medicines').doc(product.id).get();
      var quantity = response.data() as Map;

      if (quantity['quantity'] < product.quantity) {
        Get.snackbar(
          "Quantity control",
          "Sorry the quantity you want is more than the quantity in stock",
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
      } else {
        writeOrderDetailsForUser({
          AppConstants.addressId: widget.addressId,
          "orderBy":
              AppConstants.sharedPreferences!.getString(AppConstants.userUID),
          "productID": AppConstants.sharedPreferences!
              .getStringList(AppConstants.userCartList),
          "orderedProduct": _tmp,
          "paymentDetails": "Cash on Delivery",
          "orderTime": DateTime.now().millisecondsSinceEpoch.toString(),
          "isSuccess": true,
          "totalAmount": cartControllers.totalAmount,
          "orderStatus": "Pending"
        });
        writeOrderDetailsPharmacy({
          AppConstants.addressId: widget.addressId,
          "orderBy":
              AppConstants.sharedPreferences!.getString(AppConstants.userUID),
          "productID": AppConstants.sharedPreferences!
              .getStringList(AppConstants.userCartList),
          "orderedProduct": _tmp,
          "paymentDetails": "Cash on Delivery",
          "orderTime": DateTime.now().millisecondsSinceEpoch.toString(),
          "isSuccess": true,
          "totalAmount": cartControllers.totalAmount,
          "orderStatus": "Pending",
        }).whenComplete(() => {emptyCartNow(), cartControllers.addToHistory()});
      }
    }
  }

  emptyCartNow() {
    AppConstants.sharedPreferences!
        .setStringList(AppConstants.userCartList, ["garbageValue"]);
    List<String> tempList = AppConstants.sharedPreferences!
        .getStringList(AppConstants.userCartList) as List<String>;

    firestore
        .collection('Users')
        .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID))
        .update({
      AppConstants.userCartList: tempList,
    }).then((value) {
      AppConstants.sharedPreferences!
          .setStringList(AppConstants.userCartList, tempList);
    });
    Get.snackbar(
      'Congratulations',
      'Congratulations, Your Order has been placed successfully!',
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

    Get.toNamed(RouteHelper.getInitial());
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    var _cartList = cartControllers.getItems;
    var _tmp = [];

    for (var product in _cartList) {
      _tmp.add({"id": product.id, "quantity": product.quantity});

      final response =
          await firestore.collection('Medicines').doc(product.id).get();
      var quantity = response.data() as Map;

      await firestore
          .collection('Users')
          .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID))
          .collection('Orders')
          .doc(
              AppConstants.sharedPreferences!.getString(AppConstants.userUID)! +
                  data['orderTime'])
          .set(data);

      if (quantity['quantity'] < product.quantity) {
      } else {
        await firestore
            .collection('Medicines')
            .doc(product.id)
            .update({"quantity": quantity['quantity'] - product.quantity});
      }
    }
  }

  Future writeOrderDetailsPharmacy(Map<String, dynamic> data) async {
    var _cartList = cartControllers.getItems;
    var _tmp = [];

    for (var product in _cartList) {
      _tmp.add({"id": product.id, "quantity": product.quantity});

      final response =
          await firestore.collection('Medicines').doc(product.id).get();
      var quantity = response.data() as Map;

      await firestore
          .collection('Orders')
          .doc(
              AppConstants.sharedPreferences!.getString(AppConstants.userUID)! +
                  data['orderTime'])
          .set(data);

      if (quantity['quantity'] < product.quantity) {
      } else {
        await firestore
            .collection('Medicines')
            .doc(product.id)
            .update({"quantity": quantity['quantity'] - product.quantity});
      }
    }
  }
}
