import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getxauth/app/modules/auth/controllers/auth_controller.dart';
import 'package:getxfire/getxfire.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final auth = AuthController();

  var email = TextEditingController().obs;
  var password = TextEditingController().obs;

  final count = 0.obs;
  @override
  void onInit() {
    loginAnonymously();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    email.value.dispose();
    password.value.dispose();
  }
  void increment() => count.value++;

  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password is too short";
    }
    return null;
  }

  loginAnonymously() async {
    try {
      await auth.loginAnonymously();
    } on FirebaseAuthException catch (e) {
      GetxFire.openDialog.messageError(e.message!);
    }
  }

  logWithEmailPsd() async {
    try {
      var user = await auth.auth.signInWithEmailAndPassword(email: email.value.text, password: password.value.text);

      GetxFire.openDialog.messageSuccess(user.toString());
      auth.isLoggin.value = true;
      update();

    } on FirebaseAuthException catch (code, e) {
      GetxFire.openDialog.messageError('$e', title: '$code', duration: const Duration(seconds: 12));
      auth.isLoggin.value = false;
      update();
    }
  }
}
