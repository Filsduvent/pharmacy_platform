import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/drug_model.dart';

class RecentDrugController extends GetxController {
  final Rx<List<Drug>> _recentDrugList = Rx<List<Drug>>([]);

  List<Drug> get recentDrugList => _recentDrugList.value;

  final Rx<bool> _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;

  @override
  void onInit() {
    super.onInit();
    _recentDrugList.bindStream(FirebaseFirestore.instance
        .collection('drug')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Drug> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Drug.fromSnap(element),
        );
        _isLoaded.value = true;
      }
      return retVal;
    }));
  }
}
