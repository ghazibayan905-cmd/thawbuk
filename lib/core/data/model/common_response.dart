class CommonResponse<T> {
  int? statusCode;
  T? data;
  String? message;

  CommonResponse.fromJson(dynamic json) {
    this.statusCode = json['statusCode'];
    if (statusCode.toString().startsWith('2')) {
      this.data = json['response'];
    } else {
      if (json['response'] != null &&
          json['response'] is Map &&
          json['response']['message'] != null) {
        this.message = json['response']['message'];
      } else {
        switch (statusCode) {
          case 400:
            this.message = '400 Bad Request';
            break;
          case 401:
            this.message = '400 UnAuthorized';
            break;
          case 404:
            this.message = '400 Not Found';
            break;
          case 501:
            this.message = '400 Internal Server error';
            break;
          case 503:
            this.message = '400 Server unvalibale';
            break;
          case 500:
            this.message = '500 Server unvalibale';
            break;
        }
      }
    }
  }

  bool get getStatus => statusCode.toString().startsWith('2') ? true : false;
  // bool get getStatus=> statusCode==200?true :false;
}
