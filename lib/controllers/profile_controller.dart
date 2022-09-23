// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userDoc =
        await firestore.collection('Users').doc(_uid.value).get();

    final userData = userDoc.data() as dynamic;
    String username = userData['username'];
    String email = userData['email'];
    String phone = userData['phone'];
    String address = userData['address'];
    String password = userData['password'];
    String status = userData['status'];
    String profilePhoto = userData['profilePhoto'];

    _user.value = {
      'username': username,
      'email': email,
      'phone': phone,
      'address': address,
      'password': password,
      'status': status,
      'profilePhoto': profilePhoto,
    };

    update();
  }
}
