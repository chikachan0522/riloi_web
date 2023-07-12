import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluro/fluro.dart';
import 'dart:math';

import 'package:riloi_web/app/app.dart';

import 'package:riloi_web/shared/widgets/onhover.dart';

import 'package:riloi_web/shared/widgets/background.dart';
import 'package:riloi_web/shared/widgets/actionbutton.dart';

class MainMenuContainer extends StatelessWidget {
  final String name;
  final Widget child;

  const MainMenuContainer({Key? key, required this.name, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RiloiWEB.router?.navigateTo(context, "/$name",
            transition: TransitionType.fadeIn,
            transitionDuration: const Duration(milliseconds: 180));
      },
      child: OnHover(
        child: Stack(
          children: [
            Hero(
              tag: "$name-background",
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).primaryColor.withOpacity(0.25)),
              ),
            ),
            Hero(
              tag: "$name-text",
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name.toUpperCase(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
            ),
            Hero(tag: "$name-image", child: child),
          ],
        ),
      ),
    );
  }
}

class RiLoI extends ConsumerStatefulWidget {
  const RiLoI({Key? key}) : super(key: key);

  @override
  ConsumerState<RiLoI> createState() => _RiLoIState();
}

class _RiLoIState extends ConsumerState<RiLoI> {
  int videoInt = Random().nextInt(videoList.length);
  int discographyInt = Random().nextInt(videoList.length);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int grid = size.height > size.width ? 1 : 2;

    double itemHeight = grid == 1 ? size.height / 8 : size.height / 5;
    double itemWidth = grid == 1 ? size.width : size.width / 2;

    return GestureDetector(
      child: Scaffold(
        body: Stack(
          children: [
            backGround(),
            // Ripple(offset),
            Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Center(
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.light
                        ? "assets/icons/Logo-black.webp"
                        : "assets/icons/Logo-white.webp",
                    height: itemHeight,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: itemWidth / itemHeight,
                  crossAxisCount: grid,
                  padding: const EdgeInsets.all(10),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    MainMenuContainer(
                      name: "about",
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                child: Image.asset(
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? "assets/icons/Riloi_black.webp"
                                      : "assets/icons/Riloi_white.webp",
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      ),
                    ),
                    MainMenuContainer(
                      name: "news",
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.newspaper,
                          size: itemHeight,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFF242424).withOpacity(0.8)
                                  : const Color(0xFFdbdbdb).withOpacity(0.8),
                        ),
                      ),
                    ),
                    MainMenuContainer(
                        name: "video",
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(videoList[videoInt][2]),
                            ),
                          ),
                        )),
                    MainMenuContainer(
                        name: "discography",
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                  discographyList[discographyInt][2]),
                            ),
                          ),
                        )),
                    MainMenuContainer(
                      name: "contact",
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Icon(
                            Icons.contact_mail,
                            size: itemHeight,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color(0xFF242424).withOpacity(0.8)
                                    : const Color(0xFFdbdbdb).withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                    MainMenuContainer(
                      name: "store",
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.store,
                          size: itemHeight,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFF242424).withOpacity(0.8)
                                  : const Color(0xFFdbdbdb).withOpacity(0.8),
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: const ActionButton(),
      ),
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
    "assets/video/Platform(β).webp",
    "https://www.youtube.com/watch?v=btssm3tPDOw",
    "2023-03-18"
  ]
];

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

List discographyList = singleList + albumList;
