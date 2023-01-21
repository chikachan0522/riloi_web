import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluro/fluro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:html' as html;

void main() {
  setUrlStrategy(PathUrlStrategy());
  final router = FluroRouter();
  Routes.configureRoutes(router);
  RiloiWEB.router = router;
  runApp(const ProviderScope(child: RiloiWEB()));
}

final isLight = StateProvider((_) => ThemeMode.system);

class RiloiWEB extends ConsumerWidget {
  static FluroRouter? router;
  const RiloiWEB({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: "リロイ/ЯiLoI | オフィシャルサイト",
      home: const RiLoI(),
      initialRoute: '/',
      onGenerateRoute: router?.generator,
      color: Colors.white,
      theme: ThemeData.light().copyWith(
          brightness: Brightness.light,
          primaryColor: const Color(0xFFdbdbdb),
          backgroundColor: const Color(0xFFFFFFFF),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Theme.of(context).primaryColor),
          textTheme: GoogleFonts.kosugiTextTheme(ThemeData.light().textTheme)),
      darkTheme: ThemeData.dark().copyWith(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF242424),
          backgroundColor: const Color(0xFF000000),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Theme.of(context).primaryColor),
          textTheme: GoogleFonts.kosugiTextTheme(ThemeData.dark().textTheme)),
      themeMode: ref.watch(isLight),
    );
  }
}

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

class Routes {
  static void configureRoutes(FluroRouter router) {
    router
      ..define('/', handler: createBasicHandler(const RiLoI()))
      ..define('/about', handler: createBasicHandler(const About()))
      ..define('/news', handler: createBasicHandler(const News()))
      ..define('/news/:newsId', handler: newsPageHandler)
      ..define('/video', handler: createBasicHandler(const Video()))
      ..define('/discography', handler: createBasicHandler(const Discography()))
      ..define('/request', handler: createBasicHandler(const Request()))
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

List videoList = [
  [
    0,
    "Kalmia",
    "lib/assets/video/kalmia.webp",
    "https://www.youtube.com/watch?v=td3tKQ0dd2g",
    "2021-09-05"
  ],
  [
    1,
    "パキラ",
    "lib/assets/video/pakira.webp",
    "https://www.youtube.com/watch?v=5pHg5bTX1w0",
    "2022-02-07"
  ],
  [
    2,
    "リグレット",
    "lib/assets/video/regret.webp",
    "https://www.youtube.com/watch?v=ADp_kabh0ng",
    "2022-04-27"
  ],
  [
    3,
    "ミモザブローチ",
    "lib/assets/video/mimozaburo-chi.webp",
    "https://www.youtube.com/watch?v=ij_EbMGiq60",
    "2022-07-04"
  ]
];

List albumList = [
  [
    1,
    "パキラ/エコーチェンバー",
    "lib/assets/discography/pakira-eco-chenba-.webp",
    "https://big-up.style/musics/482727",
    "2022-02-07",
    "album"
  ],
];

List singleList = [
  [
    0,
    "Kalmia",
    "lib/assets/discography/kalmia.webp",
    "https://big-up.style/musics/475026",
    "2021-09-05",
    "single"
  ],
  [
    2,
    "リグレット",
    "lib/assets/discography/regret.webp",
    "https://big-up.style/musics/491968",
    "2022-04-27",
    "single"
  ],
  [
    3,
    "ミモザブローチ",
    "lib/assets/discography/mimozaburo-chi.webp",
    "https://big-up.style/musics/504759",
    "2022-07-04",
    "single"
  ]
];

List discographyList = singleList + albumList;

class RipplePainter extends CustomPainter {
  RipplePainter({required this.offset});
  final Offset offset;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke // 図形をぬりつずつかどうか
      ..color = Colors.blue // 色の指定
      ..strokeWidth = 2; // 線の太さの指定
    canvas.drawCircle(offset, 100, paint); // 位置と輪っかの大きさを指定
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OnHover extends StatefulWidget {
  final Widget child;
  const OnHover({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<OnHover> createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..translate(0, -8, 0);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: AnimatedContainer(
        duration: const Duration(microseconds: 200),
        transform: transform,
        child: widget.child,
      ),
    );
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}

class MainMenuContainer extends StatefulWidget {
  final String name;
  final Widget child;

  const MainMenuContainer({Key? key, required this.name, required this.child})
      : super(key: key);

  @override
  State<MainMenuContainer> createState() => _MainMenuContainerState();
}

class _MainMenuContainerState extends State<MainMenuContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RiloiWEB.router?.navigateTo(context, "/${widget.name}");
      },
      child: OnHover(
        child: Stack(
          children: [
            Hero(
              tag: "${widget.name}-background",
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Hero(
              tag: "${widget.name}-text",
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.name.toUpperCase(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
            Hero(tag: "${widget.name}-image", child: widget.child),
          ],
        ),
      ),
    );
  }
}

class RiLoI extends ConsumerStatefulWidget {
  const RiLoI({super.key});

  @override
  _RiLoIState createState() => _RiLoIState();
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

    BoxDecoration homeGridDecoration = BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(12),
    );

    // Offset offset = Offset(0, 0);

    // void ripplePointer(TapDownDetails details) {
    //   setState(() {
    //     offset = details.globalPosition;
    //     print(details.globalPosition);
    //   });
    // }

    // Widget Ripple(Offset offset) {
    //   return offset != Offset(0, 0)
    //       ? CustomPaint(painter: RipplePainter(offset: offset))
    //       : SizedBox();
    // }

    return GestureDetector(
      // onTapDown: ripplePointer,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: [
            // Ripple(offset),
            Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Center(
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.light
                        ? "lib/assets/icons/Logo-black.webp"
                        : "lib/assets/icons/Logo-white.webp",
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
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    MainMenuContainer(
                      name: "about",
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              Theme.of(context).brightness == Brightness.light
                                  ? "lib/assets/icons/Riloi-black.webp"
                                  : "lib/assets/icons/Riloi-white.webp",
                            )),
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
                                  ? const Color(0xFF242424)
                                  : const Color(0xFFdbdbdb),
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
                                    ? const Color(0xFF242424)
                                    : const Color(0xFFdbdbdb),
                          ),
                        ),
                      ),
                    ),
                    MainMenuContainer(
                      name: "request",
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.request_page,
                          size: itemHeight,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFF242424)
                                  : const Color(0xFFdbdbdb),
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

