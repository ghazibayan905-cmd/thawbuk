import 'dart:io';

import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:e_commerce/core/data/repositories/product_repoitories.dart';
import 'package:e_commerce/ui/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateProductController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  // final TextEditingController imageController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();

  bool isLoading = false;
  List<File?> pickedImage = <File>[];

  Future<void> createProduct(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    update();
    List<String> images = [];
    if (pickedImage.isNotEmpty) {
      for (int i = 0; i < pickedImage.length; i++) {
        if (pickedImage[i] != null) {
          images.add(pickedImage[i]!.path);
        }
      }
    }

    final product = Product(
      name: nameController.text,
      description: descriptionController.text,
      price: double.tryParse(priceController.text) ?? 0,
      categoryId: categoryIdController.text,
      images: images,
    );

    final result = await ProductRepositories().createProduct(product);

    result.fold(
      (error) {
        Get.snackbar(
          "Error occured",
          error,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
      (newProduct) {
        Get.snackbar(
          "Success",
          "  create product successfully: ${newProduct.name}",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(() => HomePage(), arguments: newProduct);

        Navigator.pop(context, newProduct);
      },
    );

    isLoading = false;
    update();
  }

  void pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile?> img = await picker.pickMultiImage(
      maxWidth: 400,
      limit: 5,
    );
    if (img.isEmpty) return;

    img.forEach((image) {
      pickedImage.add(File(image!.path));
    });
    update();
  }
}
