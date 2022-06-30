import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/base/custom_loader.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/widgets/order_card.dart';

import '../../utils/colors.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My orders'),
          backgroundColor: AppColors.mainColor,
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('Users')
                .doc(AppConstants.sharedPreferences!
                    .getString(AppConstants.userUID))
                .collection('Orders')
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
