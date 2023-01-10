import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HandlerInfo {
  static messageError(code, msg) {
    return Get.defaultDialog(
      title: 'Fail connection code: $code',
      textConfirm: 'Error has seen',
      content: TextButton(
          onPressed: () => Get.back(), child: Text('Error message: $msg\n')),
    );
  }

  static messageSuccess(userCredential) {
    return Get.defaultDialog(
      title: 'Success connection code: $userCredential',
      textConfirm: 'User has been connected',
      confirm: const Text('Success logging'),
    );
  }
}
