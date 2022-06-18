// ignore_for_file: unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';

import 'drug_model.dart';

class CartModel {
  String? id;
  String? title;
  int? price;
  String? photoUrl;
  int? quantity;
  bool? isExist;
  String? time;
  Drug? drug;

  CartModel(
      {this.id,
      this.title,
      this.price,
      this.photoUrl,
      this.quantity,
      this.isExist,
      this.time,
      this.drug});

  CartModel.fromJson(DocumentSnapshot snap) {
    var json = snap.data() as Map<String, dynamic>;

    id = snap.id;
    title = json['title'].toString();
    price = json['price'] as int;
    photoUrl = json['photoUrl'].toString();
    quantity = json['quantity'] as int;
    isExist = json['isExist'] as bool;
    time = json['time'].toString();
    drug = Drug.fromMaps(json['drug']);
  }
  CartModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'].toString();
    price = data['price'] as int;
    photoUrl = data['photoUrl'].toString();
    quantity = data['quantity'] as int;
    isExist = data['isExist'] as bool;
    time = data['time'].toString();
    drug = Drug.fromMaps(data['drug']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "price": this.price,
      "photoUrl": this.photoUrl,
      "quantity": this.quantity,
      "isExist": this.isExist,
      "time": this.time,
      "drug": this.drug!.toJson(),
    };
  }
}
