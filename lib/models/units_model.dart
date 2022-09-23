// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

class UnitsModel {
  String? id;
  String? name;
  UnitsModel({this.id, this.name});

  UnitsModel.fromjson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<dynamic, dynamic>;
    // ignore: unnecessary_null_comparison
    if (snap == null) {
      return;
    }
    id = snap.id;
    name = snap['name'];
  }

  tojson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
