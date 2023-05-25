import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/repository/authentication_repository/exception/signup_with_email_faliure.dart';
import 'package:flutter_firebase_demo/routes/route_name.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var isComplete = false;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
/*    firebaseUser.value == null
        ? Get.offAllNamed(RouteName.loginScreen)
        : Get.offAllNamed(RouteName.homeScreen);*/
  }

  Future<void> createUserWithEmailPassword(
      String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password).whenComplete(() => {isComplete = true})
          .then((value) => Get.offAllNamed(RouteName.loginScreen));
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure(e.code);
      Get.snackbar("Error", e.code,
          margin: EdgeInsets.all(20),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: CupertinoColors.white);
      debugPrint("FIREBASE_AUTH_EXCEPTION ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = SignupWithEmailAndPasswordFailure();
      debugPrint("FIREBASE_AUTH_EXCEPTION ${ex.message}");
      throw ex;
    }
  }

  Future<void> loginUserWithEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAllNamed(RouteName.homeScreen)
          : Get.offAllNamed(RouteName.loginScreen);
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure(e.code);
      Get.snackbar("Error", e.code,
          margin: EdgeInsets.all(20),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: CupertinoColors.white);
      debugPrint("FIREBASE_AUTH_EXCEPTION ${e.code}");
      throw ex;
    } catch (_) {
      final ex = SignupWithEmailAndPasswordFailure();
      debugPrint("FIREBASE_AUTH_EXCEPTION ${ex.message}");
      throw ex;
    }
  }

  Future<void> logout() async {
    try {
      await _auth
          .signOut()
          .then((value) => Get.offAllNamed(RouteName.loginScreen));
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure(e.code);
      Get.snackbar("Error", e.code,
          margin: EdgeInsets.all(20),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: CupertinoColors.white);
      debugPrint("FIREBASE_AUTH_EXCEPTION ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = SignupWithEmailAndPasswordFailure();
      debugPrint("FIREBASE_AUTH_EXCEPTION ${ex.message}");
      throw ex;
    }
  }
}
