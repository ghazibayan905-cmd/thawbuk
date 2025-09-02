import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce/core/enums/request_Type.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  static String host = 'thawbuk-store.vercel.app';
  static var client = http.Client();

  // static String baseUrl = 'hill-thundering-approval.glitch.me';
  // حتى استطيع ارسال واصتقبال الطلبات من ال http يجب ان اهيأ متغير من نوع client

  static Future<dynamic> sendRequest({
    required RequestType type,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    try {
      //!--- Required for request ----
      //*--- Make full api url ------
      var uri = Uri.https(host, url, params);
      log('==========> $uri');

      log('==========> $body');
      //?--- To Save api response ----
      late http.Response
      response; // حتى يتم استقبال البيانات من http ويتم تاخير تعريفه حتى يتم طلبه
      //?--- To Save api status code ----

      //!--- Required convert api response to Map ----
      Map<String, dynamic> jsonResponse = {};
      //*--- Make call correct request type ------
      switch (type) {
        case RequestType.GET:
          response = await client
              .get(uri, headers: headers)
              .timeout(
                const Duration(seconds: 15),
                onTimeout: () {
                  return response;
                },
              );
          break;
        case RequestType.POST:
          response = await client
              .post(uri, body: jsonEncode(body), headers: headers)
              .timeout(
                const Duration(seconds: 15),
                onTimeout: () {
                  return response;
                },
              );
          break;
        case RequestType.PUT:
          response = await client
              .put(uri, body: jsonEncode(body), headers: headers)
              .timeout(
                const Duration(seconds: 15),
                onTimeout: () {
                  return response;
                },
              );

          break;
        case RequestType.DELETE:
          response = await client.delete(
            uri,
            body: jsonEncode(body),
            headers: headers,
          );
          break;
        case RequestType.MULTIPART:
          // TODO: Handle this case.
          break;
      }

      dynamic result;

      try {
        result = jsonDecode(const Utf8Codec().decode(response.bodyBytes));
      } catch (e) {
        e;
      }

      jsonResponse.putIfAbsent(
        'response',
        () => result == null
            ? jsonDecode(
                jsonEncode({
                  'title': const Utf8Codec().decode(response.bodyBytes),
                }),
              )
            : jsonDecode(const Utf8Codec().decode(response.bodyBytes)),
      );
      jsonResponse.putIfAbsent('statusCode', () => response.statusCode);

      log(jsonResponse.toString());

      return jsonResponse;
    } catch (e) {
      print(e);
      (e);
    }
  }
}
