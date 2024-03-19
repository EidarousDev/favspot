import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart' as url_package;
import 'package:url_launcher/url_launcher_string.dart';

import '../../core/config/exception_messages.dart';
import '../../core/config/translation_keys.dart';
import '../../core/failures.dart';
import '../../domain/repositories/url_launcher_repo.dart';

class UrlLauncherRepoImpl implements UrlLauncherRepo {
  @override
  Future<Either<Failure, void>> launchUrl({required String url}) async {
    if (url.contains('//')) {
      //check if the instagram link starts with https://
      url = url.substring(url.indexOf('//'), url.length);
    }
    url = 'https://$url';
    try {
      await url_package.launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication);
      return const Right(unit);
    } catch (ex) {
      return Left(HttpFailure(message: S.errorWhenOpeningUrl.tr()));
    }
  }

  @override
  Future<Either<Failure, void>> openEmail({required String email}) async {
    try {
      await url_package.launchUrl(Uri(scheme: 'mailto', path: email));
      return const Right(unit);
    } catch (ex) {
      return Left(
          HttpFailure(message: ExceptionMessages.httpRequestFailed.tr()));
    }
  }
}
