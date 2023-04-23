import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../page/home.dart';
import '../page/about.dart';
import '../page/news.dart';
import '../page/news_detail.dart';
import '../page/video.dart';
import '../page/discography.dart';
import '../page/contact.dart';
import '../page/store.dart';
import '../page/store_detail.dart';

Handler createBasicHandler(Widget targetWidget) {
  return Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return targetWidget;
  });
}

Handler newsPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return NewsDetail(params['newsId']!.first);
});

Handler storePageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return StoreDetail(params['goodsId']!.first);
});

class Routes {
  static void configureRoutes(FluroRouter router) {
    router
      ..define('/', handler: createBasicHandler(const RiLoI()))
      ..define('/about', handler: createBasicHandler(const About()))
      ..define('/news', handler: createBasicHandler(const News()))
      ..define('/news/:newsId', handler: newsPageHandler)
      ..define('/video', handler: createBasicHandler(const Video()))
      ..define('/discography', handler: createBasicHandler(const Discography()))
      ..define('/store', handler: createBasicHandler(const Store()))
      ..define('/store/:goodsId', handler: storePageHandler)
      ..define('/contact', handler: createBasicHandler(const Contact()))
      ..notFoundHandler = Handler(
          handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
              const NotFound());
  }
}

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("404 Not Found")),
    );
  }
}
