import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/categories_model.dart';

class CategoriesController extends GetxController {
  List<CategoriesModel> get categoryModel => _categoryModel.value;

  final Rx<List<CategoriesModel>> _categoryModel =
      Rx<List<CategoriesModel>>([]);

  final CollectionReference _categoryCollectionRef =
      FirebaseFirestore.instance.collection('Categories');

  getCategory() async {
    _categoryCollectionRef.get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        _categoryModel.bindStream(
            _categoryCollectionRef.snapshots().map((QuerySnapshot query) {
          List<CategoriesModel> retVal = [];
          for (var element in query.docs) {
            retVal.add(
              CategoriesModel.fromjson(element),
            );
          }
          return retVal;
        }));
      }
    });
  }
}
