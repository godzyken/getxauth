import 'package:get/get.dart';
import 'package:getxauth/app/modules/auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final auth = AuthController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
