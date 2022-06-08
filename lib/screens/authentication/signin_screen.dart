// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/base/custom_loader.dart';
import 'package:pharmacy_plateform/screens/authentication/sign_up_screen.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return !authController.isLoading
            ? Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                          width: double.maxFinite,
                          height: Dimensions.popularFoodImgSize / 1.2,
                          color: Colors.grey.withOpacity(0.1))),
                  Positioned(
                    left: Dimensions.height30,
                    right: Dimensions.height30,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: Dimensions.height30 * 3,
                      ),
                      child:
                          //welcome
                          Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        width: double.maxFinite,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome",
                                style: TextStyle(
                                    fontSize: Dimensions.font20 * 3 +
                                        Dimensions.font20 / 2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Sign into your account",
                                style: TextStyle(
                                  fontSize: Dimensions.font20,
                                  color: Colors.grey[500],
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: (Dimensions.popularFoodImgSize - 20) / 1.2,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          top: Dimensions.height20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          topLeft: Radius.circular(Dimensions.radius20),
                        ),
                        color: Colors.white,
                      ),

                      //All content field

                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Dimensions.screenHeight * 0.05,
                                  ),

                                  // your email
                                  AppTextField(
                                      textController: emailController,
                                      textInputType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      hintText: "Email",
                                      icon: Icons.email),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //your password
                                  //your password
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: Dimensions.height10,
                                        right: Dimensions.height10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius30),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            spreadRadius: 7,
                                            offset: Offset(1, 10),
                                            color:
                                                Colors.grey.withOpacity(0.2)),
                                      ],
                                    ),
                                    child: TextField(
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                          //hintText
                                          hintText: "Password",
                                          // prefixIcon
                                          prefixIcon: Icon(
                                            Icons.vpn_key,
                                            color: AppColors.yellowColor,
                                          ),
                                          suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  isObscure = !isObscure;
                                                });
                                              },
                                              child: isObscure == true
                                                  ? Icon(
                                                      Icons.visibility,
                                                      color:
                                                          AppColors.yellowColor,
                                                    )
                                                  : Icon(
                                                      Icons.visibility_off,
                                                      color:
                                                          AppColors.yellowColor,
                                                    )),

                                          //focusedBorder
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius30),
                                              borderSide: const BorderSide(
                                                width: 1.0,
                                                color: Colors.white,
                                              )),
                                          // enabledBorder
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius30),
                                              borderSide: const BorderSide(
                                                width: 1.0,
                                                color: Colors.white,
                                              )),
                                          // border
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius30),
                                          )),
                                      obscureText: isObscure,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),

                                  SizedBox(
                                    height: Dimensions.screenHeight * 0.05,
                                  ),

                                  //sign in button
                                  GestureDetector(
                                    onTap: () => authController.loginUser(
                                        emailController.text,
                                        passwordController.text),
                                    child: Container(
                                      width: Dimensions.screenWidth / 2,
                                      height: Dimensions.screenHeight / 13,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius30),
                                          color: AppColors.mainColor),
                                      child: Center(
                                        child: BigText(
                                          text: "Sign in",
                                          size: Dimensions.font20 +
                                              Dimensions.font20 / 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: Dimensions.screenHeight * 0.05,
                                  ),
                                  //sign up options
                                  RichText(
                                      text: TextSpan(
                                          text: "Don't have an account?",
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: Dimensions.font20),
                                          children: [
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => Get.to(
                                                () => SignUpScreen(),
                                                transition: Transition.fade),
                                          text: " Create",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.mainBlackColor,
                                              fontSize: Dimensions.font20),
                                        )
                                      ])),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : CustomLoader();
      }),
    );
  }
}
