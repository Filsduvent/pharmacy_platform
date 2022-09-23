// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';
import '../../../../utils/dimensions.dart';

class QrCodeContentUpdate extends StatelessWidget {
  BigText bigText;
  QrCodeContentUpdate({
    Key? key,
    required this.bigText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.width45 * 7.8,
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.width20,
      ),
      margin: EdgeInsets.only(
          left: Dimensions.height10 / 2, right: Dimensions.height10 / 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              offset: const Offset(0, 2),
              color: Colors.grey.withOpacity(0.3),
            )
          ]),
      child: Container(
        width: Dimensions.width45 * 6,
        height: Dimensions.height20 * 2.1,
        padding: const EdgeInsets.only(left: 10),
        child: bigText,
      ),
    );
  }
}
