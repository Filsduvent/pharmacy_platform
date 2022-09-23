// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import '../../models/drug_model.dart';

class DrugController extends GetxController {
  static DrugController instance = Get.find();
  final Rx<List<Drug>> _AdminDrugList = Rx<List<Drug>>([]);

  List<Drug> get AdminDrugList => _AdminDrugList.value;

  @override
  onInit() async {
    super.onInit();
    _AdminDrugList.bindStream(firestore
        .collection('Medicines')
        .where('visibility', isEqualTo: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Drug> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Drug.fromSnap(element),
        );
      }
      return retVal;
    }));
  }
}
