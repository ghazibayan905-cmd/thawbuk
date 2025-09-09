import 'package:e_commerce/core/enums/request_Type.dart';

class NetworkConfig {
  static String baseApi = 'api/';
  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFmNGNmNWNmLWYxN2YtNGNkNy1iMzRlLThkOWQyYjg3MGMzZCIsImVtYWlsIjoiYmF5YW5naGF6aTE1OUBnbWFpbC5jb20iLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3NTc0MDM5NDEsImV4cCI6MTc1ODAwODc0MX0.JjbzQ7AIIX4CVJMPD1I2IGcg2BBwqhboB4mVXDYriwk';

  static String getFullApiRout(String apirout) {
    return baseApi + apirout;
  }

  static Map<String, String> getHeaders({
    bool? needAuth = true,
    required RequestType type,
    Map<String, String>? extraHeaders,
  }) {
    return {
      if (needAuth!) "Authorization": "Bearer $token",
      if (type != RequestType.GET)
        'Content-type': 'application/json; charset=UTF-8',
      ...extraHeaders ?? {},
    };
  }
}
