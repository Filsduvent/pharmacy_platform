import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';

import '../../../../routes/route_helper.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/order_card.dart';

int counter = 0;

class PharmacistOrderCard extends StatelessWidget {
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;
  final String addressId;
  final String orderBy;
  final int quantity;
  const PharmacistOrderCard(
      {Key? key,
      required this.itemCount,
      required this.data,
      required this.orderID,
      required this.addressId,
      required this.orderBy,
      required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (counter == 0) {
        //   counter = counter + 1;
        //   Get.toNamed(RouteHelper.getPharmacistOrderDetailsScreen(
        //       orderID, orderBy, addressId));
        // }
        Get.toNamed(RouteHelper.getPharmacistOrderDetailsScreen(
            orderID, orderBy, addressId));
      },
      child: Container(
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
        padding: EdgeInsets.only(
            top: Dimensions.width10,
            bottom: Dimensions.width10,
            right: Dimensions.width10,
            left: Dimensions.width10),
        margin: EdgeInsets.all(Dimensions.width30 / 2),
        height: itemCount * 155.0,
        child: ListView.builder(
            itemCount: itemCount,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (c, index) {
              Drug model =
                  Drug.fromMaps(data[index].data() as Map<String, dynamic>);
              return sourceOrderInfo(model, quantity, context);
            }),
      ),
    );
  }
}
