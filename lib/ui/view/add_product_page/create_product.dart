import 'package:e_commerce/ui/view/authuntication/widget/text_Form_Field.dart';
import 'package:e_commerce/ui/view/add_product_page/create_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:e_commerce/core/data/repositories/product_repoitories.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();

  bool isLoading = false;

  // Future<void> _createProduct() async {
  //   if (formKey.currentState!.validate()) return;

  //   setState(() => isLoading = true);

  //   final product = Product(
  //     name: nameController.text,
  //     description: descriptionController.text,
  //     price: double.tryParse(priceController.text) ?? 0,

  //     categoryId: categoryIdController.text,
  //     images: [imageController.text],
  //   );

  //   final result = await ProductRepositories().createProduct(product);

  //   result.fold(
  //     (error) {
  //       Get.snackbar(
  //         "خطأ",
  //         error,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //       );
  //     },
  //     (newProduct) {
  //       Get.snackbar(
  //         "نجاح",
  //         "تم إنشاء المنتج: ${newProduct.name}",
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //       );
  //       Navigator.pop(context, newProduct);
  //     },
  //   );

  //   setState(() => isLoading = false);
  // }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
    return Scaffold(
      appBar: AppBar(title: const Text("إنشاء منتج جديد")),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text_Form_Custom(
                  controllerr: controller.categoryIdController,
                  validator: (value) =>
                      value!.isEmpty ? "   Please Enter  CategoryId" : null,
                  labelText: "CategoryId",
                ),
                SizedBox(height: 20),
                Text_Form_Custom(
                  controllerr: controller.nameController,
                  validator: (value) =>
                      value!.isEmpty ? "Please Enter product name" : null,
                  labelText: "name",
                ),
                SizedBox(height: 20),
                Text_Form_Custom(
                  controllerr: controller.priceController,
                  validator: (value) =>
                      value!.isEmpty ? "   Please Enter price product" : null,
                  labelText: "price",
                ),
                SizedBox(height: 20),
                Text_Form_Custom(
                  controllerr: controller.descriptionController,
                  validator: (value) => value!.isEmpty
                      ? "   Please Enter description product"
                      : null,
                  labelText: "description",
                ),
                SizedBox(height: 20),
                GetBuilder<CreateProductController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        controller.pickedImage.isNotEmpty
                            ? Image.file(
                                controller.pickedImage[0]!,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                            : Text("لم يتم اختيار صورة"),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () => controller.pickImages(),
                          icon: Icon(Icons.image),
                          label: Text("اختر صورة"),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 50),

                GetBuilder<CreateProductController>(
                  builder: (controller) {
                    return controller.isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton.icon(
                            onPressed: () => controller.createProduct(context),
                            icon: Icon(Icons.add),
                            label: Text("إنشاء المنتج"),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
