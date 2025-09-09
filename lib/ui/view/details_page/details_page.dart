import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:e_commerce/ui/shared/carousel_slider.dart';
import 'package:e_commerce/ui/view/details_page/details_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatelessWidget {
  final String productId;
  const DetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<DetailsPageController>(
        init: DetailsPageController(productId: productId),
        builder: (controller) {
          print(productId);

          Product? product = controller.product;
          print("Controller product: ${controller.product}");
          print("Product ID in page: $productId");

          if (product == null) {}
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                product == null ? "Product Details" : product.name ?? '',
              ),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : product == null
                ? const Center(child: Text("No product found"))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// الصور
                              carouselslider(product),
                              const SizedBox(height: 20),

                              /// الاسم
                              Text(
                                product.name ?? "No Name",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              /// السعر
                              Text(
                                "\$${product.price ?? 0}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),

                              const Divider(height: 30),

                              /// الوصف
                              Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.description ??
                                    "No description available",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),

                              const Divider(height: 30),

                              /// المقاسات
                              Text(
                                "Available Sizes",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.sizes?.join(", ") ??
                                    "No sizes available",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
