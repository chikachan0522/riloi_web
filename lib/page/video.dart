// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:riloi_web/shared/widgets/widgets.dart';

class Video extends StatelessWidget {
  const Video({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int grid = size.width < 700 ? 1 : 2;
    double itemWidth = grid == 1 ? size.width : size.width / 2;
    return Stack(
      children: [
        backGround(),
        Hero(
            tag: "video-background",
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.8)),
                  color: Theme.of(context).primaryColor.withOpacity(0.4)),
            )),
        Scaffold(
          backgroundColor: const Color(0x00000000),
          body: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 18) {
                Navigator.pop(context);
              }
            },
            child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    centerTitle: true,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.35),
                    pinned: true,
                    leading: const backButton(),
                    title: Hero(
                      tag: "video-text",
                      child: Text(
                        "VIDEO",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                  SliverGrid.count(
                    crossAxisCount: grid,
                    childAspectRatio: itemWidth / 120,
                    children: videoList.map((e) {
                      return GestureDetector(
                        onTap: () {
                          html.window.open(e[3], "");
                        },
                        child: OnHover(
                            child: Card(
                          margin: const EdgeInsets.all(8),
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  e[2],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e[1]),
                            )
                          ]),
                        )),
                      );
                    }).toList(),
                  )
                ]),
          ),
          floatingActionButton: const ActionButton(),
        ),
      ],
    );
  }
}

List videoList = [
  [
    0,
    "Kalmia",
    "assets/video/kalmia.webp",
    "https://www.youtube.com/watch?v=td3tKQ0dd2g",
    "2021-09-05"
  ],
  [
    1,
    "パキラ",
    "assets/video/pakira.webp",
    "https://www.youtube.com/watch?v=5pHg5bTX1w0",
    "2022-02-07"
  ],
  [
    2,
    "リグレット",
    "assets/video/regret.webp",
    "https://www.youtube.com/watch?v=ADp_kabh0ng",
    "2022-04-27"
  ],
  [
    3,
    "ミモザブローチ",
    "assets/video/mimozaburo-chi.webp",
    "https://www.youtube.com/watch?v=ij_EbMGiq60",
    "2022-07-04"
  ],
  [
    4,
    "プラットフォーム(β)",
    "assets/video/platform(β).webp",
    "https://www.youtube.com/watch?v=btssm3tPDOw",
    "2023-03-18"
  ]
];
