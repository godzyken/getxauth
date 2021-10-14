import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:getxauth/app/modules/auth/controllers/auth_controller.dart';
import 'package:getxauth/app/routes/app_pages.dart';

class SecondMiddleware extends GetMiddleware {
  @override
  int? get priority => 4;

  final auth = AuthController();
  bool get isProfileSet => auth.auth.currentUser!.emailVerified;

  @override
  RouteSettings? redirect(String? route) {
    if (isProfileSet == false) {
      print('is redirect failed');
      return RouteSettings(name: Routes.HOME, arguments: auth.user!.isAnonymous);
    } else {
      print('is redirect success');
      return RouteSettings(name: Routes.PROFILE,  arguments: auth.user!.uid);
    }
  }
}
