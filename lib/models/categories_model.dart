// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  String? id, name, image;
  CategoriesModel({
    this.id,
    this.name,
    this.image,
  });

  CategoriesModel.fromjson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<dynamic, dynamic>;
    // ignore: unnecessary_null_comparison
    if (snap == null) {
      return;
    }
    id = snap.id;
    name = snapshot['name'];
    image = snapshot['image'];
  }

  tojson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
