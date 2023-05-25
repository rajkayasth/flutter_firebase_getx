import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/custom_widgets/rounded_button.dart';
import 'package:flutter_firebase_demo/login/controller/login_controller.dart';
import 'package:flutter_firebase_demo/routes/route_name.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 10),
              width: double.maxFinite,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomCenter,
                    colors: [Colors.purpleAccent, Colors.tealAccent, Colors.teal]
                ),
              ),
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
              flex: 1,
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
                      "Login",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w900,
                          fontSize: 31),
                    ),
                    const SizedBox(
                      height: 100,
                    ),

                    //Email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: loginController.emailController.value,
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
                        controller: loginController.passwordController.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            Get.snackbar("Error", "Please Enter password",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                                margin: EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20));
                          }
                        },
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
                          loginController.loginUser(
                              loginController.emailController.value.text.trim(),
                              loginController.passwordController.value.text
                                  .trim());
                        }
                      },
                      title: "Login",
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
                          "Don't have an account?",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 21),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () => Get.toNamed(RouteName.signUpScreen),
                          child: const Text(
                            "SignUp",
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
