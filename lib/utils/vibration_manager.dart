import 'dart:developer';

import 'package:vibration/vibration.dart';

class VibrationManager {
  static Future<void> vibrate() async {
    try {
      await Vibration.vibrate();
    } catch (e) {
      log('Vibration is not supported', name: 'VibrationManager');
    }
  }
}
