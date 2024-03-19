import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../config/translation_keys.dart';

extension NavigationExtension on BuildContext {
  /// Makes sure that the navigation stack isn't empty before popping
  /// the current page.
  void safePop() {
    if (Navigator.canPop(this)) {
      Navigator.of(this).pop();
    }
  }

  /// Navigates to the [route] with the given [arguments].
  ///
  /// This is a shorthand for
  /// `Navigator.of(context).pushNamed(route, arguments: arguments)`.
  ///
  /// Example:
  /// ```dart
  /// context.push('/login', arguments: LoginArguments(username: 'John'));
  /// ```
  ///
  /// See also:
  /// - [Navigator.pushNamed]
  void push(String route, {Object? args}) {
    Navigator.of(this).pushNamed(route, arguments: args);
  }

  /// Navigates to the [route] with the given [arguments].
  ///
  /// This is a shorthand for
  /// `Navigator.of(context).pushReplacementNamed(route, arguments: arguments)`.
  ///
  /// Example:
  /// ```dart
  /// context.pushReplacement('/login', arguments: LoginArguments(username: 'John'));
  /// ```
  ///
  /// See also:
  /// - [Navigator.pushReplacementNamed]
  void pushReplacement(String route, {Object? args}) {
    Navigator.of(this).pushReplacementNamed(route, arguments: args);
  }

  /// Navigates to the [route] with the given [arguments].
  ///
  /// This is a shorthand for
  /// `Navigator.of(context).pushNamedAndRemoveUntil(route, arguments: arguments, (route) => false)`.
  ///
  /// Example:
  /// ```dart
  /// context.popAllThenPush('/user-profile', arguments: {'id': userId});
  /// ```
  ///
  /// See also:
  /// - [Navigator.pushNamedAndRemoveUntil]
  void popAllThenPush(String routeName, {Map? args}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('Navigate to $routeName Screen');
      EasyLoading.show(status: S.loadingIndicator.tr());
      Navigator.of(this).pushNamedAndRemoveUntil(
          routeName, arguments: args, (route) => false);
      EasyLoading.dismiss();
    });
  }
}
