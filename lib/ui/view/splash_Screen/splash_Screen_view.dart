import 'package:e_commerce/core/utils/genearl_utils.dart';
import 'package:e_commerce/ui/view/authuntication/login.dart';
import 'package:e_commerce/core/constant/app_image.dart';
import 'package:e_commerce/ui/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    fadingAnimation = Tween<double>(
      begin: .3,
      end: 3,
    ).animate(animationController!);

    animationController?.repeat(reverse: true);
    goToNextView();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 185, 236, 140),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset(Appimages.logo)],
      ),
    );
  }
}

void goToNextView() {
  Future.delayed(Duration(seconds: 3), () {
    if (storage.isLoggedIn) {
      Get.off(() => HomePage());
    } else {
      Get.off(() => Login(), transition: Transition.fade);
    }
  });
}
