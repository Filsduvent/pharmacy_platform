import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/colors.dart';
import 'package:pharmacy_plateform/widgets/order_card.dart';

import '../../base/no_data_page.dart';

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
                                  ? OrderCard(
                                      itemCount: snap.data!.docs.length,
                                      data: snap.data!.docs,
                                      orderID: snapshot.data!.docs[index].id,
                                      quantity: (snapshot.data?.docs[index]
                                              .data() as Map<String, dynamic>)[
                                          'orderedProduct'][0]['quantity'],
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
