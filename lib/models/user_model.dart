import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String password;
  final String? imageUrl;

  const UserModel(
      {this.id,
      required this.fullName,
      required this.email,
      required this.password,  this.imageUrl});

  toJson() {
    return {
      "Id": id,
      "FullName": fullName,
      "Email": email,
      "Password": password,
      "imageUrl": imageUrl
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: data["Id"],
        fullName: data["FullName"],
        email: data["Email"],
        password: data["Password"],
        imageUrl: data["imageUrl"]);
  }
}
