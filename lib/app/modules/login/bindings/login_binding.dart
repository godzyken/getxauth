import 'package:get/get.dart';
import 'package:getxauth/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<AuthController>(
          () => AuthController(),
    );
  }
}
