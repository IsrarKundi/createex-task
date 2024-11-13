import 'package:bot_toast/bot_toast.dart';
import 'package:e_labor/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'Createex Task',

      initialRoute: AppRoutes.LOGIN,
      getPages: AppRoutes.routes,
    );
  }
}

