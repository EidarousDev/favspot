import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_assets.dart';
import '../../core/config/text_styles.dart';
import '../../core/config/translation_keys.dart';
import '../../providers/blog_provider.dart';
import '../widgets/buttons.dart';
import '../widgets/spaces.dart';
import 'widgets/check_ins_list.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: context.read<BlogProvider>().scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                AppAssets.header,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 32.0),
                child: BackBtn(),
              ),
            ],
          ),
          VerticalSpace(20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              S.blogScreenTitle.tr(),
              style: TextStyles.h2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckInsList(),
          ),
        ],
      ),
    );
  }
}
