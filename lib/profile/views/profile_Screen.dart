import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/custom_widgets/rounded_button.dart';
import 'package:flutter_firebase_demo/models/user_model.dart';
import 'package:flutter_firebase_demo/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: FutureBuilder(
          future: profileController.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel userModel = snapshot.data as UserModel;

                final emailController =
                    TextEditingController(text: userModel.email);
                final nameController =
                    TextEditingController(text: userModel.fullName);
                final passwordController =
                    TextEditingController(text: userModel.password);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 50.0, left: 16, right: 16),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        userModel.imageUrl != null
                            ? Obx(() => ClipOval(
                                  child: Image.network(
                                    profileController.imageUrl.value != ""
                                        ? profileController.imageUrl.value
                                        : userModel.imageUrl!,
                                    fit: BoxFit.fitWidth,
                                    height: 200,
                                    width: 200,
                                  ),
                                ))
                            : CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.lightBlueAccent,
                              child: ClipOval(
                                  child: Image.asset(
                                  "assets/image/firebase_image.png",
                                  height: 200,
                                  width: 200,
                                )),
                            ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                              backgroundColor: Colors.yellowAccent,
                              child: IconButton(
                                  onPressed: () {
                                    profileController
                                        .showBottomSheetForPickImage();
                                  },
                                  icon: const Icon(
                                    Icons.camera,
                                    color: Colors.black87,
                                  ))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_2_outlined,
                            color: Colors.black,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          hintText: "Enter Name",
                          label: const Text("Name"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          hintText: "Enter Email",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.black)),
                          label: const Text("Email"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.password,
                            color: Colors.black,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          hintText: "Enter Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.black)),
                          label: const Text("password"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: RoundedButton(
                        onTap: () async {
                          final userData = UserModel(
                              /*id: ,*/
                              id: userModel.id,
                              fullName: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              imageUrl: profileController.imageUrl.value);

                          await profileController.updateRecord(userData);
                        },
                        title: "Edit Profile",
                        buttonColor: Colors.blueAccent,
                        cornerRadius: 50,
                        width: double.maxFinite,
                        height: 55,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: Text("Something Went Wrong"),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
