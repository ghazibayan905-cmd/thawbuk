import 'dart:convert';

import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:e_commerce/core/data/network/network_config.dart';
import 'package:e_commerce/core/data/repositories/product_repoitories.dart';
import 'package:e_commerce/core/enums/request_Type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  List<Product> products = [];
  bool isLoading = false;
  int selectedIndex = 0;
  late Product product;
  //TextEditingController name = TextEditingController();
  //List<String> images = [];

  final List<String> categories = ["All", "Tshirt", "Shoes", "Pants"];
  Future<void> fetchAllProducts() async {
    isLoading = true;
    update();

    await ProductRepoitories().getAllProducts().then((value) {
      value.fold(
        (l) {
          isLoading = false;
          Get.snackbar("Error", l);
        },
        (r) {
          isLoading = false;
          products = r; // خزّن المنتجات
          Get.snackbar("Success", "تم جلب ${products.length} منتج");
        },
      );
    });

    update();
  }

  void changeCategory(int index) {
    selectedIndex = index;
    update();
    // بإمكانك تضيف فلترة حسب الفئة هون لو بدك
  }
}
