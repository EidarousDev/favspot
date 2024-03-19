library random_string;

import 'dart:io';
import 'dart:math' show Random;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:image/image.dart' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../di/di.dart';
import '../../domain/use_cases/url_launcher/launch_url_use_case.dart';
import '../../providers/package_info_provider.dart';
import '../../providers/remote_config_provider.dart';
import '../config/app_assets.dart';
import '../config/app_config.dart';
import '../config/app_routes.dart';
import '../use_case.dart';

const maxSupportedInteger = 999999999999999;
const minSupportedInteger = 0;
const asciiStart = 33;
const asciiEnd = 126;
const numericStart = 48;
const numericEnd = 57;
const lowerAlphaStart = 97;
const lowerAlphaEnd = 122;
const upperAlphaStart = 65;
const upperAlphaEnd = 90;

final _internal = Random();

/// A generator of double values.
abstract class AbstractRandomProvider {
  /// A non-negative random floating point value is expected
  /// in the range from 0.0, inclusive, to 1.0, exclusive.
  /// A [ProviderError] is thrown if the return value is < 0 or >= 1
  double nextDouble();
}

/// A generator of pseudo-random double values using the default [math.Random].
class DefaultRandomProvider with AbstractRandomProvider {
  const DefaultRandomProvider();

  @override
  double nextDouble() => _internal.nextDouble();
}

class Helper {
  static List<String> searchList(String text) {
    List<String> list = [];
    for (int i = 1; i <= text.length; i++) {
      list.add(text.substring(0, i).toLowerCase());
    }
    return list;
  }

  static englishOnly(String input) {
    String pattern = r'^(?:[a-zA-Z]|\P{L})+$';
    RegExp regex = RegExp(pattern, unicode: true);
    //print(regex.hasMatch(input));
    return regex.hasMatch(input);
  }

  /// Generates a random string of [length] with alpha-numeric characters.
  static String randomAlphaNumeric(int length,
      {AbstractRandomProvider provider = const DefaultRandomProvider()}) {
    var alphaLength = randomBetween(0, length, provider: provider);
    var numericLength = length - alphaLength;
    var alpha = randomAlpha(alphaLength, provider: provider);
    var numeric = randomNumeric(numericLength, provider: provider);
    return randomMerge(alpha, numeric);
  }

  /// Generates a random integer where [from] <= [to] inclusive
  /// where 0 <= from <= to <= 999999999999999
  static int randomBetween(int from, int to,
      {AbstractRandomProvider provider = const DefaultRandomProvider()}) {
    if (from > to) {
      throw ArgumentError('$from cannot be > $to');
    }
    if (from < minSupportedInteger) {
      throw ArgumentError(
          '|$from| is larger than the maximum supported $maxSupportedInteger');
    }

    if (to > maxSupportedInteger) {
      throw ArgumentError(
          '|$to| is larger than the maximum supported $maxSupportedInteger');
    }

    var d = provider.nextDouble();
    if (d < 0 || d >= 1) {
      throw ProviderError(d);
    }
    return _mapValue(d, from, to);
  }

  /// Generates a random string of [length] with only alpha characters.
  static String randomAlpha(int length,
      {AbstractRandomProvider provider = const DefaultRandomProvider()}) {
    var lowerAlphaWeight = provider.nextDouble();
    var upperAlphaWeight = provider.nextDouble();
    var sumWeight = lowerAlphaWeight + upperAlphaWeight;
    lowerAlphaWeight /= sumWeight;
    upperAlphaWeight /= sumWeight;
    var lowerAlphaLength = randomBetween(0, length, provider: provider);
    var upperAlphaLength = length - lowerAlphaLength;
    var lowerAlpha = randomString(lowerAlphaLength,
        from: lowerAlphaStart, to: lowerAlphaEnd, provider: provider);
    var upperAlpha = randomString(upperAlphaLength,
        from: upperAlphaStart, to: upperAlphaEnd, provider: provider);
    return randomMerge(lowerAlpha, upperAlpha);
  }

  /// Generates a random string of [length] with only numeric characters.
  static String randomNumeric(int length,
          {AbstractRandomProvider provider = const DefaultRandomProvider()}) =>
      randomString(length,
          from: numericStart, to: numericEnd, provider: provider);

  /// Generates a random string of [length] with characters
  /// between ascii [from] to [to].
  /// Defaults to characters of ascii '!' to '~'.
  static String randomString(int length,
      {int from = asciiStart,
      int to = asciiEnd,
      AbstractRandomProvider provider = const DefaultRandomProvider()}) {
    return String.fromCharCodes(List.generate(
        length, (index) => randomBetween(from, to, provider: provider)));
  }

  /// Merge [a] with [b] and shuffle.
  static String randomMerge(String a, String b) {
    var mergedCodeUnits = List.from('$a$b'.codeUnits);
    mergedCodeUnits.shuffle();
    return String.fromCharCodes(mergedCodeUnits.cast<int>());
  }

