import 'package:e_commerce/core/data/repositories/auth_repositories.dart';
import 'package:e_commerce/ui/view/authuntication/confirm_account.dart';
import 'package:e_commerce/core/data/dto/auth_dto.dart';
import 'package:e_commerce/ui/view/authuntication/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  String name = "";
  String email = '';
  String password = '';
  String role = '';
  String companyName = '';
  String city = '';
  bool isLoading = false;
  late SignUpDto signUpDto;

  // Future<void> signing_Up() async {
  //   isLoading = true;
  //   update();
  //   signUpDto = SignUpDto(
  //     name: name,
  //     email: email,
  //     password: password,
  //     role: role,
  //     companyName: companyName,
  //   );
  //   if (name.isNotEmpty &&
  //       email.isNotEmpty &&
  //       password.isNotEmpty &&
  //       role.isNotEmpty &&
  //       companyName.isNotEmpty) {
  //     try {
  //       final response = await NetworkUtil.sendRequest(
  //         type: RequestType.POST,
  //         url: AuthEndPoint.signUp,
  //         headers: {'Content-type': 'application/json; charset=UTF-8'},
  //         body: signUpDto.toJson(),
  //       );
  //       if (response != null && response['response']['success'] == true) {
  //         Get.to(() => ConfirmAccount(email: email));
  //         Get.snackbar(
  //           "Success",
  //           "User registered successfully, please verify your email",
  //         );
  //       } else {
  //         Get.snackbar(
  //           "Error",
  //           response?['response']['message'] ?? "SignUp failed",
  //         );
  //       }
  //     } catch (e) {
  //       Get.snackbar("Error", e.toString());
  //     } finally {
  //       isLoading = false;
  //       update();
  //     }
  //   } else {
  //     Get.snackbar("Error", "All fields are required");
  //     isLoading = false;
  //     update();
  //   }
  // }

  Future<void> signing_Up() async {
    isLoading = true;
    update();
    signUpDto = SignUpDto(
      name: name,
      email: email,
      password: password,
      role: role,
      companyName: companyName,
      city: city,
    );
    await AuthRepository().signUp(signUpDto: signUpDto).then((value) {
      value.fold(
        (l) {
          isLoading = false;
          Get.snackbar("Error", l);
        },
        (r) async {
          isLoading = false;
          Get.snackbar("Success", r);
          Get.to(() => ConfirmAccount(email: email));
        },
      );
    });
    update();
  }

  void verifyOtp({required TextEditingController pinController}) async {
    isLoading = true;
    update();

    String otp = pinController.text.trim();

    if (otp.isEmpty) {
      isLoading = false;
      update();
      Get.snackbar("Error", "Enter OTP code");
      return;
    }

    try {
      // تمرير البريد و OTP معاً
      await AuthRepository().verifyEmail(email: email, code: otp).then((value) {
        value.fold(
          (l) {
            isLoading = false;
            update();
            Get.snackbar("Error", l); // رسالة الخطأ من الـ API
          },
          (r) {
            isLoading = false;
            update();
            Get.snackbar("Success", r); // رسالة النجاح
            Get.to(() => Login());
          },
        );
      });
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
  // final response = await NetworkUtil.sendRequest(
  //   type: RequestType.POST,
  //   url: "verify-email",
  //   headers: {'Content-Type': 'application/json; charset=UTF-8'},
  //   body: {'code': otp},
  // );

  // if (response != null && response['response']['success'] == true) {
  //   Get.snackbar(
  //     "Success",
  //     response['response']['message'] ?? 'Success, OTP verification',
  //   );
  // } else {
  //   Get.snackbar(
  //     "Error",
  //     response?['response']['message'] ?? "OTP verification failed",
  //   );
  // }
}
