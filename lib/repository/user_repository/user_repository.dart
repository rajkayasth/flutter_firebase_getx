import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/models/user_model.dart';
import 'package:flutter_firebase_demo/repository/authentication_repository/authetication_repository.dart';
import 'package:flutter_firebase_demo/utils/utils.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  createUser(UserModel userModel) async {
    var postDocRef = _db.collection(Utils.userCollection).doc();

    await postDocRef
        .set({
          "Id": postDocRef.id,
          "Email": userModel.email,
          "FullName": userModel.fullName,
          "Password": userModel.password
        })
        .whenComplete(
          () => Get.snackbar("Success", "Account has been Created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              margin: EdgeInsets.all(30),
              colorText: Colors.green),
        )
        .catchError(
          (error, stackTrace) {
            Get.snackbar("Error", "Something Went Wrong",
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(30),
                backgroundColor: Colors.redAccent.withOpacity(0.1),
                colorText: Colors.red);
            debugPrint("ERROR_STORE_USER_DATA $error");
          },
        );
  }

  ///Fetch Specific the user data
  Future<UserModel> getUserDetails(String email) async {
    final snapshotData = await _db
        .collection(Utils.userCollection)
        .where("Email", isEqualTo: email)
        .get();
    final userData =
        snapshotData.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  ///Fetch all the users
  Future<List<UserModel>> getAllUser() async {
    final snapshotData = await _db.collection(Utils.userCollection).get();
    final userData =
        snapshotData.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  ///update  users
  Future<void> updateUser(UserModel user) async {
    await _db
        .collection(Utils.userCollection)
        .doc(user.id)
        .update(user.toJson()).whenComplete(() => Get.snackbar("Success", "Record Updated",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        margin: EdgeInsets.all(30),
        colorText: Colors.green),);
  }


}
