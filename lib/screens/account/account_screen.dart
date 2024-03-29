// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors, prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_element

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_plateform/screens/account/update_success_screen.dart';
import '../../../base/show_custom_snackbar.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/account_widget.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
// ignore: library_prefixes
import 'package:firebase_storage/firebase_storage.dart' as fStorages;

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? imageFile;
  var usernameController;
  var phoneController;
  String? username = "";
  String? image = "";
  String? email = "";
  String? phone = "";
  String? role = "";
  String? status = "";
  String? length = "";
  String? profileImageUrl;

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          username = snapshot.data()!["username"];
          image = snapshot.data()!["profilePhoto"];
          email = snapshot.data()!["email"];
          phone = snapshot.data()!["phone"];
          role = snapshot.data()!["role"];
          status = snapshot.data()!["status"];
        });
      }
    });
  }

  Future _getLengthFromFirebase() async {
    await firestore
        .collection('Orders')
        .where("orderBy", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        length = value.docs.length.toString();
      });
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    _getDataFromDatabase();
    _getLengthFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Profile", size: 24, color: Colors.white),
      ),

      //Body
      body: firebaseAuth.currentUser != null && status == "Activated"
          ? Stack(
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.maxFinite,
                      height: Dimensions.popularFoodImgSize / 1.6,
                    )),
                Positioned(
                  left: Dimensions.height30 * 4,
                  right: Dimensions.height30 * 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20 * 0.7,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          child: CircleAvatar(
                            radius:
                                Dimensions.radius30 * 2 + Dimensions.radius15,
                            backgroundImage: imageFile == null
                                ? NetworkImage(image!)
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
                  top: Dimensions.height45 * 3,
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
                  top: (Dimensions.popularFoodImgSize - 20) / 1.6,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.height20 * 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          topLeft: Radius.circular(Dimensions.radius20),
                        ),
                        color: Colors.grey.withOpacity(0.1)),

                    //All content field
                    child: Column(children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //name

                              Container(
                                padding: EdgeInsets.only(
                                    left: Dimensions.width20,
                                    right: Dimensions.width20,
                                    top: Dimensions.width10,
                                    bottom: Dimensions.width10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius30),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1,
                                        offset: const Offset(0, 2),
                                        color: Colors.grey.withOpacity(0.3),
                                      )
                                    ]),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      SizedBox(
                                        width: Dimensions.width20,
                                      ),
                                      BigText(text: username!),
                                      SizedBox(
                                        width: Dimensions.width30,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            usernameController =
                                                TextEditingController(
                                                    text: username);
                                          });
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: BigText(
                                                text: 'Change username Here',
                                                color: AppColors.secondColor,
                                                size: Dimensions.font20,
                                              ),
                                              content: TextField(
                                                autofocus: false,
                                                controller: usernameController,
                                                keyboardType:
                                                    TextInputType.name,
                                                textInputAction:
                                                    TextInputAction.done,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      'Type in the username',
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: BigText(
                                                    text: "Cancel",
                                                    color:
                                                        AppColors.yellowColor,
                                                    size: Dimensions.font20,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    _updateUsername();
                                                  },
                                                  child: BigText(
                                                    text: "Edit",
                                                    color: AppColors.mainColor,
                                                    size: Dimensions.font20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        child: AppIcon(
                                          icon: Icons.edit,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                      ),
                                    ]),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),

                              //phone
                              Container(
                                padding: EdgeInsets.only(
                                    left: Dimensions.width20,
                                    right: Dimensions.width20,
                                    top: Dimensions.width10,
                                    bottom: Dimensions.width10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius30),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1,
                                        offset: const Offset(0, 2),
                                        color: Colors.grey.withOpacity(0.3),
                                      )
                                    ]),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      SizedBox(
                                        width: Dimensions.width20,
                                      ),
                                      BigText(text: phone!),
                                      SizedBox(
                                        width: Dimensions.width30,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            phoneController =
                                                TextEditingController(
                                                    text: phone);
                                          });
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: BigText(
                                                text:
                                                    'Change phone number Here',
                                                color: AppColors.secondColor,
                                                size: Dimensions.font20,
                                              ),
                                              content: TextField(
                                                autofocus: false,
                                                controller: phoneController,
                                                keyboardType:
                                                    TextInputType.phone,
                                                textInputAction:
                                                    TextInputAction.done,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      'Type in phone number',
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: BigText(
                                                    text: "Cancel",
                                                    color:
                                                        AppColors.yellowColor,
                                                    size: Dimensions.font20,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    _updatePhone();
                                                  },
                                                  child: BigText(
                                                    text: "Edit",
                                                    color: AppColors.mainColor,
                                                    size: Dimensions.font20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        child: AppIcon(
                                          icon: Icons.edit,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                      ),
                                    ]),
                              ),

                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //email
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.email,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(text: email!)),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //role
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.functions,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(text: role!)),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //status
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.connected_tv,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(text: status!)),
                              SizedBox(
                                height: Dimensions.height20,
                              ),

                              //number of orders
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.shopping_cart,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(text: length!)),
                              SizedBox(
                                height: Dimensions.height20,
                              ),

                              //logout
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Are you sure?'),
                                        content: BigText(
                                          text: "Exit",
                                          color: AppColors.mainBlackColor,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                //print('Im tapeeeeeeeed');
                                                if (firebaseAuth.currentUser !=
                                                    null) {
                                                  authController
                                                      .clearShareData();
                                                  cartControllers.clear();
                                                  cartControllers
                                                      .clearCartHistory();

                                                  emptyCartNow() {
                                                    AppConstants
                                                        .sharedPreferences!
                                                        .setStringList(
                                                            AppConstants
                                                                .userCartList,
                                                            ["garbageValue"]);
                                                    List<String> tempList =
                                                        AppConstants
                                                                .sharedPreferences!
                                                                .getStringList(
                                                                    AppConstants
                                                                        .userCartList)
                                                            as List<String>;

                                                    firestore
                                                        .collection('Users')
                                                        .doc(AppConstants
                                                            .sharedPreferences!
                                                            .getString(
                                                                AppConstants
                                                                    .userUID))
                                                        .update({
                                                      AppConstants.userCartList:
                                                          tempList,
                                                    }).then((value) {
                                                      AppConstants
                                                          .sharedPreferences!
                                                          .setStringList(
                                                              AppConstants
                                                                  .userCartList,
                                                              tempList);
                                                    });
                                                  }

                                                  authController
                                                      .logOutForCustomer();
                                                }
                                              },
                                              child: BigText(
                                                text: "Yes",
                                                color: Colors.redAccent,
                                              )),
                                          TextButton(
                                              onPressed: () => Get.back(),
                                              child: BigText(
                                                text: "No",
                                                color: AppColors.mainColor,
                                              ))
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.logout,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(text: "Logout")),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
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
          : Container(
              color: Colors.white,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height30 * 10,
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/image/account.png"))),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 5,
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: Center(
                        child: BigText(
                          text: "Sign in",
                          color: Colors.white,
                          size: Dimensions.font26,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ),
    );
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
        _updateProfileInFirestore();
        // Navigator.popAndPushNamed(context, AccountScreen);
      });
    }
  }

  void _updateProfileInFirestore() async {
    String fileId = DateTime.now().microsecondsSinceEpoch.toString();
    fStorages.Reference reference = fStorages.FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(fileId);
    fStorages.UploadTask uploadTask = reference.putFile(File(imageFile!.path));
    fStorages.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) async {
      profileImageUrl = url;
    });

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'profilePhoto': profileImageUrl});
  }

  Future _updateUsername() async {
    try {
      if (usernameController.text.isEmpty) {
        showCustomSnackBar("Fill your username please", title: "username");
      } else if (usernameController.text.length >= 16) {
        showCustomSnackBar("The username can't be over 15 characters",
            title: "UserName");
      } else {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'username': usernameController.text}).then((value) {
          Get.off(UpdateSuccessScreen());
        });
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Editing profile",
      );
    }
  }

  Future _updatePhone() async {
    try {
      if (phoneController.text.isEmpty) {
        showCustomSnackBar("Fill your phone number please",
            title: "phone number");
      } else if (phoneController.text.length != 8) {
        showCustomSnackBar("Wrong phone number format", title: "Phone number");
      } else if (int.parse(phoneController.text) < 0) {
        showCustomSnackBar("Phone number can't be negative",
            title: "Phone number");
      } else {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'phone': phoneController.text}).then((value) {
          Get.off(UpdateSuccessScreen());
        });
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Editing profile",
      );
    }
  }
}
