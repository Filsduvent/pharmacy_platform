import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_plateform/base/custom_loader.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/widgets/order_card.dart';

import '../../utils/colors.dart';

class MyOrdersHistoryScreen extends StatefulWidget {
  const MyOrdersHistoryScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersHistoryScreen> createState() => _MyOrdersHistoryScreenState();
}

class _MyOrdersHistoryScreenState extends State<MyOrdersHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: /*firestore
                .collection('Users')
                .doc(AppConstants.sharedPreferences!
                    .getString(AppConstants.userUID))
                .collection('Orders')
                .where('orderStatus', isEqualTo: "Received")
                .snapshots(),*/
                firestore
                    .collection('Orders')
                    .where('orderBy',
                        isEqualTo: AppConstants.sharedPreferences!
                            .getString(AppConstants.userUID))
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
                                  ? OrderCard(
                                      itemCount: snap.data!.docs.length,
                                      data: snap.data!.docs,
                                      orderID: snapshot.data!.docs[index].id)
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
