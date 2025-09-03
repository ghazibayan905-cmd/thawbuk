import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/data/dto/auth_dto.dart';
import 'package:e_commerce/core/data/model/common_response.dart';
import 'package:e_commerce/core/data/network/endpoint/auth_endpoint.dart';
import 'package:e_commerce/core/data/network/network_config.dart';
import 'package:e_commerce/core/enums/request_Type.dart';
import 'package:e_commerce/core/utils/network_utils.dart';

class AuthRepository {
  Future<Either<String, String>> signUp({required SignUpDto signUpDto}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: AuthEndPoint.signUp,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: signUpDto.toJson(),
      ).then((response) {
        if (response != null) {
          log('==========> ${response}');
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            return Right(commonResponse.data!['message']);
          } else {
            return Left(commonResponse.message ?? '');
          }
        } else {
          return Left('Please check your internet');
        }
      });
    } catch (e) {
      return Left(e.toString());
      // return Left('Please check your internet');
    }
  }

  Future<Either<String, String>> logIn({required LoginDto loginDto}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: AuthEndPoint.login,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: loginDto.toJson(),
      ).then((response) {
        if (response != null) {
          log('==========> ${response}');
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            return Right(commonResponse.data!['message']);
          } else {
            return Left(commonResponse.message ?? '');
          }
        } else {
          return Left('Please check your internet');
        }
      });
    } catch (e) {
      return Left(e.toString());
      // return Left('Please check your internet');
    }
  }

  Future<Either<String, String>> verifyEmail({
    required String code,
    required String email,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: AuthEndPoint.verifyEmail,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: {'code': code, 'email': email},
      ).then((response) {
        if (response != null) {
          log('==========> $response');
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            return Right(commonResponse.data!['message']);
          } else {
            return Left(commonResponse.message ?? '');
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
