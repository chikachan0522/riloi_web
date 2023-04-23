import 'package:flutter/material.dart';

import 'package:riloi_web/shared/widgets/widgets.dart';

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
            backGround(),
            Hero(
              tag: "about-background",
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.8)),
                    color: Theme.of(context).primaryColor.withOpacity(0.25)),
              ),
            ),
            Column(
              children: [
                Hero(
                  tag: "about-image",
                  child: Center(
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.light
                          ? "assets/icons/Riloi_black.webp"
                          : "assets/icons/Riloi_white.webp",
                      height: size.height / 2,
                    ),
                  ),
                ),
                Hero(
                  tag: "about-text",
                  child: Text(
                    "ABOUT",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const Spacer(),
                Text(
                  about,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
            const backButton()
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
          backGround(),
          Hero(
            tag: "about-background",
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.8)),
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withOpacity(0.25)),
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
                          ? "assets/icons/Riloi_black.webp"
                          : "assets/icons/Riloi_white.webp",
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
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        about,
                        style: size.width >= 1200 && size.height >= 600
                            ? Theme.of(context).textTheme.headlineMedium
                            : Theme.of(context).textTheme.labelMedium,
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
          const backButton()
        ],
      ),
      floatingActionButton: const ActionButton(),
    );
  }
}
