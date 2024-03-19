import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_assets.dart';
import '../../../core/config/firestore_config.dart';
import '../../../core/config/translation_keys.dart';
import '../../../providers/maps_provider.dart';

class SideBarFilter extends StatelessWidget {
  const SideBarFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: () =>
                context.read<MapsProvider>().filterBeaches(BeachStatus.free),
            child: Image.asset(AppAssets.bluePin)),
        InkWell(
            onTap: () =>
                context.read<MapsProvider>().filterBeaches(BeachStatus.low),
            child: Image.asset(AppAssets.greenPin)),
        InkWell(
            onTap: () => context
                .read<MapsProvider>()
                .filterBeaches(BeachStatus.moderate),
            child: Image.asset(Platform.isIOS ? AppAssets.yellowPinIOS : AppAssets.yellowPin)),
        InkWell(
            onTap: () => context
                .read<MapsProvider>()
                .filterBeaches(BeachStatus.abundant),
            child: Image.asset(AppAssets.orangePin)),
        InkWell(
            onTap: () => context
                .read<MapsProvider>()
                .filterBeaches(BeachStatus.excessive),
            child: Image.asset(AppAssets.redPin)),
        InkWell(
            onTap: () =>
                context.read<MapsProvider>().filterBeaches(S.clearFilter),
            child: Icon(Icons.close)),
      ]
          .map((widget) => Padding(
                padding: const EdgeInsets.all(4),
                child: widget,
              ))
          .toList(),
    );
  }
}
