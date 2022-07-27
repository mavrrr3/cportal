import 'package:device_info_plus/device_info_plus.dart';

extension BrowserNameExtension on BrowserName {
  String toPrettyName() {
    switch (this) {
      case BrowserName.chrome:
        return 'Chrome';
      case BrowserName.edge:
        return 'Edge';
      case BrowserName.firefox:
        return 'Firefox';
      case BrowserName.msie:
        return 'Internet Explorer';
      case BrowserName.opera:
        return 'Opera';
      case BrowserName.safari:
        return 'Safari';
      case BrowserName.samsungInternet:
        return 'Samsung Internet';
      case BrowserName.unknown:
        return 'Unknown';
    }
  }
}
