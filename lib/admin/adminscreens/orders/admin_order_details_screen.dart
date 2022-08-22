// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_plateform/admin/adminscreens/orders/admin_order_card.dart';

import '../../../base/show_custom_snackbar.dart';
import '../../../models/address_model.dart';
import '../../../routes/route_helper.dart';
import '../../../screens/address/address_card.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';

String getOrderId = " ";

class AdminOrderDetailsScreen extends StatelessWidget {
  final String orderID;
  final String orderBy;
  final String addressId;
  const AdminOrderDetailsScreen(
      {Key? key,
      required this.orderID,
      required this.orderBy,
      required this.addressId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getOrderId = orderID;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('order Details'),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
            future: firestore.collection('Orders').doc(getOrderId).get(),
            builder: (c, snapshot) {
              Map dataMap = {};
              if (snapshot.hasData) {
                dataMap = snapshot.data?.data() as Map;
              }
              return snapshot.hasData
                  ? Container(
                      child: Column(
                        children: [
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
                                        color: Colors.redAccent,
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
                                        text: "Ordered at : ",
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
                                  FutureBuilder<DocumentSnapshot>(
                                      future: firestore
                                          .collection('Users')
                                          .doc(dataMap['orderBy'])
                                          .get(),
                                      builder: (context, snaps) {
                                        Map byMap = {};
                                        if (snaps.hasData) {
                                          byMap = snaps.data!.data() as Map;
                                        }
                                        return snaps.hasData
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: "Ordered by : ",
                                                    color: Colors.grey,
                                                  ),
                                                  BigText(
                                                    text: byMap['username'],
                                                    color:
                                                        AppColors.yellowColor,
                                                  )
                                                ],
                                              )
                                            : Container();
                                      }),
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
                                  .where('title', whereIn: dataMap['productID'])
                                  .get(),
                              builder: (c, dataSnapshot) {
                                return dataSnapshot.hasData
                                    ? AdminOrderCard(
                                        itemCount:
                                            dataSnapshot.data!.docs.length,
                                        data: dataSnapshot.data!.docs,
                                        orderID: orderID,
                                        orderBy: orderBy,
                                        addressId: addressId,
                                        test:
                                            dataMap['orderedProduct.quantity'],
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      );
                              }),
                          FutureBuilder<DocumentSnapshot>(
                              future: firestore
                                  .collection('Users')
                                  .doc(orderBy)
                                  .collection('Address')
                                  .doc(addressId)
                                  .get(),
                              builder: (c, snap) {
                                return snap.hasData
                                    ? AdminShippingDetails(
                                        model: AddressModel.fromJson(snap.data!
                                            .data() as Map<String, dynamic>))
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      );
                              }),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          !(dataMap['orderStatus'] == "Pending")
                              ? Container()
                              : GestureDetector(
                                  onTap: () async {
                                    confirmPendingToRunning(
                                        context, getOrderId);
                                  },
                                  child: Container(
                                    width: Dimensions.screenWidth - 20,
                                    height: Dimensions.screenHeight / 13,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius30),
                                        color: AppColors.mainColor),
                                    child: Center(
                                      child: BigText(
                                        text: "Running Order",
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
                      child: CircularProgressIndicator(),
                    );
            }),
      ),
    ));
  }

  Future<void> confirmPendingToRunning(
      BuildContext context, String mOrderId) async {
    try {
      await firestore
          .collection('Orders')
          .doc(mOrderId)
          .update({'orderStatus': "Running"}).then((_) async {
        /* await firestore
            .collection('Users')
            .doc(orderBy)
            .collection('Orders')
            .doc(mOrderId)
            .update({'orderStatus': "Running"});*/
      });
      getOrderId = "";

      Get.toNamed(RouteHelper.getAdminOrderMainScreen());
      Get.snackbar(
        'Confirmation',
        'State changed successfully',
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
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Pending to Running",
      );
    }
  }
}

class AdminShippingDetails extends StatelessWidget {
  final AddressModel model;
  const AdminShippingDetails({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(Dimensions.width10),
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
                KeyText(
                  msg: "Phone Number : ",
                  color: Colors.grey,
                ),
                BigText(
                  text: model.phoneNumber,
                  color: Colors.grey,
                  size: Dimensions.font20,
                ),
              ]),
              TableRow(children: [
                KeyText(
                  msg: "Province : ",
                  color: Colors.grey,
                ),
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
                KeyText(
                  msg: "Zone : ",
                  color: Colors.grey,
                ),
                BigText(
                  text: model.zone,
                  color: Colors.grey,
                  size: Dimensions.font20,
                ),
              ]),
              TableRow(children: [
                KeyText(
                  msg: "Quarter : ",
                  color: Colors.grey,
                ),
                BigText(
                  text: model.quarter,
                  color: Colors.grey,
                  size: Dimensions.font20,
                ),
              ]),
              TableRow(children: [
                KeyText(
                  msg: "Avenue : ",
                  color: Colors.grey,
                ),
                BigText(
                  text: model.avenue,
                  color: Colors.grey,
                  size: Dimensions.font20,
                ),
              ]),
              TableRow(children: [
                KeyText(
                  msg: "House Number : ",
                  color: Colors.grey,
                ),
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
