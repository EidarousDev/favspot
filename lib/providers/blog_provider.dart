import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../core/config/app_config.dart';
import '../core/use_case.dart';
import '../domain/entities/check_in_entity.dart';
import '../domain/use_cases/blog/get_check_ins_use_case.dart';

class BlogProvider extends ChangeNotifier {
  final GetCheckInsUseCase getCheckInsUseCase;

  BlogProvider({required this.getCheckInsUseCase});

  // Private State
  List<CheckInEntity> _checkIns = [];
  late ScrollController _scrollController;
  bool _gotAllCheckIns = false;

  // Getters
  UnmodifiableListView<CheckInEntity> get checkIns =>
      UnmodifiableListView(_checkIns);
  ScrollController get scrollController => _scrollController;

  // Methods
  void getCheckIns() async {
    if (!_gotAllCheckIns) {
      EasyLoading.show();
      Timestamp? startAfter;
      if (_checkIns.isNotEmpty) {
        if (_checkIns.length > AppConfig.maxBlogPosts) {
          return;
        }
        startAfter = _checkIns.last.date;
      }
      final result =
          await getCheckInsUseCase(BlogParams(startAfter: startAfter));
      result
          .fold((l) => debugPrint('Failed to retrieve CheckIns: ${l.message}'),
              (res) {
        if (_checkIns.isEmpty) {
          // InitState
          _checkIns = res;
        } else {
          // Load More
          if (res.isEmpty) {
            // All documents were retrieved already
            _gotAllCheckIns = true;
          }
          _checkIns.addAll(res);
        }
        notifyListeners();
      });
      EasyLoading.dismiss();
    }
  }

  void initScrollController() {
    _scrollController = ScrollController()
      ..addListener(() {
        debugPrint('addListener');
        if ((scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) &&
            (_checkIns.length < AppConfig.maxBlogPosts)) {
          getCheckIns();
        }
      });
    notifyListeners();
  }

  @override
  void dispose() {
    _gotAllCheckIns = false;
    _scrollController.dispose();
    super.dispose();
  }
}
