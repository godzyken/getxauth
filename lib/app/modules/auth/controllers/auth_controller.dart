import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController
  final auth = GetxFire.auth;
  final user = GetxFire.currentUser;

  final count = 0.obs;
  var isLoggin = false.obs;

  bool? get authenticated => isLoggin.value;

  set authenticated(value) => isLoggin.value = value;

  @override
  void onInit() {
    ever(isLoggin, handleAuth);
    isLoggin.value = user != null;
    GetxFire.userChanges().listen((event) {
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
    await GetxFire.signInAnonymously(
      onSuccess: (userCredential) {
        GetxFire.openDialog.messageSuccess(
          'user is anonymous : ${userCredential!.user}',
          title: 'Anonymous',
          duration: const Duration(seconds: 10),
        );
        isLoggin.value = true;
      },
      onError: (code, msg) {
        GetxFire.openDialog.messageError(
          'Failed to sign in anonymously\n$msg',
          title: 'Fail connection',
          duration: const Duration(seconds: 10),
        );
        isLoggin.value = false;
      },
      isErrorDialog: true,
      isSuccessDialog: true,
    );
  }

  signOut() async {
    await GetxFire.openDialog.confirm(
      onYesClicked: onYesClicked,
      content: "Are you sure to sign out?",
      lottiePath: GetxFire.lottiePath.THINKING,
    );
  }

  onYesClicked() async {
    if (user == null) {
      GetxFire.openDialog.info(
        content: 'no one has signed in.',
        title: 'Erreur Auth',
      );
      return;
    }
    await GetxFire.signOut();

    final String uid = user!.uid;
    GetxFire.openDialog.info(
      content: '$uid has successfully signed out.',
      title: 'Success Sign Out',
    );
    isLoggin.value = false;
  }

  handleAuth(isLogged) {
    if (isLogged) {
      Get.offAllNamed('/home', arguments: auth.currentUser);
      isLoggin.value = true;
      update();
    } else {
      Get.until((route) => Get.currentRoute == '/register');
      isLoggin.value = false;
      update();
    }
  }
}
