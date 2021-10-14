import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login View'),
        centerTitle: true,
      ),
      body: GetBuilder<LoginController>(builder: (_) {
        return Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                  'User is status ${_.auth.auth.currentUser}',
                  style: const TextStyle(fontSize: 20),
                ),),
                const SizedBox(),
                Form(
                  key: _.loginFormKey,
                  onChanged: () => _.checkLogin(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              const SizedBox(height: 8),
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
                              const SizedBox(height: 16),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: context.width),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                        )
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurpleAccent
                                    ),
                                    padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(14),
                                    ),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  onPressed: () => _.logWithEmailPsd(),
                                ),
                              ),
                            ],
                          ))),
                ),
              ]),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/home', arguments: Get.arguments),
        child: const Icon(Icons.pages),
      ),
    );
  }
}
