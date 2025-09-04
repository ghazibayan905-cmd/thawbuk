import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/data/model/common_response.dart';
import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:e_commerce/core/data/network/endpoint/auth_endpoint.dart';
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
          // استخرج المنتجات
          final List productsJson = commonResponse.data!["body"]["data"]["products"];
          final products = productsJson.map((e) => Product.fromJson(e)).toList();
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
