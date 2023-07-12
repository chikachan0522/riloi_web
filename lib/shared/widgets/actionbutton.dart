import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riloi_web/providers/theme_provider.dart';

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
