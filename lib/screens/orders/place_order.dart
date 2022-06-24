// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';

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
          colors: [Colors.pink, Colors.lightGreenAccent],
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
                color: Colors.pinkAccent,
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

  addOrderDetails() {
    writeOrderDetailsForUser({
      AppConstants.addressId: widget.addressId,
      "orderBy":
          AppConstants.sharedPreferences!.getString(AppConstants.userUID),
      "productID": AppConstants.sharedPreferences!
          .getStringList(AppConstants.userCartList),
      "paymentDetails": "Cash on Delivery",
      "orderTime": DateTime.now().millisecondsSinceEpoch.toString(),
      "isSuccess": true,
    });

    writeOrderDetailsPharmacy({
      AppConstants.addressId: widget.addressId,
      "orderBy":
          AppConstants.sharedPreferences!.getString(AppConstants.userUID),
      "productID": AppConstants.sharedPreferences!
          .getStringList(AppConstants.userCartList),
      "paymentDetails": "Cash on Delivery",
      "orderTime": DateTime.now().millisecondsSinceEpoch.toString(),
      "isSuccess": true,
    }).whenComplete(() => {emptyCartNow()});
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
    Get.snackbar('Congratulations',
        'Congratulations, Your Order has been placed successfully!');

    Get.toNamed(RouteHelper.getInitial());
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    await firestore
        .collection('Users')
        .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID))
        .collection('Orders')
        .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID)! +
            data['orderTime'])
        .set(data);
  }

  Future writeOrderDetailsPharmacy(Map<String, dynamic> data) async {
    await firestore
        .collection('Orders')
        .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID)! +
            data['orderTime'])
        .set(data);
  }
}
