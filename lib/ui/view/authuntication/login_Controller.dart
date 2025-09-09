import 'package:e_commerce/core/data/dto/auth_dto.dart';
import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:e_commerce/core/data/repositories/auth_repositories.dart';
import 'package:e_commerce/ui/view/home_page/home_page.dart';
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
        (r)  {
          isLoading = false;
          Get.to(HomePage());
          Get.snackbar("Success", r);
        },
      );
      
    });
    update();
    
  }
}
