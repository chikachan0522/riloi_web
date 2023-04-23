import 'package:flutter/material.dart';

Widget backGround() {
  return Hero(
    tag: "background",
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          colors: [
            const Color(0xFFEA6989).withOpacity(0.6),
            const Color(0xFF5CC8C4).withOpacity(0.6),
          ],
          stops: const [
            0.0,
            1.0,
          ],
        ),
      ),
    ),
  );
}
