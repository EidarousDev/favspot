import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/mediaquery_extension.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_routes.dart';
import '../../../core/config/firestore_config.dart';
import '../../../core/config/navigation_keys.dart';
import '../../../core/config/sizes.dart';
import '../../../core/config/text_styles.dart';
import '../../../core/config/translation_keys.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../providers/blog_provider.dart';
import '../../widgets/spaces.dart';

class CheckInsList extends StatelessWidget {
  const CheckInsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogProvider>(builder: (context, blog, child) {
      debugPrint('Posts = ${blog.checkIns.length}');
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: blog.checkIns.length,
          itemBuilder: (BuildContext context, int i) {
            final post = blog.checkIns[i];
            final status = kBeachesStatuses.firstWhere((element) =>
                element.status.toLowerCase() == post.status.toLowerCase());
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.iconsBackground,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, //New
                        blurRadius: 25.0,
                        offset: Offset(0, 10))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () =>
                                context.push(AppRoutes.photoViewer, args: {
                              NavigationKeys.imageProvider:
                                  CachedNetworkImageProvider(post.imageUrl!),
                              NavigationKeys.heroTag: post.id,
                              NavigationKeys.url: post.imageUrl,
                            }),
                            child: Hero(
                              tag: '${post.id}',
                              child: Container(
                                width: context.appWidth,
                                height: 250.sp,
                                child: CachedNetworkImage(
                                  fit: BoxFit.fitWidth,
                                  imageUrl: post.imageUrl!,
                                  placeholder: (context, url) => Center(
                                    child: SizedBox(
                                        height: 30.0,
                                        width: 30.0,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                        )),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: status.icon.color,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              child: Text(
                                post.status,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: InkWell(
                                onTap: () => Helper.sharePic(post.imageUrl!),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                )),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${post.city}',
                                style: TextStyles.label.copyWith(
                                    color: Colors.white,
                                    fontSize: Sizes.smallFontSize),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${post.place}',
                        style: TextStyles.h3,
                      ),
                      FullWidthDivider(),
                      Row(
                        children: [
                          Text(
                            '${S.by.tr()}${post.userName}',
                            style: TextStyles.label,
                          ),
                          Spacer(),
                          Text(
                            '${Helper.formatTimestamp(post.date!)}',
                            style: TextStyles.label,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
