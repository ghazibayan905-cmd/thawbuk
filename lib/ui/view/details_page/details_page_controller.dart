import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:e_commerce/core/data/repositories/product_repoitories.dart';
import 'package:get/get.dart';

class DetailsPageController extends GetxController {
  final String productId;

  DetailsPageController({required this.productId});
  bool isLoading = true;
  Product? product;
   @override
  void onInit() {
    super.onInit();
    fetchProductDetails(); 
  }
  Future<void> fetchProductDetails() async {
    try {
      isLoading = true;
      update(); // أول شي نخبر الواجهة إنو في تحميل

      final value = await ProductRepoitories().getSingleProduct(productId);

      value.fold(
        (l) {
          isLoading = false;
          update();
          Get.snackbar("Error", l);
        },
        (r) {
          isLoading = false;
          product = r;
          update(); 
          Get.snackbar("Success", "تم جلب المنتج ${product?.name}");
        },
      );
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar("Exception", e.toString());
    }
  }
}