  static int _mapValue(double value, int min, int max) {
    if (min == max) return min;
    var range = (max - min).toDouble();
    return (value * (range + 1)).floor() + min;
  }

  static String formatTimestamp(Timestamp timestamp) {
    var now = Timestamp.now().toDate();
    var date =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 60) {
      time = 'now';
    } else if (diff.inMinutes > 0 && diff.inMinutes < 60) {
      if (diff.inMinutes == 1) {
        time = 'A minute ago';
      } else {
        time = '${diff.inMinutes} minutes ago';
      }
    } else if (diff.inHours > 0 && diff.inHours < 24) {
      if (diff.inHours == 1) {
        time = 'An hour ago';
      } else {
        time = '${diff.inHours} hours ago';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = 'Yesterday';
      } else {
        time = '${diff.inDays} DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = 'A WEEK AGO';
      } else {
        /// Show in Format => 21-05-2019 10:59 AM
        final df = DateFormat('dd-MM-yyyy hh:mm a');
        time = df.format(date);
      }
    }

    return time;
  }

  static void sharePic(String url) async {
    EasyLoading.show();

    final imageInUnit8List = await addWatermark(url);
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/favspot.png').create();
    file.writeAsBytesSync(imageInUnit8List);
    XFile res = await XFile(file.path);
    Share.shareXFiles([res],
        text: AppConfig.sharePicText, subject: AppConfig.sharePicSubject);
    EasyLoading.dismiss();
  }

  static Future<Uint8List> addWatermark(String url) async {
    // Get Logo BytesData
    final logoByteData = await rootBundle.load(AppAssets.logoBig);
    var response;
    try {
      response = await get(Uri.parse(url));
    } catch (e) {
      debugPrint('$e');
      throw HttpException('$e');
    }
    final watermarkedImgBytes = await addImageWatermark(
      originalImageBytes: response.bodyBytes,
      waterkmarkImageBytes: logoByteData.buffer
          .asUint8List(logoByteData.offsetInBytes, logoByteData.lengthInBytes),
    );
    return watermarkedImgBytes;
  }

  ///This method adds the image that is indicated as a watermark,
  ///the parameters are the following:
  /// ```
  /// await addImageWatermark(
  ///   originalImageBytes : //Original Image converted to Uint8List
  ///   waterkmarkImageBytes: //Watermark Image converted to Uint8List
  ///   dstX: //X coordinates in the image (default 100)
  ///   dstY: //Y coordinates in the image (default 100)
  ///   imgHeight: //Image height (default 100)
  ///   imgWidth: //Image width (default 100)
  /// );
  /// ```
  static Future<Uint8List> addImageWatermark({
    required Uint8List originalImageBytes,
    required Uint8List waterkmarkImageBytes,
    int logoHeight = 150,
    int logoWidth = 556,
    int dstX = 100,
    int dstY = 100,
  }) async {
    ///Original Image
    final original = ui.decodeImage(originalImageBytes)!;

    ///Watermark Image
    final watermark = ui.decodeImage(waterkmarkImageBytes)!;

    // add watermark over originalImage
    // initialize width and height of watermark image
    final image = ui.Image(logoWidth, logoHeight);
    ui.drawImage(image, watermark);
    // give position to watermark over image
    ui.copyInto(
      original,
      image,
      dstX: dstX,
      dstY: dstY,
    );

    ///Encode image to PNG
    final wmImage = ui.encodePng(original);
    debugPrint('44444444444444444');

    ///Get the result
    final result = Uint8List.fromList(wmImage);

    return result;
  }

  static void openUrl(String url) async {
    EasyLoading.show();
    final LaunchUrlUseCase launchUrlUseCase = di();
    await launchUrlUseCase(LaunchUrlParams(emailOrUrl: url));
    EasyLoading.dismiss();
  }

  static void checkForUpdate(BuildContext context) async {
    var packageInfo = context.read<PackageInfoProvider>();
    var remoteConfig = context.read<RemoteConfigProvider>();
    await packageInfo.getAppInfo();
    await remoteConfig.getRemoteConfigValues();
    if (Platform.isIOS) {
      if (remoteConfig.forceIOSUpdate) {
        await packageInfo.checkForUpdate(
            remoteVersion: remoteConfig.iOSVersion,
            onForceUpdate: () {
              debugPrint('iOS onForceUpdate');
              context.popAllThenPush(AppRoutes.updateScreen);
            });
      }
    } else if (Platform.isAndroid) {
      if (remoteConfig.forceAndroidUpdate) {
        await packageInfo.checkForUpdate(
            remoteVersion: remoteConfig.androidVersion,
            onForceUpdate: () {
              debugPrint('Android onForceUpdate');
              context.popAllThenPush(AppRoutes.updateScreen);
            });
      }
    }
  }
}

/// ProviderError thrown when a [Provider] provides a value
/// outside the expected [0, 1) range.
class ProviderError implements Exception {
  final double value;

  ProviderError(this.value);

  @override
  String toString() => 'nextDouble() = $value, only [0, 1) expected';
}
