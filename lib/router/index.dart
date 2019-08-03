import 'package:myapp/common/const.dart';
import 'package:flutter/material.dart';

class RouteUtil {
  static void goHome(BuildContext context) {
    pushReplacementNamed(context, RouteName.home);
  }

  static void goLogin(BuildContext context) {
    pushNamed(context, RouteName.login);
  }

  static void goSearch(BuildContext context) {
    pushNamed(context, RouteName.search);
  }

  static void pushNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushNamed(pageName);
  }

  static void pushReplacementNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushReplacementNamed(pageName);
  }
}
