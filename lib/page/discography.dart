// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:riloi_web/shared/widgets/widgets.dart';

class Discography extends StatelessWidget {
  const Discography({super.key});

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    // int grid = size.height > size.width ? 1 : 2;
    return Stack(
      children: [
        backGround(),
        Hero(
            tag: "discography-background",
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.8)),
                  color: Theme.of(context).primaryColor.withOpacity(0.4)),
            )),
        Scaffold(
          backgroundColor: const Color(0x00000000),
          body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.35),
                  pinned: true,
                  leading: const backButton(),
                  title: Hero(
                      tag: "discography-text",
                      child: Text(
                        "DISCOGRAPHY",
                        style: Theme.of(context).textTheme.displaySmall,
                      )),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    "ALBUM",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                SliverGrid.extent(
                  childAspectRatio: 350 / 390,
                  maxCrossAxisExtent: 350,
                  children: albumList.map((e) {
                    return GestureDetector(
                      onTap: () => html.window.open(e[3], ""),
                      child: OnHover(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).cardColor,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(e[2]),
                                  ),
                                ),
                                const Spacer(),
                                Text(e[1]),
                                const Spacer()
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    "SINGLE",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                SliverGrid.extent(
                  childAspectRatio: 350 / 390,
                  maxCrossAxisExtent: 350,
                  children: singleList.map((e) {
                    return GestureDetector(
                      onTap: () => html.window.open(e[3], ""),
                      child: OnHover(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).cardColor,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(e[2]),
                                  ),
                                ),
                                const Spacer(),
                                Text(e[1]),
                                const Spacer()
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ]),
        ),
      ],
    );
  }
}

List albumList = [
  [
    1,
    "パキラ/エコーチェンバー",
    "assets/discography/pakira-eco-chenba-.webp",
    "https://big-up.style/musics/482727",
    "2022-02-07",
    "album"
  ],
];

List singleList = [
  [
    0,
    "Kalmia",
    "assets/discography/kalmia.webp",
    "https://big-up.style/musics/475026",
    "2021-09-05",
    "single"
  ],
  [
    2,
    "リグレット",
    "assets/discography/regret.webp",
    "https://big-up.style/musics/491968",
    "2022-04-27",
    "single"
  ],
  [
    3,
    "ミモザブローチ",
    "assets/discography/mimozaburo-chi.webp",
    "https://big-up.style/musics/504759",
    "2022-07-04",
    "single"
  ],
  [
    4,
    "プラットフォーム(β)",
    "assets/discography/Platform(β).webp",
    "https://big-up.style/musics/536287",
    "2023-03-18",
    "single"
  ]
];
