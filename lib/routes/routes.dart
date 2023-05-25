import 'package:flutter_firebase_demo/home_screen/views/home_screen.dart';
import 'package:flutter_firebase_demo/login/views/loginScreen.dart';
import 'package:flutter_firebase_demo/profile/views/profile_Screen.dart';
import 'package:flutter_firebase_demo/routes/route_name.dart';
import 'package:flutter_firebase_demo/signup_screen/views/signup_screen.dart';
import 'package:flutter_firebase_demo/splash/views/splashScreen.dart';
import 'package:get/get.dart';

class AppRoutes {
  appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => SplashScreen(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: const Duration(milliseconds: 1000),
        ),
        GetPage(
          name: RouteName.loginScreen,
          page: () => LoginScreen(),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 250),
        ),
        GetPage(
          name: RouteName.signUpScreen,
          page: () => SignUpScreen(),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 250),
        ),
        GetPage(
          name: RouteName.homeScreen,
          page: () => HomeScreen(),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 250),
        ),
        GetPage(
          name: RouteName.profileScreen,
          page: () => ProfileScreen(),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 250),
        ),
      ];
}
