import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/translation_keys.dart';
import '../../../providers/check_in_provider.dart';
import '../../widgets/spaces.dart';

class StatusDropdown extends StatelessWidget {
  const StatusDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CheckInProvider>();
    return DropdownButton(
        isExpanded: true,
        hint: Text(S.pleaseSelect.tr()),
        value: provider.selectedStatus,
        items: context
            .watch<CheckInProvider>()
            .statuses
            .map((status) => DropdownMenuItem(
                value: status,
                child: Row(
                  children: [
                    status.icon,
                    HorizontalSpace(4.0),
                    Text(
                      status.status,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ],
                )))
            .toList(),
        onChanged: (status) {
          provider.setSelectedStatus(status);
          // Fill Status field
        });
  }
}
