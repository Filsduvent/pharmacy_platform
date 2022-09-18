// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/address_model.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/colors.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';

import '../../utils/dimensions.dart';
import '../../widgets/wide_button.dart';

class Addresscard extends StatefulWidget {
  final AddressModel model;
  final String addressId;
  //final double? totalAmount;
  final int currentIndex;
  final int value;
  const Addresscard(
      {Key? key,
      required this.model,
      required this.addressId,
      //this.totalAmount,
      required this.currentIndex,
      required this.value})
      : super(key: key);

  @override
  State<Addresscard> createState() => _AddresscardState();
}

class _AddresscardState extends State<Addresscard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (() {
        addressChangerController.displayResult(widget.value);
      }),
      child: Card(
        color: AppColors.mainColor,
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  groupValue: widget.currentIndex,
                  value: widget.value,
                  activeColor: AppColors.secondColor,
                  onChanged: (val) {
                    addressChangerController.displayResult(val as int);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: screenWidth * 0.8,
                      child: Table(children: [
                        TableRow(children: [
                          BigText(text: "Name "),
                          Text(widget.model.name),
                        ]),
                        TableRow(children: [
                          KeyText(msg: "Phone Number "),
                          Text(widget.model.phoneNumber),
                        ]),
                        TableRow(children: [
                          KeyText(msg: "Province "),
                          Text(widget.model.province),
                        ]),
                        TableRow(children: [
                          KeyText(msg: "Commune "),
                          Text(widget.model.commune),
                        ]),
                        TableRow(children: [
                          KeyText(msg: "Zone "),
                          Text(widget.model.zone),
                        ]),
                        TableRow(children: [
                          KeyText(msg: "Quarter "),
                          Text(widget.model.quarter),
                        ]),
                        TableRow(children: [
                          KeyText(msg: "Avenue "),
                          Text(widget.model.avenue),
                        ]),
                        TableRow(children: [
                          KeyText(msg: "House Number "),
                          Text(widget.model.houseNumber)
                        ]),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
            widget.value == addressChangerController.count
                ? WideButton(
                    message: "Proceed",
                    onPressed: () {
                      Get.toNamed(RouteHelper.getPlaceOrder(
                          addressId: widget.addressId));
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class KeyText extends StatelessWidget {
  Color? color;
  double size;
  TextOverflow overflow;
  final String msg;
  KeyText(
      {Key? key,
      required this.msg,
      this.color = const Color(0xFF332d2b),
      this.size = 0,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: size == 0 ? Dimensions.font20 : size,
          fontWeight: FontWeight.w400),
    );
  }
}
