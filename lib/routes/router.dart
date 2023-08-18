import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'package:plantmonitoringsystem/routes/routes.dart';
import 'package:plantmonitoringsystem/screens/forgot_password/forgot_password.dart';
import 'package:plantmonitoringsystem/screens/home/home.dart';
import 'package:plantmonitoringsystem/screens/login/login.dart';
import 'package:plantmonitoringsystem/screens/register/register.dart';
import 'package:plantmonitoringsystem/screens/soil_moisture/soil_moisture.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // ignore: unused_local_variable
  final Object? arguments = settings.arguments;
  switch (settings.name) {
    case registerScreenRoute:
      return PageTransition(
        child: const RegisterScreen(),
        type: PageTransitionType.fade,
      );

    case forgotPasswordScreenRoute:
      return PageTransition(
        child: const ForgotPasswordScreen(),
        type: PageTransitionType.fade,
      );

    case homeScreenRoute:
      return PageTransition(
        child: const HomeScreen(),
        type: PageTransitionType.fade,
      );

    case soilMoistureScreenRoute:
      return PageTransition(
        child: const SoilMoistureScreen(),
        type: PageTransitionType.fade,
      );

    default:
      return PageTransition(
        child: const LoginScreen(),
        type: PageTransitionType.fade,
      );
  }
}
