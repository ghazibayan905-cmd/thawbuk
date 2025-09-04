import 'package:e_commerce/ui/view/home_page/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/constant/app_image.dart';
import 'package:e_commerce/core/data/model/product_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: HomePageController()..fetchAllProducts(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(title: const Text("Thawbuk app"), centerTitle: true),

            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: const Text("bayan ghazi"),
                    accountEmail: const Text("bayanghazi@example.com"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage(Appimages.logo),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Home"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ شريط الفئات
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(controller.categories.length, (
                        index,
                      ) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ChoiceChip(
                            label: Text(controller.categories[index]),
                            selected: controller.selectedIndex == index,
                            onSelected: (value) {
                              controller.changeCategory(index);
                            },
                            selectedColor: Colors.blue,
                            labelStyle: TextStyle(
                              color: controller.selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ✅ المنتجات
                  Expanded(
                    child: controller.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : controller.products.isEmpty
                        ? const Center(child: Text("No products found"))
                        : ListView.builder(
                            itemCount: controller.products.length,
                            itemBuilder: (context, index) {
                              final Product product =
                                  controller.products[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name ?? "No Title",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "Category: ${product.categoryId ?? "N/A"}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child:
                                            product.images != null &&
                                                product.images!.isNotEmpty
                                            ? Image.network(
                                                product.images!.first,
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                Appimages.logo,
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
