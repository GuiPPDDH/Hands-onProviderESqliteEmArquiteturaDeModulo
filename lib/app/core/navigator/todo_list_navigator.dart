import 'package:flutter/material.dart';

class TodoListNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get to => navigatorKey.currentState!;
}
