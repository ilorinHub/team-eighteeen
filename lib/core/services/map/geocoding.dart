import 'package:dio/dio.dart' as dio;

class GoogleGeoLocatingBaseApi {
  static Future<dynamic> getMapApiRequests(String url) async {
    try {
      final response = await dio.Dio().get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
