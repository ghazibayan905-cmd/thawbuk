import 'package:e_commerce/core/data/model/category_model.dart';
import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:e_commerce/core/data/repositories/category_repositories.dart';
import 'package:e_commerce/core/data/repositories/product_repoitories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  List<Product> products = [];
  bool isLoading = false;
  int selectedIndex = 0;
  late Product product;
  List<Product> filteredProducts = [];

  //TextEditingController name = TextEditingController();
  //List<String> images = [];

  List<Categories> categories = [];
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
          products = r; 
          Get.snackbar("Success", "تم جلب ${products.length} منتج");
        },
      );
    });

    update();
  }

  Future<void> fetchAllCategory() async {
    isLoading = true;
    update();
    print("===> fetchAllCategory called");

    await CategoryRepositories().getAllCategory().then((value) {
      value.fold(
        (l) {
          isLoading = false;
          Get.snackbar("Error", l);
        },
        (r) {
          isLoading = false;
          categories = r;
          Get.snackbar("Success", "تم جلب ${categories.length} فئة");
        },
      );
    });

    update();
  }

  Future<void> fetchProductsByCategory(String categoryId) async {
    isLoading = true;
    update();
    print("===> fetchProductsByCategory called");

    await ProductRepoitories().getProductByCategory(categoryId).then((value) {
      value.fold(
        (l) {
          isLoading = false;
          Get.snackbar("Error", l);
        },
        (r) {
          isLoading = false;
          filteredProducts = r; 
          Get.snackbar("Success", "تم جلب ${filteredProducts.length} متج");
        },
      );
    });

    update();
  }

  Future<void> showCategoryDetails(String categoryId) async {
    isLoading = true;
    update();

    await CategoryRepositories().getCategoryDetails(categoryId).then((value) {
      value.fold(
        (l) {
          isLoading = false;
          Get.snackbar("Error", l);
        },
        (r) {
          isLoading = false;
          Get.dialog(
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(r.name ?? "details of category"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (r.sId != null)
                    Text(r.sId!, style: const TextStyle(fontSize: 16)),
                  if (r.description != null)
                    Text(r.description!, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  if (r.name != null)
                    Text(r.name!, style: const TextStyle(fontSize: 16)),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("close"),
                ),
              ],
            ),
          );
        },
      );
    });

    update();
  }

  void changeCategory(int index) {
    selectedIndex = index;
    final selectedCategoryId = categories[index].sId;
    filteredProducts = products
        .where((p) => p.categoryId == selectedCategoryId)
        .toList();
    update();
  }
}
