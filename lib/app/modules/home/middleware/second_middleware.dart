import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:getxauth/app/modules/auth/controllers/auth_controller.dart';
import 'package:getxauth/app/routes/app_pages.dart';

class SecondMiddleware extends GetMiddleware {
  @override
  int? get priority => 4;

  final authC = AuthController();
  bool get isProfileSet => authC.auth!.currentUser!.emailVerified;

  @override
  RouteSettings? redirect(String? route) {
    if (isProfileSet == false) {
      log('is redirect failed');
      return RouteSettings(
          name: Routes.HOME, arguments: authC.user.value!.isAnonymous);
    } else {
      log('is redirect success');
      return RouteSettings(
          name: Routes.PROFILE, arguments: authC.user.value!.uid);
    }
  }
}
