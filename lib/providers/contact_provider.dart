import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../core/config/translation_keys.dart';
import '../core/errors.dart';
import '../core/use_case.dart';
import '../domain/use_cases/advertise/send_email_use_case.dart';

class ContactProvider extends ChangeNotifier {
  final SendEmailUseCase sendEmailUseCase;

  ContactProvider({required this.sendEmailUseCase});

  // Private State
  String _name = "";
  String _subject = "";
  String _email = "";
  String _message = "";
  String _error = "";
  bool _loading = false;

  // Getters
  String get name => _name;
  String get subject => _subject;
  String get email => _email;
  String get message => _message;
  String get error => _error;
  bool get loading => _loading;

  // Setters
  void setMessage(String value) {
    _message = value;
  }

  void setEmail(String value) {
    _email = value;
  }

  void setName(String value) {
    _name = value;
  }

  void setSubject(String value) {
    _subject = value;
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setError(String value) {
    _error = value;
    notifyListeners();
  }

  // Functions
  Future<void> validateForm(
      {required Function onSuccess,
      required Function onError,
      bool isAdvertise = false}) async {
    _error = ''; // Reset Validation
    if (isAdvertise) {
      _subject = '*** Advertisement ***';
    }
    EasyLoading.show(status: S.loadingIndicator.tr());
    if (_name.isNotEmpty) {
      if (_email.isNotEmpty && _email.contains("@")) {
        if (_message.isNotEmpty) {
          final result = await sendEmailUseCase(SendEmailParams(
              name: _name,
              email: _email,
              subject: _subject,
              message: _message));
          result.fold((l) => debugPrint('failed to send email ${l.message}'),
              (r) {
            onSuccess();
          });
        } else if (_subject.isEmpty) {
          _error = Errors.emptySubject;
        } else {
          _error = Errors.emptyMessage;
        }
      } else {
        _error = Errors.invalidEmail;
      }
    } else {
      _error = Errors.emptyName;
    }
    EasyLoading.dismiss();
    notifyListeners();
    if (_error.length > 0) {
      onError();
    }
  }
}
