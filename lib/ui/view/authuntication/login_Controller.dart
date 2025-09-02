import 'package:e_commerce/core/data/dto/auth_dto.dart';
import 'package:e_commerce/core/data/repositories/auth_repositories.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // String email = '';
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  bool isLoading = true;
  late LoginDto loginDto;

  Future<void> login() async {
    isLoading = true;
    loginDto = LoginDto(email: email.text, password: password.text);
    update();

    await AuthRepository().logIn(loginDto: loginDto).then((value) {
      value.fold(
        (l) {
          isLoading = false;
          Get.snackbar("Error", l);
        },
        (r) async {
          isLoading = false;
          Get.snackbar("Success", r);
        },
      );
    });
    update();
  }
}
