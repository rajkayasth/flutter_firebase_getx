import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_demo/models/user_model.dart';
import 'package:flutter_firebase_demo/repository/authentication_repository/authetication_repository.dart';
import 'package:flutter_firebase_demo/repository/user_repository/user_repository.dart';
import 'package:flutter_firebase_demo/utils/utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  var imageUrl = "".obs;
  final _db = FirebaseFirestore.instance;

  /// Get User Email and Pass to userRepository to fetch user record
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Log in to Continue");
    }
  }

  Future<List<UserModel>> getAllUserData() async {
    return await _userRepo.getAllUser();
  }

  updateRecord(UserModel userModel) async {
    final id = _authRepo.firebaseUser.value?.uid;
    await _userRepo.updateUser(userModel).whenComplete(() => getUserData());
  }

  ///Creating Method for picking Image from Gallery
  Future PickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      uploadImage(image);
      debugPrint(image.path);
      /* final imagePermanant = await saveImagePermanetly(image.path);
      setState(() => this.image = imagePermanant);*/
    } on PlatformException catch (e) {
      debugPrint('Failed to Pick image $e');
    }
  }

  showBottomSheetForPickImage() {
    Get.bottomSheet(
        isDismissible: true,
        SizedBox(
          child: Wrap(
            /*  crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,*/
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Text(
                    "Please Choose One Option",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 21),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  PickImage(ImageSource.camera);
                  Get.back();
                },
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blueGrey, width: 1)),
                  child: const Center(child: Text("Camera")),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  PickImage(ImageSource.gallery);
                  Get.back();
                },
                child: Container(
                  width: double.maxFinite,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blueGrey, width: 1)),
                  child: const Center(child: Text("Gallery")),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))));
  }

  uploadImage(XFile file) async {
    if (file != null) {
      var ref = FirebaseStorage.instance.ref();

      var refDirImage = ref.child("images");
      var refImageToUpload =
          refDirImage.child("${file.name}_${DateTime.now()}");
      try {
        await refImageToUpload.putFile(File(file.path)).whenComplete(
              () => Get.snackbar("Success", "Image uploaded...!",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.withOpacity(0.1),
                  margin: EdgeInsets.all(30),
                  colorText: Colors.green),
            );
        imageUrl.value = await refImageToUpload.getDownloadURL();

      } catch (e) {
        debugPrint("ERROR_UPLOAD ,$e");
      }
    } else {}
  }
}
