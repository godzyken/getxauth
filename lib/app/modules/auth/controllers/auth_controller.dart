import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxauth/app/helpers/exception_error.dart';

class AuthController extends GetxController {
  static AuthController get find => Get.find<AuthController>();
  FirebaseAuth? auth;
  late Rx<User?> user;

  final count = 0.obs;
  var isLoggin = false.obs;

  bool? get authenticated => isLoggin.value;

  set authenticated(value) => isLoggin.value = value;

  @override
  void onInit() {
    auth = FirebaseAuth.instance;
    user = Rx<User?>(auth!.currentUser);

    ever(isLoggin, handleAuth);

    isLoggin.value = user != null;
    auth?.userChanges().listen((event) {
      isLoggin.value = user != null;
    });

    update();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  loginAnonymously() async {
    await auth!.signInAnonymously();
  }

  logWithGoogle() async {
    await auth!.signInWithProvider(GoogleAuthProvider());
  }

  registerToFC(String? email, String? password) {
    return auth!
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .onError(
            (error, stackTrace) => HandlerInfo.messageError(error, stackTrace))
        .catchError(onError);
  }

  signOut() {
    auth!.signOut();
  }

  onYesClicked() async {
    if (user.value == null) {
      Get.defaultDialog(
        content: const Text('no one has signed in.'),
        title: 'Error Authentication',
      );
      return;
    }
    await auth!.signOut();

    final String uid = user.value!.uid;
    Get.defaultDialog(
      title: 'Success Sign Out',
      content: Text('$uid has successfully signed out.'),
    );
    isLoggin.value = false;
  }

  handleAuth(isLogged) {
    if (isLogged) {
      Get.offAllNamed('/home', arguments: auth!.currentUser);
      isLoggin.value = true;
      update();
    } else {
      Get.until((route) => Get.currentRoute == '/register');
      isLoggin.value = false;
      update();
    }
  }

  onError(credential) async {
    Future.delayed(
      const Duration(seconds: 1),
      () => throw 401,
    ).then((value) {
      throw 'Unreachable $credential';
    }).catchError((err) {
      log('Error: $err'); // Prints 401.
    }, test: (error) {
      return error is int && error >= 400;
    });
  }
}
