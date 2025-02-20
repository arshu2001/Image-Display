import 'package:flutter/foundation.dart' show kIsWeb;

export 'image_mobile.dart' if (kIsWeb) 'image_web.dart';
