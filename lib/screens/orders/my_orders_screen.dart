// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/colors.dart';
import 'package:pharmacy_plateform/widgets/order_card.dart';

import '../../base/no_data_page.dart';

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
        body: StreamBuilder<QuerySnapshot>(
            stream: /* firestore
                .collection('Users')
                .doc(AppConstants.sharedPreferences!
                    .getString(AppConstants.userUID))
                .collection('Orders')
                .where('orderStatus', isNotEqualTo: "Received")
                .snapshots(),*/
                firestore
                    .collection('Orders')
                    .where('orderBy',
                        isEqualTo: AppConstants.sharedPreferences!
                            .getString(AppConstants.userUID))
                    .where('orderStatus', isEqualTo: "Running")
                    .snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (c, index) {
                        //var temp = (snapshot.data?.docs[index].data()! as Map<String,dynamic>);

                        return FutureBuilder<QuerySnapshot>(
                            future: firestore
                                .collection('Medicines')
                                .where('id',
                                    whereIn: (snapshot.data?.docs[index].data()
                                        as Map<String, dynamic>)['productID'])
                                .get(),
                            builder: (c, snap) {
                              return snap.hasData
                                  ? Container(
                                      child: OrderCard(
                                        itemCount: snap.data!.docs.length,
                                        data: snap.data!.docs,
                                        orderID: snapshot.data!.docs[index].id,
                                        quantity: (snapshot.data?.docs[index]
                                                    .data()
                                                as Map<String, dynamic>)[
                                            'orderedProduct'][0]['quantity'],
                                      ),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.mainColor,
                                      ),
                                    );
                            });
                      })
                  // ignore: prefer_const_constructors
                  : NoDataPage(
                      text: "Empty",
                      imgPath: "assets/image/empty_box.png",
                    );
            }),
      ),
    );
  }
}
