import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getxauth/app/helpers/exception_error.dart';
import 'package:getxauth/app/modules/auth/controllers/auth_controller.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(debugLabel: '_loginFormKey');
  final authC = AuthController();
  final pageController = PageController(initialPage: 1);

  var email = TextEditingController().obs;
  var password = TextEditingController().obs;

  var pageChanged = 0.obs;

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
      UserCredential user = await authC.loginAnonymously();
      HandlerInfo.messageSuccess(user.user!.isAnonymous);
    } on FirebaseAuthException catch (code, e) {
      HandlerInfo.messageError(code, e);
    }
  }

  logWithEmailPsd() async {
    try {
      UserCredential user =
          await authC.registerToFC(email.value.text, password.value.text);
      HandlerInfo.messageSuccess(user.user!.displayName!);
      authC.isLoggin.isTrue;
      update();
    } on FirebaseAuthException catch (code, e) {
      HandlerInfo.messageError(code, e);
      authC.isLoggin.isFalse;
      update();
    }
  }
}
