import 'package:cloud_firestore/cloud_firestore.dart';

class Drug {
  String id;
  String title;
  String manufacturingDate;
  String expiringDate;
  String photoUrl;
  String categories;
  int price;
  String uid;
  String publishedDate;
  String status;
  String description;
  bool visibility;
  Drug({
    required this.id,
    required this.title,
    required this.manufacturingDate,
    required this.expiringDate,
    required this.photoUrl,
    required this.categories,
    required this.price,
    required this.uid,
    required this.publishedDate,
    required this.status,
    required this.description,
    required this.visibility,
  });

  static Drug fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Drug(
      id: snap.id,
      title: snapshot['title'].toString(),
      manufacturingDate: snapshot['manufacturing_date'].toString(),
      expiringDate: snapshot['expiring_date'].toString(),
      photoUrl: snapshot['photo_url'].toString(),
      categories: snapshot['categories'].toString(),
      price: snapshot['price'] as int,
      uid: snapshot['uid'].toString(),
      publishedDate: snapshot['published_date'].toString(),
      status: snapshot['status'].toString(),
      description: snapshot['description'].toString(),
      visibility: snapshot['visibility'],
    );
  }

  static Drug fromMaps(Map<String, dynamic> data) {
    return Drug(
      id: data['id'],
      title: data['title'].toString(),
      manufacturingDate: data['manufacturing_date'].toString(),
      expiringDate: data['expiring_date'].toString(),
      photoUrl: data['photo_url'].toString(),
      categories: data['categories'].toString(),
      price: data['price'] as int,
      uid: data['uid'].toString(),
      publishedDate: data['published_date'],
      status: data['status'],
      description: data['description'].toString(),
      visibility: data['visibility'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "manufacturing_date": manufacturingDate,
        "expiring_date": expiringDate,
        "photo_url": photoUrl,
        "categories": categories,
        "price": price,
        "uid": uid,
        "published_date": publishedDate,
        "status": status,
        "description": description,
        "visibility": visibility
      };
}
