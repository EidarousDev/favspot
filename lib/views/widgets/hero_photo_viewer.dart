import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

import '../../core/config/app_assets.dart';
import '../../core/utils/helper_functions.dart';

class PhotoViewer extends StatelessWidget {
  const PhotoViewer({
    super.key,
    required this.imageProvider,
    required this.heroTag,
    this.url,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final String heroTag;
  final String? url;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppAssets.logo,
          height: 30.sp,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          url == null
              ? const SizedBox()
              : InkWell(
                  onTap: () => Helper.sharePic(url!),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.share,
                      size: 20,
                    ),
                  ),
                ),
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          imageProvider: imageProvider,
          backgroundDecoration: backgroundDecoration,
          minScale: minScale,
          maxScale: maxScale,
          heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
        ),
      ),
    );
  }
}
