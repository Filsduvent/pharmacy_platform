// ignore_for_file: unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_plateform/models/address_model.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/screens/address/address_card.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import 'package:pharmacy_plateform/widgets/order_card.dart';

String getOrderId = "";

class OrderDetailsScreen extends StatelessWidget {
  final String orderID;
  const OrderDetailsScreen({Key? key, required this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getOrderId = orderID;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
            future: firestore
                .collection('Users')
                .doc(AppConstants.sharedPreferences!
                    .getString(AppConstants.userUID))
                .collection('Orders')
                .doc(orderID)
                .get(),
            builder: (c, snapshot) {
              Map dataMap = {};
              if (snapshot.hasData) {
                dataMap = snapshot.data?.data() as Map;
              }
              return snapshot.hasData
                  ? Container(
                      child: Column(
                        children: [
                          StatusBanner(
                            status: dataMap['isSuccess'],
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "BIF ${dataMap['totalAmount'].toString()}",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text("Order Id " + getOrderId),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "Ordered at: " +
                                  DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(dataMap['orderTime']))),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16.0),
                            ),
                          ),
                          Divider(
                            height: 2.0,
                          ),
                          FutureBuilder<QuerySnapshot>(
                              future: firestore
                                  .collection('Medicines')
                                  .where('title', whereIn: dataMap['productID'])
                                  .get(),
                              builder: (c, dataSnapshot) {
                                return dataSnapshot.hasData
                                    ? OrderCard(
                                        itemCount:
                                            dataSnapshot.data!.docs.length,
                                        data: dataSnapshot.data!.docs,
                                        orderID: orderID)
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      );
                              }),
                          Divider(
                            height: 2.0,
                          ),
                          FutureBuilder<DocumentSnapshot>(
                              future: firestore
                                  .collection('Users')
                                  .doc(AppConstants.sharedPreferences!
                                      .getString(AppConstants.userUID))
                                  .collection('Address')
                                  .doc(dataMap[AppConstants.addressId])
                                  .get(),
                              builder: (c, snap) {
                                return snap.hasData
                                    ? ShippingDetails(
                                        model: AddressModel.fromJson(snap.data!
                                            .data() as Map<String, dynamic>))
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      );
                              })
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }),
      ),
    ));
  }
}

class StatusBanner extends StatelessWidget {
  final bool status;
  const StatusBanner({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String msg;
    IconData iconData;

    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? msg = "Successful" : msg = "UnSuccessful";

    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Colors.white, Colors.lightGreenAccent],
          begin: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      height: Dimensions.height20 * 2,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
          onTap: () {
            SystemNavigator.pop();
          },
          child: Container(
            child: Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: Dimensions.width20,
        ),
        Text(
          "Order placed " + msg,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          width: Dimensions.width10 / 2,
        ),
        CircleAvatar(
          radius: 8.0,
          backgroundColor: Colors.grey,
          child: Center(
              child: Icon(
            iconData,
            color: Colors.white,
            size: 14.0,
          )),
        ),
      ]),
    );
  }
}

class ShippingDetails extends StatelessWidget {
  final AddressModel model;
  const ShippingDetails({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Dimensions.height20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Shipment Details :",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
          width: screenWidth,
          child: Table(children: [
            TableRow(children: [
              const KeyText(msg: "Name "),
              Text(model.name),
            ]),
            TableRow(children: [
              const KeyText(msg: "Phone Number "),
              Text(model.phoneNumber),
            ]),
            TableRow(children: [
              const KeyText(msg: "Province "),
              Text(model.province),
            ]),
            TableRow(children: [
              const KeyText(msg: "Commune "),
              Text(model.commune),
            ]),
            TableRow(children: [
              const KeyText(msg: "Zone "),
              Text(model.zone),
            ]),
            TableRow(children: [
              const KeyText(msg: "Quarter "),
              Text(model.quarter),
            ]),
            TableRow(children: [
              const KeyText(msg: "Avenue "),
              Text(model.avenue),
            ]),
            TableRow(children: [
              const KeyText(msg: "House Number "),
              Text(model.houseNumber)
            ]),
          ]),
        ),
        Padding(
          padding: EdgeInsets.all(Dimensions.width10),
          child: Center(
            child: InkWell(
              onTap: () {
                confirmedUserOrderReceived(context, getOrderId);
              },
              child: Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [Colors.white, Colors.lightGreenAccent],
                    begin: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
                width: MediaQuery.of(context).size.width - 40.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Confirmed || Items Received",
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimensions.font16),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void confirmedUserOrderReceived(BuildContext context, String mOrderId) {
    firestore
        .collection('Users')
        .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID))
        .collection('Orders')
        .doc(mOrderId)
        .delete();

    getOrderId = "";

    Get.toNamed(RouteHelper.initial);

    Get.snackbar('Comfirmation', 'Order has been Received');
  }
}
