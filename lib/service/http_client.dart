import 'http_service.dart';
class HttpClient {
  static HttpService httpService;
  static getInstance() {
    if (httpService == null) {
      httpService = new HttpService();
    }
    return httpService;
  }
}
