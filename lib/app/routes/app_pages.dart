import 'package:get/get.dart';

import 'package:getxauth/app/modules/auth/bindings/auth_binding.dart';
import 'package:getxauth/app/modules/auth/views/auth_view.dart';
import 'package:getxauth/app/modules/home/bindings/home_binding.dart';
import 'package:getxauth/app/modules/home/middleware/home_middleware.dart';
import 'package:getxauth/app/modules/home/views/home_view.dart';
import 'package:getxauth/app/modules/login/bindings/login_binding.dart';
import 'package:getxauth/app/modules/login/views/login_view.dart';
import 'package:getxauth/app/modules/profile/bindings/profile_binding.dart';
import 'package:getxauth/app/modules/profile/views/profile_view.dart';
import 'package:getxauth/app/modules/register/bindings/register_binding.dart';
import 'package:getxauth/app/modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        middlewares: [FirstMiddleware(), SecondMiddleware()]),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      middlewares: [FirstMiddleware(), SecondMiddleware()],
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    // GetPage(
    //   name: _Paths.REGISTER,
    //   page: () => RegisterView(),
    //   binding: RegisterBinding(),
    // ),
  ];
}
