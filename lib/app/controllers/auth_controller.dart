import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_get/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void signup(String emailAddress, String password) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void login(String emailAddress, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
            title: "Terjadi kesalahan",
            middleText: "No user found for that email.");

        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
            title: "Terjadi kesalahan",
            middleText: "Wrong password provided for that user.");

        print('Wrong password provided for that user.');
      }
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: "Berhasil",
          middleText: "Kami telah mengirimkan reset password ke $email",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          middleText: "Tidak dapat melakukan reset password.",
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "OK",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: "Email tidak valid",
      );
    }
  }
}
