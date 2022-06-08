import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction textInputAction;
  const AppTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.suffixIcon,
    this.textInputType,
    required this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.height10, right: Dimensions.height10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius30),
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              spreadRadius: 7,
              offset: Offset(1, 10),
              color: Colors.grey.withOpacity(0.2)),
        ],
      ),
      child: TextField(
        autofocus: false,
        controller: textController,
        keyboardType: textInputType,
        decoration: InputDecoration(
            //hintText
            hintText: hintText,
            // prefixIcon
            prefixIcon: Icon(
              icon,
              color: AppColors.yellowColor,
            ),
            suffixIcon: Icon(
              suffixIcon,
              color: AppColors.yellowColor,
            ),

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
