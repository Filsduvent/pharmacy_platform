import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';

import '../models/categories_model.dart';

class CategoriesController extends GetxController {
  static CategoriesController instance = Get.find();

  final Rx<List<CategoriesModel>> _categoryList = Rx<List<CategoriesModel>>([]);
  List<CategoriesModel> get categoryList => _categoryList.value;

  final CollectionReference _categoryCollectionRef =
      FirebaseFirestore.instance.collection('Categories');

  final Rx<bool> _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;

  @override
  onInit() async {
    super.onInit();
    _categoryList.bindStream(firestore
        .collection('Categories')
        //.limit(5)
        .snapshots()
        .map((QuerySnapshot query) {
      List<CategoriesModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          CategoriesModel.fromjson(element),
        );
        _isLoaded.value = true;
      }
      return retVal;
    }));
  }
  // getCategory() async {
  //   _categoryCollectionRef.get().then((value) {
  //     for (int i = 0; i < value.docs.length; i++) {
  //       _categoryModel.bindStream(
  //           _categoryCollectionRef.snapshots().map((QuerySnapshot query) {
  //         List<CategoriesModel> retVal = [];
  //         for (var element in query.docs) {
  //           retVal.add(
  //             CategoriesModel.fromjson(element),
  //           );
  //         }
  //         return retVal;
  //       }));
  //     }
  //   });
  // }
}
