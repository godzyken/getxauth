import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getxauth/app/modules/auth/controllers/auth_controller.dart';

class FirstMiddleware extends GetMiddleware {
  final auth = AuthController();

  bool? get islog => auth.authenticated;

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
    print('>>> Page ${page!.name} called');
    print('>>> User ${auth.user!.uid} logged');

    return auth.user!.displayName != null
        ? page.copy(parameters: {'user': auth.user!.displayName!})
        : page;
  }
}
