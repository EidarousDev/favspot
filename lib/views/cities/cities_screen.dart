import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:favspot/views/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_colors.dart';
import '../../core/config/app_routes.dart';
import '../../core/config/navigation_keys.dart';
import '../../core/config/translation_keys.dart';
import '../../providers/maps_provider.dart';

class CitiesScreen extends StatelessWidget {
  const CitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maps = context.read<MapsProvider>();
    final cities = context.watch<MapsProvider>().cities;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('${maps.selectedRegion?.region} ${S.cities.tr()}'),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          color: Colors.white,
          child: cities.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () => context.push(AppRoutes.beaches,
                              args: {NavigationKeys.city: city.name}),
                          child: ListTile(
                            iconColor: AppColors.hintColor,
                            leading: Icon(Icons.add_location_alt_sharp),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primaryColor,
                            ),
                            title: Text(city.name),
                          ),
                        ),
                        FullWidthDivider(
                          thickness: 0.5,
                        )
                      ],
                    );
                  },
                )
              : Center(child: Text(S.noCities.tr())),
        ),
      ),
    );
  }
}
