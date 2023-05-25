import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_demo/models/user_model.dart';
import 'package:flutter_firebase_demo/repository/authentication_repository/authetication_repository.dart';
import 'package:flutter_firebase_demo/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final emailController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final userRepo = Get.put(UserRepository());

  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailPassword(email, password);
  }

  Future<void> createUser(UserModel userModel) async {
   await userRepo.createUser(userModel);
    registerUser(userModel.email, userModel.password);
  }
}
