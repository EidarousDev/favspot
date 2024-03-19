import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/translation_keys.dart';
import '../../../providers/check_in_provider.dart';

class CityDropdown extends StatelessWidget {
  const CityDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CheckInProvider>();
    return DropdownButton(
        isExpanded: true,
        hint: Text(S.pleaseSelect.tr()),
        value: provider.selectedCity,
        items: context
            .watch<CheckInProvider>()
            .cities
            .map((city) => DropdownMenuItem(
                value: city,
                child: Text(
                  city.name,
                  style: TextStyle(fontWeight: FontWeight.w900),
                )))
            .toList(),
        onChanged: (city) {
          if (city != null) {
            provider.setSelectedCity(city);
            provider.setSelectedBeach(null);
            // Update Beaches Dropdown next
            provider.filterBeachesByCity(city.name);
          }
        });
  }
}
