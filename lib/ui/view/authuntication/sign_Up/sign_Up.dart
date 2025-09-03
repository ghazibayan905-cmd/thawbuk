import 'package:e_commerce/ui/shared/app_Colors.dart';
import 'package:e_commerce/ui/view/authuntication/login.dart';
import 'package:e_commerce/ui/view/authuntication/sign_up/sign_Up_Controller.dart';
import 'package:e_commerce/ui/view/authuntication/widget/text_Form_Field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());
  SignUp({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: AppColors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Column(
                  children: [
                    Text_Form_Custom(
                      label: "Full Name",
                      controllerr: nameController,
                    ),
                    SizedBox(height: 30),
                    Text_Form_Custom(
                      label: "Email",
                      controllerr: emailController,
                    ),
                    SizedBox(height: 30),
                    Text_Form_Custom(
                      label: "Password",
                      controllerr: passwordController,
                    ),
                    SizedBox(height: 30),
                    Text_Form_Custom(
                      label: "Company",
                      controllerr: companyController,
                    ),
                    SizedBox(height: 30),
                    Text_Form_Custom(
                      label: "Role",
                      controllerr: roleController,
                    ),
                    SizedBox(height: 30),
                    Text_Form_Custom(
                      label: "City",
                      controllerr: cityController,
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                SizedBox(
                  height: 60,
                  child: GetBuilder<SignUpController>(
                    builder: (controller) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.green,
                              Color.fromARGB(255, 44, 82, 1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: controller.isLoading
                              ? null
                              : () async {
                                  controller.name = nameController.text;
                                  controller.email = emailController.text;
                                  controller.password = passwordController.text;
                                  controller.role = roleController.text;
                                  controller.companyName =
                                      companyController.text;
                                  controller.city = cityController.text;

                                  await controller.signing_Up();
                                },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: controller.isLoading
                              ? CircularProgressIndicator()
                              : const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => Login());
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
