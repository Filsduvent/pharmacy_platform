import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/screens/account/account_screen.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class UpdateSuccessScreen extends StatelessWidget {
  const UpdateSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: AppColors.mainColor,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height20,
                    vertical: Dimensions.height10),
                child: Text(
                  'Successful update',
                  style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: GestureDetector(
                  onTap: () {
                    Get.to(const AccountScreen());
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20 * 5,
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Center(
                      child: BigText(
                        text: "Go Back",
                        color: Colors.white,
                        size: Dimensions.font26,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
