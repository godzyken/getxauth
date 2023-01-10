import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxauth/app/helpers/exception_error.dart';
import 'package:getxauth/app/modules/auth/controllers/auth_controller.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final authC = AuthController();

  var name = TextEditingController().obs;
  var email = TextEditingController().obs;
  var password = TextEditingController().obs;

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

  void checkLogin() {
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    registerFormKey.currentState!.save();
  }

  String? validateName(String value) {
    if (!GetUtils.isUsername(value)) {
      return "Provide valid Username";
    }
    return null;
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

  regWithEmailPsd() async {
    try {
      var user =
          await authC.registerToFC(email.value.text, password.value.text);
      HandlerInfo.messageSuccess(user.user);
      authC.isLoggin.isTrue;
      update();
    } on FirebaseAuthException catch (code, msg) {
      HandlerInfo.messageError(code, msg);
      authC.isLoggin.isFalse;
      update();
    }
  }
}
