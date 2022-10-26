import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/address_model.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';

import '../base/show_custom_snackbar.dart';
import '../routes/route_helper.dart';

class AddressController extends GetxController {
  static AddressController instance = Get.find();

  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Rx<AddressModel?>? _address;
  AddressModel? get user => _address?.value;

  void saveAddressToFirestore(
      String name,
      String phoneNumber,
      String province,
      String commune,
      String zone,
      String quarter,
      String avenue,
      String houseNumber) async {
    try {
      if (name.isEmpty) {
        showCustomSnackBar("Name field can not be empty", title: "Name");
      } else if (phoneNumber.isEmpty) {
        showCustomSnackBar("Phone Number field can not be empty",
            title: "Phone Number");
      } else if (phoneNumber.length != 8) {
        showCustomSnackBar("Wrong phone number format", title: "Phone number");
      } else if (int.parse(phoneNumber) < 0) {
        showCustomSnackBar("Phone number can't be negative",
            title: "Phone number");
      } else if (province.isEmpty) {
        showCustomSnackBar("Provine field can not be empty", title: "Province");
      } else if (commune.isEmpty) {
        showCustomSnackBar("Commune field can not be empty", title: "Commune");
      } else if (zone.isEmpty) {
        showCustomSnackBar("Zone field can not be empty", title: "Zone");
      } else if (quarter.isEmpty) {
        showCustomSnackBar("Quarter field can not be empty", title: "Quarter");
      } else if (avenue.isEmpty) {
        showCustomSnackBar("Avenue field can not be empty", title: "Avenue");
      } else if (houseNumber.isEmpty) {
        showCustomSnackBar("House Number field can not be empty",
            title: "House Number");
      } else if (int.parse(houseNumber) < 0) {
        showCustomSnackBar("House number can't be negative",
            title: "House number");
      } else {
        _isLoading.value = true;
        final model = AddressModel(
                name: name,
                phoneNumber: phoneNumber,
                province: province,
                commune: commune,
                zone: zone,
                quarter: quarter,
                avenue: avenue,
                houseNumber: houseNumber)
            .toJson();

        //add to firestore
        firestore
            .collection('Users')
            .doc(
                AppConstants.sharedPreferences!.getString(AppConstants.userUID))
            .collection('Address')
            .doc(DateTime.now().millisecondsSinceEpoch.toString())
            .set(model)
            .then((value) {
          Get.snackbar('Uploading address', 'New address added successfully!');
          Get.toNamed(RouteHelper.getAddressScreen());
          _isLoading.value = false;
        });
      }
    } catch (e) {
      showCustomSnackBar(
        'Error Creating Account',
        title: "Create account",
      );
    }
  }
}
