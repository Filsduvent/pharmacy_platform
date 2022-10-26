// ignore_for_file: unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_plateform/models/address_model.dart';
import 'package:pharmacy_plateform/screens/address/address_card.dart';
import 'package:pharmacy_plateform/screens/orders/my_orders_screen.dart';
import 'package:pharmacy_plateform/screens/orders/orders_screen.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';
import 'package:pharmacy_plateform/widgets/order_card.dart';
import '../../utils/colors.dart';

String getOrderId = "";

class OrderDetailsScreen extends StatelessWidget {
  final String orderID;
  const OrderDetailsScreen({Key? key, required this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getOrderId = orderID;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('order Details'),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
            future: /*firestore
                .collection('Users')
                .doc(AppConstants.sharedPreferences!
                    .getString(AppConstants.userUID))
                .collection('Orders')
                .doc(orderID)
                .get(),*/
                firestore.collection('Orders').doc(getOrderId).get(),
            builder: (c, snapshot) {
              Map dataMap = {};
              if (snapshot.hasData) {
                dataMap = snapshot.data?.data() as Map;
              }
              return snapshot.hasData
                  ? Container(
                      child: Column(
                        children: [
                          // StatusBanner(
                          //   status: dataMap['isSuccess'],
                          // ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          Container(
                            margin: EdgeInsets.all(Dimensions.width10),
                            height: Dimensions.height45 * 3.7,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    offset: Offset(0, 2),
                                    color: Colors.grey.withOpacity(0.3),
                                  )
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(
                                Dimensions.width10,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text: "Total Amount : ",
                                        color: Colors.grey,
                                      ),
                                      BigText(
                                        text:
                                            "BIF ${dataMap['totalAmount'].toString()}",
                                        color: AppColors.mainColor,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text: " At : ",
                                        color: Colors.grey,
                                      ),
                                      BigText(
                                        text: DateFormat(
                                                "dd MMMM, yyyy - hh:mm aa")
                                            .format(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    int.parse(
                                                        dataMap['orderTime']))),
                                        color: AppColors.mainBlackColor,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text: "Order status : ",
                                        color: Colors.grey,
                                      ),
                                      BigText(
                                        text: dataMap['orderStatus'],
                                        color: AppColors.mainColor,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text: "Payment : ",
                                        color: Colors.grey,
                                      ),
                                      BigText(
                                        text: dataMap['paymentDetails'],
                                        color: AppColors.mainColor,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          FutureBuilder<QuerySnapshot>(
                              future: firestore
                                  .collection('Medicines')
                                  .where('id', whereIn: dataMap['productID'])
                                  .get(),
                              builder: (c, dataSnapshot) {
                                return dataSnapshot.hasData
                                    ? OrderCard(
                                        itemCount:
                                            dataSnapshot.data!.docs.length,
                                        data: dataSnapshot.data!.docs,
                                        orderID: orderID,
                                        quantity: dataMap['orderedProduct'][0]
                                            ['quantity'],
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.mainColor,
                                        ),
                                      );
                              }),

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
                                        child: CircularProgressIndicator(
                                          color: AppColors.mainColor,
                                        ),
                                      );
                              }),

                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //sign up button

                          !(dataMap['orderStatus'] == "Running")
                              ? Container()
                              : GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Are you sure?'),
                                          content: BigText(
                                            text: "This action is irreversible",
                                            color: AppColors.mainBlackColor,
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  confirmedUserOrderReceived(
                                                      context, getOrderId);
                                                  Get.offAll(OrderScreen());
                                                },
                                                child: BigText(
                                                  text: "Yes",
                                                  color: Colors.redAccent,
                                                )),
                                            TextButton(
                                                onPressed: () => Get.back(),
                                                child: BigText(
                                                  text: "No",
                                                  color: AppColors.mainColor,
                                                ))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: Dimensions.screenWidth - 20,
                                    height: Dimensions.screenHeight / 13,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius30),
                                        color: AppColors.secondColor),
                                    child: Center(
                                      child: BigText(
                                        text: "Confirm reception",
                                        size: Dimensions.font20 +
                                            Dimensions.font20 / 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    );
            }),
      ),
    ));
  }

  void confirmedUserOrderReceived(BuildContext context, String mOrderId) async {
    await firestore
        .collection('Orders')
        .doc(mOrderId)
        .update({'orderStatus': "Received"});

    getOrderId = "";

    //Get.toNamed(RouteHelper.getOrderDetailsScreen(orderID));

    Get.snackbar('Confirmation', 'Order has been Received');
    // final response = await firestore
    //     .collection('Users')
    //     .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID))
    //     .collection('Orders')
    //     .doc(mOrderId)
    //     .get();
    // var orderStatus = response.data() as Map;
    // if (orderStatus['orderStatus'] == "Pending") {
    //   Get.snackbar(
    //     'Waiting',
    //     'Please wait your order is in progress',
    //     backgroundColor: AppColors.mainColor,
    //     colorText: Colors.white,
    //     icon: const Icon(
    //       Icons.alarm,
    //       color: Colors.white,
    //     ),
    //     barBlur: 20,
    //     isDismissible: true,
    //     duration: const Duration(seconds: 5),
    //   );
    // } else if (orderStatus['orderStatus'] == "Received") {
    //   Get.snackbar(
    //     'Reminder',
    //     'This order have been already received',
    //     backgroundColor: AppColors.mainColor,
    //     colorText: Colors.white,
    //     icon: const Icon(
    //       Icons.alarm,
    //       color: Colors.white,
    //     ),
    //     barBlur: 20,
    //     isDismissible: true,
    //     duration: const Duration(seconds: 5),
    //   );
    // } else if (orderStatus['orderStatus'] == "Running") {
    //   // firestore
    //   //     .collection('Users')
    //   //     .doc(AppConstants.sharedPreferences!.getString(AppConstants.userUID))
    //   //     .collection('Orders')
    //   //     .doc(mOrderId)
    //   //     .update({'orderStatus': "Received"});

    //   await firestore
    //       .collection('Orders')
    //       .doc(mOrderId)
    //       .update({'orderStatus': "Received"});

    //   getOrderId = "";

    //   Get.toNamed(RouteHelper.getOrderDetailsScreen(orderID));

    //   Get.snackbar('Confirmation', 'Order has been Received');
    // }
  }
}

