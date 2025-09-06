import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/data/model/category_model.dart';
import 'package:e_commerce/core/data/model/common_response.dart';
import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:e_commerce/core/data/network/endpoint/end_point_category.dart';
import 'package:e_commerce/core/data/network/network_config.dart';
import 'package:e_commerce/core/enums/request_Type.dart';
import 'package:e_commerce/core/utils/network_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';

class CategoryRepositories {
  Future<Either<String, List<Categories>>> getAllCategory() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: EndPointCategory.categories,
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
            print(commonResponse.data.runtimeType); // 👈 اطبع نوع البيانات
            print(commonResponse.data); // 👈 اطبع محتوى response

            final List categoriesJson = commonResponse.data!["body"]["data"];

            final category = categoriesJson
                .map((e) => Categories.fromJson(e))
                .toList();
            return Right(category);
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

  Future<Either<String, Categories>> getCategoryDetails(
    String categoryId,
  ) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: "${EndPointCategory.categories}/$categoryId",
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
      ).then((response) {
        if (response != null) {
          log("==== API RESPONSE ====> $response");

          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);

          if (commonResponse.getStatus) {
            final data = commonResponse.data?["body"]?["data"];
            if (data == null) {
              return Left("Category data not found in response");
            }

            final category = Categories.fromJson(data as Map<String, dynamic>);

            return Right(category);
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
