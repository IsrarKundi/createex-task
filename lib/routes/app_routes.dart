import 'package:e_labor/home/views/home_screen.dart';
import 'package:get/get.dart';

import '../authentication/views/login_screen.dart';


class AppRoutes {
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const MAINSCREEN = '/main_screen';



  static List<GetPage> routes = [
    GetPage(
      name: LOGIN,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: HOME,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: MAINSCREEN,
      page: () => MainScreen(),
    ),

  ];
}