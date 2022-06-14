// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../utils/dimensions.dart';

class PharmacyAppTextFieldDate extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final TextInputType? textInputType;
  final TextInputAction textInputAction;
  final VoidCallback onTap;
  const PharmacyAppTextFieldDate({
    Key? key,
    required this.textController,
    required this.hintText,
    this.textInputType,
    required this.textInputAction,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.height20),
      margin: EdgeInsets.only(
          left: Dimensions.height10 / 2, right: Dimensions.height10 / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius30),
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              //spreadRadius: 7,
              offset: Offset(0, 2),
              color: Colors.grey.withOpacity(0.3)),
        ],
      ),
      child: TextField(
        autofocus: false,
        controller: textController,
        keyboardType: textInputType,
        onTap: onTap,
        decoration: InputDecoration(
            //hintText
            hintText: hintText,

            //focusedBorder
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                borderSide: const BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )),
            // enabledBorder
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                borderSide: const BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )),
            // border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
            )),
        textInputAction: textInputAction,
      ),
    );
  }
}
