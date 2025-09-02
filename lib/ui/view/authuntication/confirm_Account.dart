import 'package:e_commerce/ui/view/authuntication/sign_Up/sign_Up_Controller.dart';
import 'package:e_commerce/core/enums/request_Type.dart';
import 'package:e_commerce/core/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ConfirmAccount extends StatelessWidget {
  final String email;

  ConfirmAccount({super.key, required this.email});

  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.find<SignUpController>();
    return Scaffold(
      appBar: AppBar(title: Text("OTP Verification")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter the OTP sent to $email"),
            const SizedBox(height: 24),
            Pinput(
              length: 6,
              controller: pinController,
              onChanged: (value) {
                pinController.text = value;
              },
              
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                controller.verifyOtp(pinController: pinController);
              },
              child: const Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
