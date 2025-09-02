import 'package:e_commerce/core/enums/request_Type.dart';

class NetworkConfig {
  static String baseApi = 'api/';

  static String getFullApiRout(String apirout) {
    return baseApi + apirout;
  }

  static Map<String, String> getHeaders({
    bool? needAuth = true,
    required RequestType type,
    Map<String, String>? extraHeaders,
  }) {
    return {
      // if (needAuth!) "Authorization": "Bearer ${storage.getTokenInfo}",
      if (type != RequestType.GET)
        'Content-type': 'application/json; charset=UTF-8',
      ...extraHeaders ?? {},
    };
  }
}
