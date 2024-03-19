import 'package:flutter/cupertino.dart';

class BaseChangeNotifier extends ChangeNotifier {
  bool _disposed = false;
  bool _isLoading = false;

  bool isLoading() {
    return _isLoading;
  }

  void setLoading(bool isLoading) {
    if (_isLoading != isLoading) {
      _isLoading = isLoading;

      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_disposed) {
      return;
    }
    super.notifyListeners();
  }
}
