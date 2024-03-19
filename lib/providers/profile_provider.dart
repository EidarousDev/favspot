import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../core/use_case.dart';
import '../domain/use_cases/profile/create_delete_account_use_case.dart';

class ProfileProvider extends ChangeNotifier {
  final CreateDeleteAccountRequestUseCase createDeleteAccountRequestUseCase;

  ProfileProvider({required this.createDeleteAccountRequestUseCase});

  // Methods
  Future<void> createDeleteAccountRequest() async {
    EasyLoading.show();
    final result = await createDeleteAccountRequestUseCase(NoParams());
    result.fold(
        (l) => debugPrint('Failed to Create Delete Account Request: $l'),
        (r) => null);
    EasyLoading.dismiss();
  }
}
