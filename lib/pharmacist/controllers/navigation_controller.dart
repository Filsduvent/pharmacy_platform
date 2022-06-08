// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();

  bool _isCollapsed = false;

  bool get isCollapsed => _isCollapsed;

  void toggleIsCollapsed() {
    _isCollapsed = !isCollapsed;

    update();
  }
}
