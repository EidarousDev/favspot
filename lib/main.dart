import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/config/app_assets.dart';
import 'core/config/app_config.dart';
import 'di/di.dart';
import 'firebase_options.dart';
import 'views/app_view/app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  init();
  if(kReleaseMode) {
    await SentryFlutter.init(
          (options) {
        options.dsn =
        'https://5a6725506764bd7552688fffb99195e3@o4505705880748032.ingest.sentry.io/4505705882648576';
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 0.01;
      },
      // Init your App.
      appRunner: () => runFavSpot(),
    );
  } else {
    runFavSpot();
  }
}

void runFavSpot() {
  runApp(
    EasyLocalization(
        supportedLocales: AppConfig.supportedLanguages,
        path: AppAssets.translations,
        fallbackLocale: AppConfig.defaultLocale,
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}
