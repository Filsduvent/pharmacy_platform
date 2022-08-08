// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';

class AdminNavigationController extends GetxController {
  static AdminNavigationController instance = Get.find();

  bool _isCollapsed = false;

  bool get isCollapsed => _isCollapsed;

  void toggleIsCollapsed() {
    _isCollapsed = !isCollapsed;

    update();
  }
}
