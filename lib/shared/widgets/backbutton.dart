import 'package:flutter/material.dart';

class backButton extends StatelessWidget {
  const backButton({super.key});

  @override
  Widget build(BuildContext context) {
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
}
