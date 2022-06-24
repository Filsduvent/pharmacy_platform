import 'package:get/get.dart';

class AddressChangerController extends GetxController {
  static AddressChangerController instance = Get.find();
  int _counter = 0;
  int get count => _counter;

  displayResult(int v) {
    _counter = v;
    update();
  }
}
