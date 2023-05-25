import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_demo/routes/route_name.dart';
import 'package:get/get.dart';

class SplashServices {
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  void isLogin() {
    firebaseUser = Rx<User?>(_auth.currentUser);

    Timer(
      const Duration(seconds: 3),
      () => {
        firebaseUser.value == null
            ? Get.offAllNamed(RouteName.loginScreen)
            : Get.offAllNamed(RouteName.homeScreen),
      },
    );
  }
}
