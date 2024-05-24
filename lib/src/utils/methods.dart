import 'package:flutter/material.dart';

void navigateTo(Widget page, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
