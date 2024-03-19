import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/translation_keys.dart';
import '../../../providers/check_in_provider.dart';

class RegionDropdown extends StatelessWidget {
  const RegionDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CheckInProvider>();
    return DropdownButton(
        isExpanded: true,
        hint: Text(S.pleaseSelect.tr()),
        value: context.watch<CheckInProvider>().selectedRegion,
        items: provider.regions
            .map((region) => DropdownMenuItem(
                value: region,
                child: Text(
                  region.region,
                  style: TextStyle(fontWeight: FontWeight.w900),
                )))
            .toList(),
        onChanged: (region) {
          // Update City Dropdown and everything else
          provider.setSelectedRegion(region);
          provider.setSelectedCity(null);
          provider.setBeaches([]);
          provider.setSelectedBeach(null);
          provider.getCitiesInRegion();
        });
  }
}
