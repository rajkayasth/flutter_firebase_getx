import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/splash/controller/splashService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: const Center(
          child: Text("Splash Screen",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 21),),
        ),
      ),
    );
  }
}
