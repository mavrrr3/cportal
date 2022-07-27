import 'dart:io';

import 'package:flutter/foundation.dart';

/// A constant that is true if the application was compiled to run on the Android or iOS devices.
bool get kIsMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
