// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_new, prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/colors.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import '../models/drug_model.dart';
import 'big_text.dart';

int counter = 0;

class OrderCard extends StatelessWidget {
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;
  final int quantity;
  const OrderCard(
      {Key? key,
      required this.itemCount,
      required this.data,
      required this.orderID,
      required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (counter == 0) {
        //   counter = counter + 1;
        //   Get.toNamed(RouteHelper.getOrderDetailsScreen(orderID));
        // }
        Get.toNamed(RouteHelper.getOrderDetailsScreen(orderID));
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

Widget sourceOrderInfo(Drug model, int quantity, BuildContext context) {
  MediaQuery.of(context).size.width;

  return Container(
    width: double.maxFinite,
    height: Dimensions.height20 * 8,
    child: Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: Dimensions.height20 * 9,
            height: Dimensions.height20 * 8,
            margin: EdgeInsets.only(bottom: Dimensions.height10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(model.photoUrl)),
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white),
          ),
        ),
        SizedBox(
          width: Dimensions.width30 * 2,
        ),
        Expanded(
            child: Container(
          height: Dimensions.height20 * 8,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BigText(
                  text: model.title,
                  color: Colors.black54,
                ),
                BigText(
                  text: model.categories,
                  color: Colors.black54,
                ),
                Row(
                  children: [
                    BigText(
                      text: "BIF",
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 10,
                    ),
                    BigText(
                      text: model.price.toString(),
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 10,
                    ),
                    BigText(
                      text: "/1",
                      color: Colors.black54,
                    ),
                  ],
                ),
                Row(
                  children: [
                    BigText(
                      text: quantity.toString(),
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 10,
                    ),
                    BigText(
                      text: model.units,
                      color: Colors.black54,
                    ),
                  ],
                ),
                Row(
                  children: [
                    BigText(
                      text: "BIF",
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 10,
                    ),
                    BigText(
                      text: (model.price * quantity).toString(),
                      color: AppColors.mainColor,
                    ),
                  ],
                ),

                // Divider(
                //   height: Dimensions.height10 / 2,
                //   color: Colors.black54,
                // ),
              ]),
        )),
      ],
    ),
  );
}
