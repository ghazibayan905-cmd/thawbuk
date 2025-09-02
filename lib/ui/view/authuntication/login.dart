import 'package:e_commerce/ui/view/authuntication/login_Controller.dart';
import 'package:e_commerce/ui/view/authuntication/sign_Up/sign_Up.dart';
import 'package:e_commerce/core/constant/app_image.dart';
import 'package:e_commerce/ui/shared/app_Colors.dart';
import 'package:e_commerce/ui/view/authuntication/widget/text_Form_Field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({super.key});
  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.8,
                    child: Image.asset(Appimages.unlock, width: 220),
                  ),
                ),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.green,
                  ),
                ),
                SizedBox(height: 20),

                Transform.translate(
                  offset: Offset(5, 0),
                  child: Text_Form_Custom(
                    controllerr: controller.password,
                    onChanged: (value) {
                      controller.password.text = value;
                    },
                    label: "Password",
                    iconlabel: Icons.lock,
                  ),
                ),
                SizedBox(height: 20),
                Transform.translate(
                  offset: Offset(5, 1),
                  child: Text_Form_Custom(
                    controllerr: controller.email,
                    onChanged: (value) {
                      controller.email.text = value;
                    },
                    label: "email",
                    iconlabel: Icons.email,
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () async{
                   await controller.login();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 500,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [Colors.green, Color.fromARGB(255, 44, 82, 1)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  child: Text(
                    "forget password ?",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(("Don’t have an account ? ")),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignUp());
                      },

                      child: Text(
                        "Sign Up",
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
