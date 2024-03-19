import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/mediaquery_extension.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';

import '../../core/config/app_assets.dart';
import '../../core/config/app_routes.dart';
import '../../core/config/translation_keys.dart';
import '../../core/utils/helper_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  Widget build(BuildContext context) {
    debugPrint('Splash');
    _controller.forward();
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          AppAssets.splash,
          fit: BoxFit.cover,
          height: context.appHeight,
        ),
        Center(
          child: FadeTransition(
            opacity: _animation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white, //New
                      blurRadius: 100.0,
                      spreadRadius: 10.0,
                      offset: Offset(0, 0))
                ],
              ),
              child: Image.asset(
                AppAssets.logo,
              ),
            ),
          ),
        ),
        AnimatedPositioned(
            bottom: 50,
            child: FadeTransition(
              opacity: _animation,
              child: Text(
                S.bySmartX.tr(),
                style:
                    TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ),
            right: context.appWidth * 0.42,
            duration: const Duration(seconds: 1))
      ],
    ));
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    //Implement animation here
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    Future.microtask(() => Helper.checkForUpdate(context));
    // after 3 second it will navigate
    Future.delayed(const Duration(seconds: 3)).then((val) {
      context.pushReplacement(AppRoutes.home);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
