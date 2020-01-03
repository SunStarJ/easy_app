import 'dart:ui';

import 'package:flutter/material.dart';

class ColorUtil {
  static bool isDark = false;
  static Color bodyColor = isDark ? ThemeData.dark().scaffoldBackgroundColor : Colors.white;
}
