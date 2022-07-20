import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_plateform/base/custom_loader.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/orders/pharmacist_order_card.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';

class PharmacistOrderHistory extends StatefulWidget {
  const PharmacistOrderHistory({Key? key}) : super(key: key);

  @override
  State<PharmacistOrderHistory> createState() => _PharmacistOrderHistoryState();
}

class _PharmacistOrderHistoryState extends State<PharmacistOrderHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('Orders')
                .where('orderStatus', isEqualTo: "Received")
                .snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (c, index) {
                        //var temp = (snapshot.data?.docs[index].data()! as Map<String,dynamic>);

                        return FutureBuilder<QuerySnapshot>(
                            future: firestore
                                .collection('Medicines')
                                .where('title',
                                    whereIn: (snapshot.data?.docs[index].data()
                                        as Map<String, dynamic>)['productID'])
                                .get(),
                            builder: (c, snap) {
                              return snap.hasData
                                  ? PharmacistOrderCard(
                                      itemCount: snap.data!.docs.length,
                                      data: snap.data!.docs,
                                      orderID: snapshot.data!.docs[index].id,
                                      orderBy: (snapshot.data?.docs[index]
                                              .data()
                                          as Map<String, dynamic>)['orderBy'],
                                      addressId: (snapshot.data?.docs[index]
                                              .data()
                                          as Map<String, dynamic>)['addressId'],
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                            });
                      })
                  : CustomLoader();
            }),
      ),
    );
  }
}
