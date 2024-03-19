import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/translation_keys.dart';
import '../../../providers/check_in_provider.dart';

class BeachDropdown extends StatelessWidget {
  const BeachDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CheckInProvider>();
    return DropdownButton(
        isExpanded: true,
        hint: Text(S.pleaseSelect.tr()),
        value: provider.selectedBeach,
        items: context
            .watch<CheckInProvider>()
            .beaches
            .map((beach) => DropdownMenuItem(
                value: beach,
                child: Text(
                  beach.place,
                  style: TextStyle(fontWeight: FontWeight.w900),
                )))
            .toList(),
        onChanged: (beach) {
          provider.setSelectedBeach(beach);
          // Fill Status field
          provider.setStatuses();
        });
  }
}
