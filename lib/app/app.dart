import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluro/fluro.dart';

import 'package:riloi_web/providers/theme_provider.dart';
import 'package:riloi_web/page/home.dart';
import 'theme.dart';

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
      theme: whiteTheme(),
      darkTheme: darkTheme(),
      themeMode: ref.watch(isLight),
    );
  }
}
