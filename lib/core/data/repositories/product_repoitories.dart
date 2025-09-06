import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/data/model/common_response.dart';
import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:e_commerce/core/data/network/endpoint/end_point_category.dart';
import 'package:e_commerce/core/data/network/endpoint/end_point_product.dart';
import 'package:e_commerce/core/data/network/network_config.dart';
import 'package:e_commerce/core/enums/request_Type.dart';
import 'package:e_commerce/core/utils/network_utils.dart';

class ProductRepoitories {
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
          log('==========> $response');
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);

          if (commonResponse.getStatus) {
            final List productsJson =
                commonResponse.data!["body"]["data"]["products"];
            final products = productsJson
                .map((e) => Product.fromJson(e))
                .toList();
            return Right(products);
          } else {
            return Left(commonResponse.message ?? 'حدث خطأ ما');
          }
        } else {
          return Left('Please check your internet');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Product>> getSingleProduct(String productId) async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: EndPointProduct.product,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
        params: {"productId": productId}, // ممكن يكون غير ضروري حسب الـ API
      );

      if (response == null) {
        return Left('Please check your internet');
      }

      log("Full response: $response");

      final commonResponse = CommonResponse<Map<String, dynamic>>.fromJson(
        response,
      );

      final productsJson =
          commonResponse.data?["body"]?["data"]?["products"] as List?;
      if (productsJson == null || productsJson.isEmpty) {
        return Left("Products list is empty");
      }

      final productJson = productsJson.firstWhere(
        (p) => p["_id"] == productId,
        orElse: () => null,
      );

      if (productJson == null)
        return Left("Product not found with id: $productId");

      final product = Product.fromJson(productJson);
      return Right(product);
    } catch (e) {
      return Left(e.toString());
    }
  }

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
          log('==========> $response');
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);

          if (commonResponse.getStatus) {
            final List productsJson = commonResponse.data!["body"]["products"];
            final products = productsJson
                .map((e) => Product.fromJson(e))
                .toList();
            return Right(products);
          } else {
            return Left(commonResponse.message ?? 'حدث خطأ ما');
          }
        } else {
          return Left('Please check your internet');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
