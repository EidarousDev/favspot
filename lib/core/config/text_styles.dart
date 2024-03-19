import 'package:flutter/material.dart';

import 'sizes.dart';

class TextStyles {
  static final bold = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: Sizes.regularFontSize,
  );

  static final h3 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: Sizes.regularFontSize,
  );

  static final label = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: Sizes.regularFontSize,
      color: Colors.grey);

  static final h1 = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: Sizes.h1FontSize,
  );

  static final h2 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: Sizes.h2FontSize,
  );
}
