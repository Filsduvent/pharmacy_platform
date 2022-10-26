// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers

import 'package:get/get.dart';
import 'package:pharmacy_plateform/screens/drug/search_screen.dart';
import 'package:pharmacy_plateform/screens/home/drug_page_body.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class MainDrugScreen extends StatefulWidget {
  const MainDrugScreen({Key? key}) : super(key: key);

  @override
  State<MainDrugScreen> createState() => _MainDrugScreenState();
}

class _MainDrugScreenState extends State<MainDrugScreen> {
  @override
  Widget build(BuildContext context) {
    // print('current height is' + MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: Column(
        children: [
          // showing the header
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(
                    text: 'Medicine Order',
                    color: AppColors.mainColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(SearchDrugScreen());
                    },
                    child: Center(
                      child: Container(
                          width: Dimensions.width45,
                          height: Dimensions.height45,
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: Dimensions.iconSize24,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                              color: AppColors.mainColor)),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height10,
          ),

          //showing the body
          Expanded(
              child: SingleChildScrollView(
            child: DrugPageBody(),
          ))
        ],
      ),
    );
  }
}
