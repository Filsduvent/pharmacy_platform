import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';
import '../models/model_on_boarding.dart';
import '../utils/colors.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(model.image),
            height: size.height * 0.3,
          ),
          Column(
            children: [
              BigText(
                text: model.title,
                size: Dimensions.font26,
                color: AppColors.mainBlackColor,
                //style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              Text(
                model.subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: const Color(0xFFccc7c5),
                  fontSize: Dimensions.font20,
                  height: 1.2,
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              BigText(
                text: model.counterText,
                size: Dimensions.font26,
                color: AppColors.yellowColor,
                //style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: Dimensions.height45,
              ),
              model.counterText == "3/3"
                  ? OutlinedButton(
                      onPressed: model.onPressed,
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.black26),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20.0),
                        onPrimary: Colors.white,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: AppColors.secondColor,
                            shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_forward_ios),
                      ))
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}
