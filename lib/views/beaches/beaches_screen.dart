import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/mediaquery_extension.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_routes.dart';
import '../../core/config/navigation_keys.dart';
import '../../core/config/translation_keys.dart';
import '../../providers/maps_provider.dart';
import '../widgets/custom_appbar.dart';

class BeachesScreen extends StatelessWidget {
  final String city;
  const BeachesScreen({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final beaches = context
        .watch<MapsProvider>()
        .cachedBeaches
        .where((beach) => beach.city == city)
        .toList();
    return CustomAppBar(
      title: '$city ${S.beaches.tr()}',
      child: beaches.length > 0
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: beaches.length,
              itemBuilder: (context, index) {
                final beach = beaches[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () => context.push(AppRoutes.beachDetails,
                          args: {NavigationKeys.beachEntity: beach}),
                      child: CachedNetworkImage(
                        imageUrl: beach.imageUrl,
                        height: context.appHeight * 0.2,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Text(beach.place)
                  ],
                );
              },
            )
          : Center(child: Text(S.noCities.tr())),
    );
  }
}
