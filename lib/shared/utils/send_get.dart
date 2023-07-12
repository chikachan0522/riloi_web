import 'package:dio/dio.dart';

Future<Response> sendGetRequest(String url) async {
  var dio = Dio();

  Response response = await dio.get(
    url,
  );

  return response;
}
