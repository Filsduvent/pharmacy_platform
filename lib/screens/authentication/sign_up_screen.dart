// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last, prefer_typing_uninitialized_variables, unused_field, prefer_final_fields, avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_plateform/base/custom_loader.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var confirmController = TextEditingController();

  bool isObscure = true;
  bool isVisible = true;

  var selectedType;
  List<String> _accountType = [
    'Admin',
    'Pharmacy owner',
    'Customer',
    'Provider'
  ];
  var role = "Customer";
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
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
                  left: Dimensions.height30 * 4,
                  right: Dimensions.height30 * 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Dimensions.height30 * 2,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          child: CircleAvatar(
                            radius:
                                Dimensions.radius30 * 2 + Dimensions.radius15,
                            backgroundImage: imageFile == null
                                ? AssetImage(
                                    "assets/image/user_avatar_image.jpg")
                                : Image.file(imageFile!).image,
                            backgroundColor: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // choose photo icon
                Positioned(
                  top: Dimensions.height45 * 4,
                  left: Dimensions.width45 * 5,
                  child: GestureDetector(
                    onTap: () => _showImageDialog(),
                    child: AppIcon(
                      icon: Icons.add_a_photo,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height30,
                      size: Dimensions.height30 * 2,
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
                    child: Column(children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Dimensions.screenHeight * 0.05,
                              ),

                              //your name

                              AppTextField(
                                  textController: nameController,
                                  textInputType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  hintText: "Username",
                                  icon: Icons.person),
                              SizedBox(
                                height: Dimensions.height20,
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

                              //your phone
                              AppTextField(
                                  textController: phoneController,
                                  textInputType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  hintText: "Phone",
                                  icon: Icons.phone),
                              SizedBox(
                                height: Dimensions.height20,
                              ),

                              //your address
                              AppTextField(
                                  textController: addressController,
                                  textInputType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  hintText: "Address",
                                  icon: Icons.location_on_outlined),
                              SizedBox(
                                height: Dimensions.height20,
                              ),

                              //Your role
                              Container(
                                margin: EdgeInsets.only(
                                    left: Dimensions.height10,
                                    right: Dimensions.height10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius30),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 7,
                                        offset: Offset(1, 10),
                                        color: Colors.grey.withOpacity(0.2)),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppIcon(
                                      icon: Icons.functions,
                                      iconColor: AppColors.yellowColor,
                                      backgroundColor: Colors.white,
                                      iconSize: Dimensions.iconSize24,
                                    ),
                                    SizedBox(
                                      width: Dimensions.width30,
                                    ),
                                    DropdownButton(
                                      items: _accountType
                                          .map((value) => DropdownMenuItem(
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                value: value,
                                              ))
                                          .toList(),
                                      onChanged: (selectedAccountType) {
                                        setState(() {
                                          selectedType = selectedAccountType;
                                          role = selectedAccountType.toString();
                                        });
                                      },
                                      value: selectedType,
                                      isExpanded: false,
                                      hint: Text(
                                        'Choose Account Type',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),

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
                                        color: Colors.grey.withOpacity(0.2)),
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
                                              FocusScope.of(context).unfocus();
                                              isObscure = !isObscure;
                                            });
                                          },
                                          child: isObscure == true
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: AppColors.yellowColor,
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: AppColors.yellowColor,
                                                )),

                                      //focusedBorder
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius30),
                                          borderSide: const BorderSide(
                                            width: 1.0,
                                            color: Colors.white,
                                          )),
                                      // enabledBorder
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
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
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),

                              //your confirm password field
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
                                        color: Colors.grey.withOpacity(0.2)),
                                  ],
                                ),
                                child: TextField(
                                  controller: confirmController,
                                  decoration: InputDecoration(
                                      //hintText
                                      hintText: "Confirm Password",
                                      // prefixIcon
                                      prefixIcon: Icon(
                                        Icons.vpn_key,
                                        color: AppColors.yellowColor,
                                      ),
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              FocusScope.of(context).unfocus();
                                              isVisible = !isVisible;
                                            });
                                          },
                                          child: isVisible == true
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: AppColors.yellowColor,
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: AppColors.yellowColor,
                                                )),

                                      //focusedBorder
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius30),
                                          borderSide: const BorderSide(
                                            width: 1.0,
                                            color: Colors.white,
                                          )),
                                      // enabledBorder
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
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
                                  obscureText: isVisible,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              //sign up button

                              GestureDetector(
                                onTap: () {
                                  authController.registerUser(
                                    nameController.text,
                                    emailController.text,
                                    phoneController.text,
                                    addressController.text,
                                    passwordController.text,
                                    imageFile,
                                    confirmController.text,
                                    role,
                                  );
                                },
                                child: Container(
                                  width: Dimensions.screenWidth / 2,
                                  height: Dimensions.screenHeight / 13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius30),
                                      color: AppColors.mainColor),
                                  child: Center(
                                    child: BigText(
                                      text: "Sign up",
                                      size: Dimensions.font20 +
                                          Dimensions.font20 / 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              //Tag line
                              RichText(
                                  text: TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Get.back(),
                                      text: "Have an account already?",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: Dimensions.font20))),
                              SizedBox(
                                height: Dimensions.screenHeight * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            )
          : CustomLoader();
    }));
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: BigText(
              text: "Please select an option",
              color: AppColors.mainBlackColor,
              size: Dimensions.font20,
            ),
            children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt),
                    const Padding(padding: EdgeInsets.all(7.0)),
                    BigText(
                      text: " Camera",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font16,
                    ),
                  ],
                ),
                onPressed: () {
                  _getFromCamera();
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.image),
                    const Padding(padding: EdgeInsets.all(7.0)),
                    BigText(
                      text: " Gallery",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font16,
                    ),
                  ],
                ),
                onPressed: () {
                  _getFromGallery();
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.cancel),
                    const Padding(padding: EdgeInsets.all(7.0)),
                    BigText(
                      text: " Cancel",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font16,
                    ),
                  ],
                ),
                onPressed: () => Get.back(),
              ),
            ],
          );
        });
  }

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Get.back();
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Get.back();
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }
}
