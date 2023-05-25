import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/custom_widgets/rounded_button.dart';
import 'package:flutter_firebase_demo/models/user_model.dart';
import 'package:flutter_firebase_demo/routes/route_name.dart';
import 'package:flutter_firebase_demo/signup_screen/controller/signup_controller.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.activeBlue,
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 10),
              width: double.maxFinite,
              color: CupertinoColors.activeBlue,
              child: Column(
                children: const [
                  Image(
                    image: AssetImage("assets/image/firebase_image.png"),
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    "Firebase demo app",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 21),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "SIGN UP",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w900,
                          fontSize: 31),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    //Name field textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: signupController.nameController.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            Get.snackbar("Error", "Please Enter Name",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                                margin: EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20));
                          }
                        },
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Enter Name",
                            labelText: "Name",
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: signupController.emailController.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            Get.snackbar("Error", "Please Enter Email",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                                margin: EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20));
                          }
                        },
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Enter Email",
                            labelText: "Email",
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            Get.snackbar("Error", "Please Enter Password",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                                margin: const EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20));
                          }
                        },
                        controller: signupController.passwordController.value,
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Enter Password",
                            labelText: "Password",
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final user = UserModel(
                              email: signupController.emailController.value.text
                                  .trim(),
                              fullName:
                                  signupController.nameController.value.text,
                              password: signupController
                                  .passwordController.value.text);

                          /* SignupController.instance.registerUser(
                              signupController.emailController.value.text
                                  .trim(),
                              signupController.passwordController.value.text
                                  .trim());*/

                          signupController.createUser(user);
                        }
                      },
                      title: "SIGN UP",
                      buttonColor: Colors.blueAccent,
                      cornerRadius: 10,
                      width: 150,
                      height: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already Have an account?",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 21),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () => Get.offNamedUntil(
                              RouteName.loginScreen, (route) => false),
                          child: const Text(
                            "SignIn",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w900,
                                fontSize: 21),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
