import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/home_screen/controller/home_Screen_controller.dart';
import 'package:flutter_firebase_demo/profile/controller/profile_controller.dart';
import 'package:flutter_firebase_demo/routes/route_name.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController controller = Get.put(HomeScreenController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.yellow.shade200,
        title: Text(
          "Home Screen",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Get.toNamed(RouteName.profileScreen);
            },
            icon: const Icon(
              CupertinoIcons.person,
              color: CupertinoColors.black,
            )),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Delete Chat",
                titlePadding: const EdgeInsets.only(top: 20),
                middleText: "Are You Sure U want to Delete Chat",
                contentPadding: const EdgeInsets.all(20),
                textConfirm: "Yes",
                textCancel: "No",
                onConfirm: () => controller.signout(),
                onCancel: () => Get.back(),
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: profileController.getAllUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.green.shade50,
                    margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(width: 1, color: Colors.black45)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           snapshot.data![index].imageUrl != null
                                ? ClipOval(child: Image.network(snapshot.data![index].imageUrl!,fit: BoxFit.fitWidth,height: 50,width: 50,),clipBehavior: Clip.antiAlias,)
                                :  ClipOval(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.red,
                                    child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                  ),
                                ),

                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![index].fullName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 21,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  snapshot.data![index].email,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  snapshot.data![index].password,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
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
    );
  }
}
