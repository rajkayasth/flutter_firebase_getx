import 'package:flutter_firebase_demo/repository/authentication_repository/authetication_repository.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {

  static HomeScreenController get instance => Get.find();


  void signout() {
    AuthenticationRepository.instance.logout();
  }
}