class ActionButton extends ConsumerWidget {
  const ActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        if (Theme.of(context).brightness == Brightness.light) {
          ref.read(isLight.notifier).state = ThemeMode.dark;
        } else {
          ref.read(isLight.notifier).state = ThemeMode.light;
        }
      },
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF242424)
          : const Color(0xFFdbdbdb),
      child: Icon(
          Theme.of(context).brightness == Brightness.light
              ? Icons.mode_night
              : Icons.light_mode,
          color: Theme.of(context).brightness == Brightness.light
              ? const Color(0xFFdbdbdb)
              : const Color(0xFF242424)),
    );
  }
}

Widget backButton(BuildContext context) {
  return Align(
    alignment: Alignment.topLeft,
    child: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back),
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white,
      padding: const EdgeInsets.all(18.0),
    ),
  );
}

class About extends StatelessWidget {
  const About({super.key});

  final String about = """
リロイと申します。

14 ♂
ボカロP / 作曲家
GarageBand
mobile Vocaloid editor

作詞 作曲 / ЯiLoI
映像 • ロゴデザイン 制作 / AteLiЯ - アトリエ
字幕制作 / @chikachan_0522 様
アーティスト写真/ノーコピーライトガール 様
""";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int grid = size.height > size.width ? 1 : 2;
    return grid == 1 ? _verticalLayout(context) : _horizontalLayout(context);
  }

  Widget _verticalLayout(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 18) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Hero(
              tag: "about-background",
              child: Container(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Column(
              children: [
                Hero(
                  tag: "about-image",
                  child: Center(
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.light
                          ? "lib/assets/icons/Riloi-black.webp"
                          : "lib/assets/icons/Riloi-white.webp",
                      height: size.height / 2,
                    ),
                  ),
                ),
                Hero(
                  tag: "about-text",
                  child: Text(
                    "ABOUT",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                const Spacer(),
                Text(
                  about,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
            backButton(context)
          ],
        ),
        floatingActionButton: const ActionButton(),
      ),
    );
  }

  Widget _horizontalLayout(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: "about-background",
            child: Container(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Hero(
                  tag: "about-image",
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.light
                          ? "lib/assets/icons/Riloi-black.webp"
                          : "lib/assets/icons/Riloi-white.webp",
                      width: size.width / 2,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width / 2.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      Hero(
                        tag: "about-text",
                        child: Text(
                          "ABOUT",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        about,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const Spacer(
                        flex: 2,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          backButton(context)
        ],
      ),
      floatingActionButton: const ActionButton(),
    );
  }
}

class News extends StatefulWidget {
  const News({super.key});
  static List tags = ["重要", "新曲", "ライブ", "ムービー"];
  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  List filters = ["重要", "新曲", "ライブ", "ムービー"];
  List items = [];
  Map tags = {};
  String? isSelectedItem = 'DESC';
  bool isError = false;

  Future getData() async {
    try {
      http.Response response = await http.get(
        Uri.https("api.riloi.com", "/get_news_list", {
          "sort": isSelectedItem.toString(),
          "limit": "6",
          "important": "${filters.contains("重要")}",
          "new_song": "${filters.contains("新曲")}",
          "live": "${filters.contains("ライブ")}",
          "movie": "${filters.contains("ムービー")}",
        }),
      );
      setState(() {
        isError = false;
        items = jsonDecode(utf8.decode(response.bodyBytes))["news"];
        tags = jsonDecode(utf8.decode(response.bodyBytes))["tags"];
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState;

    getData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int grid = size.width < 700 ? 1 : 2;
    double itemWidth = grid == 1 ? size.width : size.width / 2;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 18) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Hero(
                tag: "news-background",
                child: Container(
                  color: Theme.of(context).primaryColor,
                )),
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  leading: backButton(context),
                  pinned: true,
                  title: Hero(
                    tag: "news-text",
                    child: Text(
                      "NEWS",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton(
                            items: const [
                              DropdownMenuItem(
                                value: "DESC",
                                child: Text("newer"),
                              ),
                              DropdownMenuItem(
                                value: "ASC",
                                child: Text("older"),
                              )
                            ],
                            onChanged: (value) {
                              setState(() {
                                isSelectedItem = value;
                                getData();
                              });
                            },
                            value: isSelectedItem,
                          ),
                        ],
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 12,
                        direction: Axis.horizontal,
                        children: News.tags.map((e) {
                          return ChoiceChip(
                              label: Text(e),
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.white,
                              selected: filters.contains(e),
                              onSelected: (val) {
                                setState(() {
                                  if (val) {
                                    filters.add(e);
                                    getData();
                                  } else {
                                    filters.removeWhere((name) => name == e);
                                    getData();
                                  }
                                });
                              });
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                isError
                    ? Center(
                        child: Text(
                          "ニュースの取得に失敗しました。\n後でもう一度お試しください。",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )
                    : SliverGrid.count(
                        crossAxisCount: grid,
                        childAspectRatio: itemWidth / 101,
                        children: items.map(
                          (value) {
                            List tagList = tags[value[0].toString()];
                            return GestureDetector(
                              onTap: () {
                                RiloiWEB.router
                                    ?.navigateTo(context, '/news/${value[0]}');
                              },
                              child: OnHover(
                                child: Card(
                                  margin: const EdgeInsets.all(8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              value[3],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                            Wrap(
                                                children: tagList.map((e) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Chip(
                                                  label: Text(
                                                    e,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .overline,
                                                  ),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  labelPadding: const EdgeInsets
                                                      .symmetric(horizontal: 1),
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal: 0.0,
                                                          vertical: -4),
                                                ),
                                              );
                                            }).toList())
                                          ],
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            value[1],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      )
              ],
            ),
          ],
        ),
        floatingActionButton: const ActionButton(),
      ),
    );
  }
}

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
      http.Response response =
          await http.get(Uri.https("api.riloi.com", "/get_news", {"id": id}));
      setState(() {
        news = jsonDecode(utf8.decode(response.bodyBytes))["news"][0];
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
      child: Scaffold(
        body: Stack(children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: Column(children: [
              Text(
                "NEWS",
                style: Theme.of(context).textTheme.headline3,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      news[3],
                      style: Theme.of(context).textTheme.headline6,
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
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              Flexible(
                  child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                child: Text(
                  news[2],
                  style: Theme.of(context).textTheme.headline5,
                ),
              ))
            ]),
          ),
          backButton(context)
        ]),
        floatingActionButton: const ActionButton(),
      ),
    );
  }
}

class Video extends StatelessWidget {
  const Video({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int grid = size.width < 700 ? 1 : 2;
    double itemWidth = grid == 1 ? size.width : size.width / 2;
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 18) {
            Navigator.pop(context);
          }
        },
        child: Container(
          color: Theme.of(context).primaryColor,
          child: CustomScrollView(slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              pinned: true,
              leading: backButton(context),
              title: Hero(
                tag: "video-text",
                child: Text(
                  "VIDEO",
                  style: Theme.of(context).textTheme.headline3,
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
      ),
      floatingActionButton: const ActionButton(),
    );
  }
}

class Discography extends StatelessWidget {
  const Discography({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int grid = size.height > size.width ? 1 : 2;
    return Scaffold(
      body: Stack(children: [
        Hero(
            tag: "discography-background",
            child: Container(
              color: Theme.of(context).primaryColor,
            )),
        CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            pinned: true,
            leading: backButton(context),
            title: Hero(
                tag: "discography-text",
                child: Text(
                  "DISCOGRAPHY",
                  style: Theme.of(context).textTheme.headline3,
                )),
          ),
          SliverToBoxAdapter(
            child: Text(
              "ALBUM",
              style: Theme.of(context).textTheme.headline4,
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
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
              style: Theme.of(context).textTheme.headline4,
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
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
      ]),
    );
  }
}

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // int grid = size.height > size.width ? 1 : 2;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 18) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Hero(
                tag: "contact-background",
                child: Container(
                  color: Theme.of(context).primaryColor,
                )),
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  leading: backButton(context),
                  backgroundColor: Theme.of(context).primaryColor,
                  title: Hero(
                    tag: "contact-text",
                    child: Text(
                      "CONTACT",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("コンタクトフォームは現在作成中です。"),
                      Text("お急ぎの場合はcontact@riloi.comまでご連絡ください。")
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        floatingActionButton: const ActionButton(),
      ),
    );
  }
}

class Request extends StatelessWidget {
  const Request({super.key});

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    // int grid = size.height > size.width ? 1 : 2;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 18) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Hero(
              tag: "request-background",
              child: Container(
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Center(
              child: Text("申し訳ありませんが現在楽曲依頼を受け付けていません。"),
            ),
            backButton(context)
          ],
        ),
        floatingActionButton: const ActionButton(),
      ),
    );
  }
}
