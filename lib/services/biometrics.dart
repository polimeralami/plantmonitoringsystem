import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsMethods {
  static Future<bool> authenticateWithBiometrics() async {
    try {
      final LocalAuthentication localAuthentication = LocalAuthentication();
      bool isBiometricSupported = await localAuthentication.isDeviceSupported();
      bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

      bool isAuthenticated = false;

      if (isBiometricSupported && canCheckBiometrics) {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason: 'Please complete the biometrics to proceed.',
        );
      }

      log('isBiometricSupported: $isBiometricSupported');
      log('canCheckBiometrics: $canCheckBiometrics');
      log('isAuthenticated: $isAuthenticated');

      return isAuthenticated;
    } on PlatformException catch (e) {
      return false;
    }
  }
}
