import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final AppConfig _singleton = AppConfig._();

  factory AppConfig() {
    return _singleton;
  }

  AppConfig._();

  static bool get isProduction =>
      kReleaseMode || environment.toLowerCase().startsWith('prod');

  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'dev';

  static String get apiUri => dotenv.env['API_URI'] ?? '';

  static String get authKey => dotenv.env['AUTH_KEY'] ?? '';

  static String get token => dotenv.env['TOKEN'] ?? '';

  static String get imagesUrl => dotenv.env['IMAGES_URL'] ?? '';

  static int get numberRecomendedArticlesWeb =>
      int.tryParse(dotenv.env['NUMBER_RECOMENDED_ARTICLES']!) ?? 10;

  static int get numberNewsArticlesOnMain =>
      int.tryParse(dotenv.env['NUMBER_NEWS_ARTICLES_ON_MAIN']!) ?? 12;

  static int get timeToShowOneSlide =>
      int.tryParse(dotenv.env['TIME_TO_SHOW_ONE_SLIDE']!) ?? 5;

  static Future<void> load() async {
    await dotenv.load(fileName: 'assets/.env');

    // if (kReleaseMode) {
    //   await dotenv.load(fileName: 'assets/.env');
    // } else {
    //   await dotenv.load(fileName: 'assets/.env.test');
    // }
    log('======================================================');
    log('ENVIRONMENT: $environment');
    log('API ENDPOINT: $apiUri');
    log('======================================================');
  }
}
