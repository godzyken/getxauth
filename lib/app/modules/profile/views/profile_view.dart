import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileView'),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (_) {
            return Center(
              child: Text(
                'ProfileView is working: ${_.count}',
                style: TextStyle(fontSize: 20),
              ),
            );
          }),
    );
  }
}
