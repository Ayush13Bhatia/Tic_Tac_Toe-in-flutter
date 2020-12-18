import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameButton {
  final id;
  String text;
  Color bg;
  bool enabled;
  String image;
  GameButton({
    this.id,
    this.text = "",
    this.bg = Colors.white,
    this.enabled = true,
    this.image = null,
  });
}
