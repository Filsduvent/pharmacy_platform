// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../utils/dimensions.dart';

class PharmacyAddQuantityTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final TextInputType? textInputType;
  final TextInputAction textInputAction;
  const PharmacyAddQuantityTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    this.textInputType,
    required this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: Dimensions.width10, right: Dimensions.height10),
      margin: EdgeInsets.only(
          left: Dimensions.height10 / 2, right: Dimensions.height10 / 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1)
          ]),
      child: TextField(
        autofocus: false,
        controller: textController,
        keyboardType: textInputType,
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
