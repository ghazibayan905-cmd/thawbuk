import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/data/model/common_response.dart';
import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:e_commerce/core/data/network/endpoint/end_point_product.dart';
import 'package:e_commerce/core/data/network/network_config.dart';
import 'package:e_commerce/core/enums/request_Type.dart';
import 'package:e_commerce/core/utils/network_utils.dart';

class ProductRepositories {
  /// 🔹 جلب جميع المنتجات
  Future<Either<String, List<Product>>> getAllProducts() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: EndPointProduct.product,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
      ).then((response) {
        if (response != null) {
          log('getAllProducts response: $response');
          final commonResponse = CommonResponse<Map<String, dynamic>>.fromJson(
            response,
          );

          if (commonResponse.getStatus) {
            final List productsJson =
                commonResponse.data?["body"]["data"]['products'] ?? [];
            List<Product> products = productsJson
                .map((e) => Product.fromJson(e))
                .toList();

            return Right(products);
          } else {
            return Left(commonResponse.message ?? 'حدث خطأ ما');
          }
        } else {
          return Left('Please check your internet connection');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// 🔹 جلب منتج واحد بالـ id
  Future<Either<String, Product>> getSingleProduct(String productId) async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: "${EndPointProduct.product}/$productId",
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
      );

      if (response == null) {
        return Left('Please check your internet connection');
      }

      log("getSingleProduct response: $response");

      final commonResponse = CommonResponse<Map<String, dynamic>>.fromJson(
        response,
      );

      final productJson = commonResponse.data?["body"]["data"];
      if (productJson == null) {
        return Left("Product not found with id: $productId");
      }

      final product = Product.fromJson(productJson);
      return Right(product);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// 🔹 جلب المنتجات حسب التصنيف
  Future<Either<String, List<Product>>> getProductByCategory(
    String categoryId,
  ) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: "${EndPointProduct.productbyCategory}/$categoryId",
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
      ).then((response) {
        if (response != null) {
          log('getProductByCategory response: $response');
          final commonResponse = CommonResponse<Map<String, dynamic>>.fromJson(
            response,
          );

          if (commonResponse.getStatus) {
            final List productsJson =
                commonResponse.data?["body"]?["products"] ?? [];
            final products = productsJson
                .map((e) => Product.fromJson(e))
                .toList();
            return Right(products.cast<Product>());
          } else {
            return Left(commonResponse.message ?? 'حدث خطأ ما');
          }
        } else {
          return Left('Please check your internet connection');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// 🔹 إنشاء منتج جديد
  Future<Either<String, Product>> createProduct(Product product) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST, // ✅ لازم POST مش GET
        url: EndPointProduct.createProduct,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.POST,
        ),
        fields: {
          'categoryId': product.categoryId.toString(),
          'name': product.name.toString(),
          'price': product.price!.toString(),
          'description': product.description.toString(),
        },
        // files: product.images == null ? null : {'images': product.images!},
      ).then((response) {
        if (response != null) {
          log('createProduct response: $response');
          final commonResponse = CommonResponse<Map<String, dynamic>>.fromJson(
            response,
          );

          if (commonResponse.getStatus) {
            final productJson = commonResponse.data?["body"]?["product"];
            final newProduct = Product.fromJson(productJson);
            return Right(newProduct);
          } else {
            return Left(commonResponse.message ?? 'حدث خطأ ما');
          }
        } else {
          return Left('Please check your internet connection');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
