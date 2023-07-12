import 'package:flutter/material.dart';

import '../shared/widgets/widgets.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

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
      child: Stack(
        children: [
          backGround(),
          Hero(
              tag: "contact-background",
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
                  pinned: true,
                  leading: const backButton(),
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.35),
                  title: Hero(
                    tag: "contact-text",
                    child: Text(
                      "CONTACT",
                      style: Theme.of(context).textTheme.displaySmall,
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
            floatingActionButton: const ActionButton(),
          ),
        ],
      ),
    );
  }
}