/*class StatusBanner extends StatelessWidget {
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
*/
class ShippingDetails extends StatelessWidget {
  final AddressModel model;
  const ShippingDetails({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(Dimensions.width10),
      // height: Dimensions.height45 * 4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              offset: Offset(0, 2),
              color: Colors.grey.withOpacity(0.3),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Dimensions.height20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: BigText(
              text: "Shipment details ",
              color: AppColors.mainBlackColor,
              size: Dimensions.font20,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            width: screenWidth,
            child: Table(children: [
              TableRow(children: [
                KeyText(
                  msg: "Name : ",
                  color: Colors.grey,
                ),
                BigText(
                  text: model.name,
                  color: Colors.grey,
                  size: Dimensions.font20,
                ),
              ]),
              TableRow(children: [
                KeyText(msg: "Phone Number : ", color: Colors.grey),
                BigText(
                  text: model.phoneNumber,
                  color: Colors.grey,
                  size: Dimensions.font20,
                ),
              ]),
              TableRow(children: [
                KeyText(msg: "Province : ", color: Colors.grey),
                BigText(
                  text: model.province,
                  color: Colors.grey,
                  size: Dimensions.font20,
                ),
              ]),
              TableRow(children: [
                KeyText(
                  msg: "Commune : ",
                  color: Colors.grey,
                ),
                BigText(
                  text: model.commune,
                  color: Colors.grey,
                  size: Dimensions.font20,
                ),
              ]),
              TableRow(children: [
                KeyText(msg: "Zone : ", color: Colors.grey),
                BigText(
                  text: model.zone,
                  color: Colors.grey,
                  size: Dimensions.font20,
                ),
              ]),
              TableRow(children: [
                KeyText(msg: "Quarter : ", color: Colors.grey),
                BigText(
                  text: model.quarter,
                  color: Colors.grey,
                  size: Dimensions.font20,
                ),
              ]),
              TableRow(children: [
                KeyText(msg: "Avenue : ", color: Colors.grey),
                BigText(
                  text: model.avenue,
                  color: Colors.grey,
                  size: Dimensions.font20,
                ),
              ]),
              TableRow(children: [
                KeyText(msg: "House Number : ", color: Colors.grey),
                BigText(
                  text: model.houseNumber,
                  color: Colors.grey,
                  size: Dimensions.font20,
                )
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}
