import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../base/no_data_page.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';
import 'admin_order_card.dart';

class AdminOrderHistoryScreen extends StatefulWidget {
  const AdminOrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<AdminOrderHistoryScreen> createState() =>
      _AdminOrderHistoryScreenState();
}

class _AdminOrderHistoryScreenState extends State<AdminOrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('Orders')
                .orderBy('orderStatus', descending: true)
                .where('orderStatus', isNotEqualTo: "Pending")
                .snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData
                  ? Stack(
                      children: [
                        // color cover back ground
                        Positioned(
                          left: 0,
                          right: 0,
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.popularFoodImgSize,
                            color: AppColors.mainColor,
                          ),
                        ),

                        //The container with the number of items in firebase
                        Positioned(
                          top: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          child: Container(
                            height: Dimensions.height45 * 1.3,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.secondColor,
                              borderRadius: BorderRadius.circular(29.5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text: "Orders drafts : ",
                                        color: Colors.white,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: Dimensions.height10,
                                            bottom: Dimensions.height10,
                                            left: Dimensions.width10,
                                            right: Dimensions.width10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: Dimensions.width10 / 2,
                                            ),
                                            BigText(
                                                text: snapshot.hasData
                                                    ? snapshot.data!.docs.length
                                                        .toString()
                                                    : "0"),
                                            SizedBox(
                                              width: Dimensions.width10 / 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //the white background on wich we have all delails
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          top: Dimensions.popularFoodImgSize - 190,
                          child: Container(
                            padding: EdgeInsets.only(
                                // left: Dimensions.width20,
                                // right: Dimensions.width20,
                                top: Dimensions.height10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                topLeft: Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.white,
                            ),

                            // the content of the white background
                            child: snapshot.hasData &&
                                    snapshot.data!.docs.isNotEmpty
                                ? ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (c, index) {
                                      //var temp = (snapshot.data?.docs[index].data()! as Map<String,dynamic>);

                                      return FutureBuilder<QuerySnapshot>(
                                          future: firestore
                                              .collection('Medicines')
                                              .where('id',
                                                  whereIn: (snapshot
                                                              .data?.docs[index]
                                                              .data()
                                                          as Map<String,
                                                              dynamic>)[
                                                      'productID'])
                                              .get(),
                                          builder: (c, snap) {
                                            return snap.hasData
                                                ? AdminOrderCard(
                                                    itemCount:
                                                        snap.data!.docs.length,
                                                    data: snap.data!.docs,
                                                    orderID: snapshot
                                                        .data!.docs[index].id,
                                                    orderBy: (snapshot
                                                            .data?.docs[index]
                                                            .data()
                                                        as Map<String,
                                                            dynamic>)['orderBy'],
                                                    addressId:
                                                        (snapshot.data
                                                                    ?.docs[index]
                                                                    .data()
                                                                as Map<String,
                                                                    dynamic>)[
                                                            'addressId'],
                                                    quantity: (snapshot
                                                                    .data?.docs[index]
                                                                    .data()
                                                                as Map<String,
                                                                    dynamic>)[
                                                            'orderedProduct'][0]
                                                        ['quantity'],
                                                  )
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  );
                                          });
                                    })
                                // ignore: prefer_const_constructors
                                : NoDataPage(
                                    text: "Empty",
                                    imgPath: "assets/image/empty_box.png",
                                  ),
                          ),
                        ),
                      ],
                    )
                  : Container();
            }),
      ),
    );
  }
}
