import 'package:flutter/material.dart';

extension AppDimensions on BuildContext {
  /// Gets the full width
  double get appWidth {
    return MediaQuery.of(this).size.width;
  }

  /// Gets the full height
  double get appHeight {
    return MediaQuery.of(this).size.height;
  }
}
