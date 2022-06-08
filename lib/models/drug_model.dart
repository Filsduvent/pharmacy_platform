import 'package:cloud_firestore/cloud_firestore.dart';

class Drug {
  String? id;
  String? title;
  //final String manifacturingDate;
  String? expiringDate;
  String? photoUrl;
  String? categories;
  int? price;
  //String? description;
  Drug({
    this.id,
    this.title,
    // this.manifacturingDate,
    this.expiringDate,
    this.photoUrl,
    this.categories,
    this.price,
    // this.description,
  });

  Drug.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    id = snap.id;
    title = snapshot['title'].toString();
    //manifacturingDate: snapshot['manifacturing_date'].toString();
    expiringDate = snapshot['expiring_date'].toString();
    photoUrl = snapshot['photo_url'].toString();
    categories = snapshot['categories'].toString();
    price = snapshot['price'] as int;
    //description = snapshot['description'].toString();
  }

  Drug.fromMaps(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'].toString();
    //manifacturingDate: snapshot['manifacturing_date'].toString(),
    expiringDate = data['expiring_date'].toString();
    photoUrl = data['photo_url'].toString();
    categories = data['categories'].toString();
    price = data['price'] as int;
    //description = data['description'].toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      //'manifacturing_date': manifacturingDate,
      'expiring_date': expiringDate,
      'photo_url': photoUrl,
      'categories': categories,
      'price': price,
      //'description': description,
    };
  }
}
