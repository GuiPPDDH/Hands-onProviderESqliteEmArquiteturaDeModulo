import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/modules/auth/auth_module.dart';
import 'package:todo_list_provider/app/modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Provider',
      initialRoute: '/login',
      routes: {
        ...AuthModule().routers,
      },
      home: SplashPage(),
    );
  }
}
