// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String email;
  String phone;
  String address;
  String password;
  String status;
  String role;
  String profilePhoto;
  String uid;
  List<dynamic> userCart;
  String pharmaIcon;
  String pharmaName;

  User({
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
    required this.status,
    required this.role,
    required this.profilePhoto,
    required this.uid,
    required this.userCart,
    required this.pharmaIcon,
    required this.pharmaName,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phone": phone,
        "address": address,
        "status": status,
        "role": role,
        "password": password,
        "profilePhoto": profilePhoto,
        "uid": uid,
        "userCart": userCart,
        "pharmaIcon": pharmaIcon,
        "pharmaName": pharmaName,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      email: snapshot['email'],
      phone: snapshot['phone'],
      address: snapshot['address'],
      status: snapshot['status'],
      role: snapshot['role'],
      password: snapshot['password'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      userCart: snapshot['userCart'] as List<dynamic>,
      pharmaIcon: snapshot['pharmaIcon'],
      pharmaName: snapshot['pharmaName'],
    );
  }
}
