// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/user_model.dart' as model;
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base/show_custom_snackbar.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  Rx<User?>? _user;
  User? get user => _user?.value;
  Rx<File?>? _pickedImage;
  File? get profilePhoto => _pickedImage?.value;
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user
  void registerUser(String username, String email, String phone, String address,
      String password, File? image, String confirm, String role) async {
    try {
      /*
        if(username.isNotEmpty && email.isNotEmpty && phone.isNotEmpty && address.isNotEmpty && password.isNotEmpty && image!=null){}
        */
      _isLoading.value = true;
      if (username.isEmpty) {
        showCustomSnackBar("Fill your username please", title: "UserName");
      } else if (email.isEmpty) {
        showCustomSnackBar("Fill your email please", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Fill a valid  email please", title: "Valid email");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Fill your phone number please",
            title: "Phone number");
      } else if (address.isEmpty) {
        showCustomSnackBar("Fill your address please", title: "Address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Fill your password please", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can't be less than 6 characters",
            title: "Password valid");
      } else if (confirm.isEmpty) {
        showCustomSnackBar("Confirm your password  please",
            title: "Confirm password");
      } else if (password != confirm) {
        showCustomSnackBar("Password don't match", title: "Verification");
      } else if (image == null) {
        showCustomSnackBar("Choose an image", title: "Image");
      } else if (role.isEmpty) {
        showCustomSnackBar("Fill your role  please", title: "Role");
      } else {
        // save out user to our ath and firebase firestore

        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await _uploadToStorage(image);

        model.User user = model.User(
            username: username,
            email: email,
            phone: phone,
            address: address,
            status: "Activated",
            role: role,
            password: password,
            profilePhoto: downloadUrl,
            uid: cred.user!.uid,
            userCart: ["garbageValue"],
            pharmaIcon:
                "https://firebasestorage.googleapis.com/v0/b/pharmacyplatform-45bdc.appspot.com/o/pharmacyLogo.jpg?alt=media&token=bb1b3de6-4668-484b-9402-7cbdbd23f251",
            pharmaName: "Default Name");
        await firestore
            .collection('Users')
            .doc(cred.user!.uid)
            .set(user.toJson())
            .then((snap) async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString(
              AppConstants.userUID, cred.user!.uid);
          await sharedPreferences.setString(AppConstants.userName, username);
          await sharedPreferences.setString(AppConstants.userEmail, email);
          await sharedPreferences.setString(AppConstants.userPhone, phone);
          await sharedPreferences.setString(AppConstants.userAddress, address);
          await sharedPreferences.setString(
              AppConstants.userStatus, "activated");
          await sharedPreferences.setString(
              AppConstants.userPassword, password);
          await sharedPreferences.setString(
              AppConstants.userProfilePhoto, downloadUrl);
          await sharedPreferences
              .setStringList(AppConstants.userCartList, ["garbageValue"]);
          await sharedPreferences.setString(AppConstants.userRole, role);
          await sharedPreferences.setString(AppConstants.pharmaIcon,
              "https://firebasestorage.googleapis.com/v0/b/pharmacyplatform-45bdc.appspot.com/o/pharmacyLogo.jpg?alt=media&token=bb1b3de6-4668-484b-9402-7cbdbd23f251");
          await sharedPreferences.setString(
              AppConstants.pharmaName, "Default Name");

          if (cred != null) {
            readData(cred).then((value) async {
              await firestore
                  .collection('Users')
                  .doc(cred.user!.uid)
                  .get()
                  .then((DocumentSnapshot snapshot) {
                var jsons = snapshot.data() as Map<String, dynamic>;
                if (jsons['role'] == 'Admin') {
                  Get.toNamed(RouteHelper.getAdminHomeScreen());
                } else if (jsons['role'] == 'Customer') {
                  Get.toNamed(RouteHelper.getInitial());
                } else if (jsons['role'] == 'Pharmacy owner') {
                  Get.toNamed(RouteHelper.getMainPharmacyPage());
                } else if (jsons['role'] == 'Provider') {
                  Get.toNamed(RouteHelper.getInitial());
                } else {
                  showCustomSnackBar("This kind of role doesn't exist",
                      title: 'Role management');
                }
              });
            });
          }
        });
      }
    } catch (e) {
      showCustomSnackBar(
        'Error Creating Account',
        title: "Create account",
      );
    }
    _isLoading.value = false;
  }

  void loginUser(String email, String password) async {
    try {
      _isLoading.value = true;
      if (email.isNotEmpty && password.isNotEmpty) {
        update();
        UserCredential credit = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        if (credit != null) {
          readData(credit).then((value) async {
            await firestore
                .collection('Users')
                .doc(credit.user!.uid)
                .get()
                .then((DocumentSnapshot snapshot) {
              var jsons = snapshot.data() as Map<String, dynamic>;
              if (jsons['role'] == 'Admin') {
                Get.toNamed(RouteHelper.getAdminHomeScreen());
              } else if (jsons['role'] == 'Customer') {
                Get.toNamed(RouteHelper.getInitial());
              } else if (jsons['role'] == 'Pharmacy owner') {
                Get.toNamed(RouteHelper.getMainPharmacyPage());
              } else if (jsons['role'] == 'Provider') {
                Get.toNamed(RouteHelper.getInitial());
              } else {
                showCustomSnackBar("This kind of role doesn't exist",
                    title: 'Role management');
              }
            });
          });
        }
      } else {
        showCustomSnackBar(
          'Error Login',
          title: "Login",
        );
      }
    } catch (e) {
      showCustomSnackBar(
        'Error Login: Incorrect initials',
        title: "Login",
      );
    }
    _isLoading.value = false;
  }

  // logout

  void logOut() async {
    await firebaseAuth.signOut().then((value) {
      return Get.offNamed(RouteHelper.getSignInPage());
    });
  }

  Future readData(UserCredential credit) async {
    firestore
        .collection("Users")
        .doc(credit.user!.uid)
        .get()
        .then((dataSnapshot) async {
      var json = dataSnapshot.data() as Map<String, dynamic>;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString(
          AppConstants.userUID, json[AppConstants.userUID]);
      await sharedPreferences.setString(
          AppConstants.userName, json[AppConstants.userName]);
      await sharedPreferences.setString(
          AppConstants.userEmail, json[AppConstants.userEmail]);
      await sharedPreferences.setString(
          AppConstants.userPhone, json[AppConstants.userPhone]);
      await sharedPreferences.setString(
          AppConstants.userAddress, json[AppConstants.userAddress]);
      await sharedPreferences.setString(
          AppConstants.userStatus, json[AppConstants.userStatus]);
      await sharedPreferences.setString(
          AppConstants.userPassword, json[AppConstants.userPassword]);
      await sharedPreferences.setString(
          AppConstants.userProfilePhoto, json[AppConstants.userProfilePhoto]);
      await sharedPreferences.setString(
          AppConstants.userRole, json[AppConstants.userRole]);

      List<String> cartList = json[AppConstants.userCartList].Cast<String>();
      await sharedPreferences.setStringList(
          AppConstants.userCartList, cartList);

      await sharedPreferences.setString(
          AppConstants.pharmaIcon, json[AppConstants.pharmaIcon]);
      await sharedPreferences.setString(
          AppConstants.pharmaName, json[AppConstants.pharmaName]);
    });
  }

  bool clearShareData() {
    AppConstants.sharedPreferences!.remove(AppConstants.userUID);
    AppConstants.sharedPreferences!.remove(AppConstants.userName);
    AppConstants.sharedPreferences!.remove(AppConstants.userEmail);
    AppConstants.sharedPreferences!.remove(AppConstants.userPhone);
    AppConstants.sharedPreferences!.remove(AppConstants.userAddress);
    AppConstants.sharedPreferences!.remove(AppConstants.userStatus);
    AppConstants.sharedPreferences!.remove(AppConstants.userPassword);
    AppConstants.sharedPreferences!.remove(AppConstants.userProfilePhoto);
    AppConstants.sharedPreferences!.remove(AppConstants.userCartList);
    AppConstants.sharedPreferences!.remove(AppConstants.userRole);
    AppConstants.sharedPreferences!.remove(AppConstants.drugId);
    AppConstants.sharedPreferences!.remove(AppConstants.pharmaIcon);
    AppConstants.sharedPreferences!.remove(AppConstants.pharmaName);
    return true;
  }
}
