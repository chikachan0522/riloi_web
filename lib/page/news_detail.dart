import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:riloi_web/shared/widgets/widgets.dart';
import 'package:riloi_web/shared/utils/send_get.dart';

class NewsDetail extends StatefulWidget {
  final String newsId;
  const NewsDetail(this.newsId, {super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  List news = [
    "0_id",
    "1_head",
    "2_body",
    "3_created",
    "4_updated",
    "5_created_userid"
  ];

  Future getNewsOne(String id) async {
    try {
      Response response =
          await sendGetRequest("https://api.riloi.com/get_news?id=$id");
      setState(() {
        news = response.data["news"];
      });
    } catch (e) {}
  }

  @override
  void initState() {
    getNewsOne(widget.newsId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 18) {
          Navigator.pop(context);
        }
      },
      child: Builder(builder: (context) {
        return Stack(
          children: [
            backGround(),
            Hero(
                tag: "news-background",
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.8)),
                      color: Theme.of(context).primaryColor.withOpacity(0.4)),
                )),
            Scaffold(
              backgroundColor: const Color(0x00000000),
              body: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.8)),
                      color: Theme.of(context).primaryColor.withOpacity(0.25)),
                  child: Column(children: [
                    Text(
                      "NEWS",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            news[3],
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          news[1],
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ),
                    Flexible(
                        child: Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      child: Text(
                        news[2],
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ))
                  ]),
                ),
                const backButton()
              ]),
              floatingActionButton: const ActionButton(),
            ),
          ],
        );
      }),
    );
  }
}
