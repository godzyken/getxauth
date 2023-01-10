import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getxauth/app/modules/auth/controllers/auth_controller.dart';

class FirstMiddleware extends GetMiddleware {
  final authC = AuthController();

  bool? get islog => authC.authenticated;

  @override
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    return islog! || route == '/login'
        ? null
        : const RouteSettings(name: '/login');
  }

/*  @override
  Future<GetNavConfig> redirectDelegate(GetNavConfig? route) {

  }*/

  @override
  void onPageDispose() {
    super.onPageDispose();
  }

  @override
  Widget onPageBuilt(Widget? page) {
    return super.onPageBuilt(page!);
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    return super.onPageBuildStart(page!);
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    return super.onBindingsStart(bindings!);
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    log('>>> Page ${page!.name} called');
    log('>>> User ${authC.user.value!.uid} logged');

    return authC.user.value!.displayName != null
        ? page.copy(parameters: {'user': authC.user.value!.displayName!})
        : page;
  }
}
