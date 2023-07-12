import 'package:flutter/material.dart';

import '../shared/widgets/widgets.dart';

class StoreDetail extends StatefulWidget {
  final String storeId;
  const StoreDetail(this.storeId, {super.key});

  @override
  State<StoreDetail> createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  @override
  Widget build(BuildContext context) {
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
                    title: Text(
                      "STORE",
                      style: Theme.of(context).textTheme.displaySmall,
                    )),
              ],
            ),
            floatingActionButton: const ActionButton(),
          ),
        ],
      ),
    );
  }
}
