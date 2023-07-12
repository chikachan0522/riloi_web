import 'package:flutter/material.dart';
import 'package:riloi_web/shared/widgets/widgets.dart';
import 'package:riloi_web/shared/utils/send_get.dart';
import 'package:riloi_web/app/app.dart';
import 'package:dio/dio.dart';

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
      Response response = await sendGetRequest(
        "https://api.riloi.com/get_news_list?sort=$isSelectedItem&limit=6&important=${filters.contains("重要")}&new_song=${filters.contains("新曲")}&live=${filters.contains("ライブ")}&movie=${filters.contains("ムービー")}",
      );
      setState(() {
        isError = false;
        items = response.data["news"];
        tags = response.data["tags"];
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
      child: Stack(
        children: [
          backGround(),
          Hero(
              tag: "news-background",
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.8)),
                    color: Theme.of(context).primaryColor.withOpacity(0.4)),
              )),
          Scaffold(
            backgroundColor: const Color(0x00FFFFFF),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.35),
                  leading: const backButton(),
                  pinned: true,
                  title: Hero(
                    tag: "news-text",
                    child: Text(
                      "NEWS",
                      style: Theme.of(context).textTheme.displaySmall,
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
                          return FilterChip(
                              label: Text(e),
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.white,
                              selected: filters.contains(e),
                              showCheckmark: false,
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
                          style: Theme.of(context).textTheme.titleLarge,
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
                                                  .headlineSmall,
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
                                                        .labelSmall,
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
                                                .headlineMedium,
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
            floatingActionButton: const ActionButton(),
          ),
        ],
      ),
    );
  }
}
