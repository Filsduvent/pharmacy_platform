import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/admin/adminscreens/orders/admin_order_card.dart';

import '../../../base/custom_loader.dart';
import '../../../utils/app_constants.dart';

class AdminRunningOrderScreen extends StatefulWidget {
  const AdminRunningOrderScreen({Key? key}) : super(key: key);

  @override
  State<AdminRunningOrderScreen> createState() =>
      _AdminRunningOrderScreenState();
}

class _AdminRunningOrderScreenState extends State<AdminRunningOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('Orders')
                .where('orderStatus', isEqualTo: "Pending")
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
                                  ? AdminOrderCard(
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
