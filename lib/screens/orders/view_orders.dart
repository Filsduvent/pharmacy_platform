// ignore_for_file: avoid_returning_null_for_void, unused_local_variable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:pharmacy_plateform/pharmacist/controllers/post_drug_controller.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/colors.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';

class ViewOrders extends StatelessWidget {
  final bool isCurrent;
  const ViewOrders({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostDrugController postDrugControllers =
        Get.put(PostDrugController());
    return Scaffold(
      body: Obx(() {
        if (postDrugController.isLoaded == false) {
          List<Drug> orderList = [];
          if (postDrugController.drugList.isNotEmpty) {
            orderList = isCurrent
                ? postDrugController.drugList
                : postDrugController.drugListDel;
          }
          return //Text(orderList.length.toString());
              SizedBox(
                  width: Dimensions.screenWidth,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width10 / 2,
                        vertical: Dimensions.height10 / 2),
                    child: ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () => null,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "#order id    ${orderList[index].id}"),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.mainColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20 /
                                                              4)),
                                              child: Container(
                                                  margin: EdgeInsets.all(
                                                      Dimensions.height10 / 2),
                                                  child: Text(
                                                    orderList[index].status,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                            SizedBox(
                                                height:
                                                    Dimensions.height10 / 2),
                                            InkWell(
                                              onTap: () => null,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius20 /
                                                                4),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .mainColor)),
                                                child: Container(
                                                    margin: EdgeInsets.all(
                                                        Dimensions.height10 /
                                                            2),
                                                    child: const Text(
                                                        "Track order")),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        }),
                  ));
        } else {
          return const Text("Loading...");
        }
      }),
    );
  }
}
