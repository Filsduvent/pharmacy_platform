import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/address_model.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';

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
        color: Colors.pinkAccent.withOpacity(0.4),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  groupValue: widget.currentIndex,
                  value: widget.value,
                  activeColor: Colors.pink,
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
                          const KeyText(msg: "Name "),
                          Text(widget.model.name),
                        ]),
                        TableRow(children: [
                          const KeyText(msg: "Phone Number "),
                          Text(widget.model.phoneNumber),
                        ]),
                        TableRow(children: [
                          const KeyText(msg: "Province "),
                          Text(widget.model.province),
                        ]),
                        TableRow(children: [
                          const KeyText(msg: "Commune "),
                          Text(widget.model.commune),
                        ]),
                        TableRow(children: [
                          const KeyText(msg: "Zone "),
                          Text(widget.model.zone),
                        ]),
                        TableRow(children: [
                          const KeyText(msg: "Quarter "),
                          Text(widget.model.quarter),
                        ]),
                        TableRow(children: [
                          const KeyText(msg: "Avenue "),
                          Text(widget.model.avenue),
                        ]),
                        TableRow(children: [
                          const KeyText(msg: "House Number "),
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
                      print("Im tapeeeeeed niga");
                      /* Routes routes = MaterialPageRoute(builder:(c)=>PaymentPage(
                    addressId: widget.addressId,
                    totalAmount: widget.totalAmount,
                  )) ;
                  Navigator.push(context,route);*/
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
  final String msg;
  const KeyText({Key? key, required this.msg}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
