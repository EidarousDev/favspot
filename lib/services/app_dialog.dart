import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/region_entity.dart';
import '../../../providers/maps_provider.dart';
import '../core/config/cache_keys.dart';
import '../core/config/translation_keys.dart';
import '../domain/entities/city_entity.dart';
import '../providers/cache_provider.dart';
import '../views/widgets/spaces.dart';

class AppDialogs {
  static void twoButtonsDialog(BuildContext context,
      {required String text, required Function onSubmit}) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.infoReverse,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      btnOkOnPress: () => onSubmit(),
      btnCancelOnPress: () => context.safePop(),
    )..show();
  }

  static void oneButtonDialog(BuildContext context,
      {bool error = false, required String text, required Function onSubmit}) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: error ? DialogType.error : DialogType.success,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      btnOkOnPress: () => onSubmit(),
    )..show();
  }

  static void selectRegion(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.question,
      body: Center(
        child: Column(
          children: [
            Text(
              '${S.changeRegion.tr()}: ',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            FullWidthDivider(),
            Consumer<MapsProvider>(
              builder: (_, provider, __) {
                return DropdownButton<RegionEntity>(
                    hint: Text(S.pleaseSelect.tr()),
                    value: provider.selectedRegion,
                    items: provider.regions.map((region) {
                      return DropdownMenuItem(
                          value: region,
                          child: Text(
                            region.region,
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ));
                    }).toList(),
                    onChanged: (region) {
                      provider.setSelectedRegion(region);
                    });
              },
            )
          ],
        ),
      ),
      btnOkOnPress: () {
        final cache = context.read<CacheProvider>();
        final maps = context.read<MapsProvider>();
        final region = context.read<MapsProvider>().selectedRegion;
        context.safePop();
        debugPrint(
            'region = ${region?.region}, lat = ${region?.location.latitude}, long = ${region?.location.longitude}');
        cache.writeToCache(key: CacheKeys.region, value: '${region?.region}');
        cache.writeToCache(
            key: CacheKeys.latitude, value: '${region?.location.latitude}');
        cache.writeToCache(
            key: CacheKeys.longitude, value: '${region?.location.longitude}');
        maps.setLatLng(region?.location.latitude, region?.location.longitude);
        maps.getCitiesInRegion();
        maps.animateMapsCamera();
      },
    )..show();
  }

  static void selectCity(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.topSlide,
      dialogType: DialogType.question,
      body: Center(
        child: Column(
          children: [
            Text(
              '${S.selectCity.tr()}: ',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            FullWidthDivider(),
            Consumer<MapsProvider>(
              builder: (_, provider, __) {
                return DropdownButton<CityEntity>(
                    hint: Text(S.pleaseSelect.tr()),
                    value: provider.selectedCity,
                    items: provider.cities.where((c) => c.appear).map((city) {
                      return DropdownMenuItem(
                          value: city,
                          child: Text(
                            city.name,
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ));
                    }).toList(),
                    onChanged: (city) {
                      provider.setSelectedCity(city);
                    });
              },
            )
          ],
        ),
      ),
      btnOkOnPress: () {
        final maps = context.read<MapsProvider>();
        if (maps.selectedCity != null) {
          final lat = maps.selectedCity!.location.latitude;
          final long = maps.selectedCity!.location.longitude;
          maps.setLatLng(lat, long);
          maps.animateMapsCamera();
          context.safePop();
        }
      },
    )..show();
  }
}
