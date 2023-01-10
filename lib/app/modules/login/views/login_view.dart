import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
        centerTitle: true,
      ),
      body: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (_) {
            return Form(
              // key: _.loginFormKey,
              onChanged: () => _.checkLogin(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: PageView(
                    controller: _.pageController,
                    scrollDirection: Axis.horizontal,
                    pageSnapping: true,
                    onPageChanged: (value) {
                      _.pageChanged.value = value;
                      print('Page numero: ${_.pageChanged.value}');
                    },
                    children: [
                      TextFormField(
                        controller: _.email.value,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Email',
                          prefix: const Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          _.email.value.text = value!;
                        },
                        validator: (value) {
                          return _.validateEmail(value!);
                        },
                      ),
                      TextFormField(
                        controller: _.password.value,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Password',
                          prefix: const Icon(Icons.lock),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (value) {
                          _.password.value.text = value!;
                        },
                        validator: (value) {
                          return _.validatePassword(value!);
                        },
                        obscureText: true,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: Get.mediaQuery.size.width),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepPurpleAccent),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(14),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          onPressed: () => _.logWithEmailPsd(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/home', arguments: Get.arguments),
        child: const Icon(Icons.pages),
      ),
    );
  }
}
