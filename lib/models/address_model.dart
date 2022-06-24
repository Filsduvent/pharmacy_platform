import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String name;
  String phoneNumber;
  String province;
  String commune;
  String zone;
  String quarter;
  String avenue;
  String houseNumber;

  AddressModel(
      {required this.name,
      required this.phoneNumber,
      required this.province,
      required this.commune,
      required this.zone,
      required this.quarter,
      required this.avenue,
      required this.houseNumber});

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "province": province,
        "commune": commune,
        "zone": zone,
        "quarter": quarter,
        "avenue": avenue,
        "houseNumber": houseNumber,
      };

  static AddressModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AddressModel(
      name: snapshot['name'],
      phoneNumber: snapshot['phoneNumber'],
      province: snapshot['province'],
      commune: snapshot['commune'],
      zone: snapshot['zone'],
      quarter: snapshot['quarter'],
      avenue: snapshot['avenue'],
      houseNumber: snapshot['houseNumber'],
    );
  }

  static AddressModel fromJson(Map<String, dynamic> json) {
    return AddressModel(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      province: json['province'],
      commune: json['commune'],
      zone: json['zone'],
      quarter: json['quarter'],
      avenue: json['avenue'],
      houseNumber: json['houseNumber'],
    );
  }
}
