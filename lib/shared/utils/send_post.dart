import 'package:dio/dio.dart';

Future<Response> sendPostRequest(String url, Map<String, dynamic> data) async {
  var dio = Dio();
  dio.options.extra['withCredentials'] = true;

  Response response = await dio.post(
    url,
    data: data,
  );

  return response;
}
