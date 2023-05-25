import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/repository/authentication_repository/authetication_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  void loginUser(String email,String password){
    AuthenticationRepository.instance.loginUserWithEmailPassword(email, password);
  }
}