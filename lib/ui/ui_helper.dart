import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIHelper {
  // STRING
  static const String createAccount = "Create\nAccount";
  static const String welcomeBack = "Welcome\nBack";
  static const String name = "Name";
  static const String hello = "Hello";
  static const String email = "Email address";
  static const String username = "Username";
  static const String password = "Password";
  static const String login = "Login";
  static const String signIn = "Sign In";
  static const String signUp = "SIGN UP";
  static const String signInLower = "Sign in";
  static const String signUpLower = "Sign up";
  static const String stayLoggedIn = "Stay Logged In";
  static const String forgetPassword = "Forget Password?";
  static const String loginSpotify = "LOG IN WITH SPOTIFY ";
  static const String loginFacebook = "Login with Facebook";
  static const String emailRequired = "Email is required";
  static const String passwordRequired = "Password is required";
  static const String dontHaveAnAccount = "Don't have an account?";
  static const String signAccount = "Sign in to your Account";

  // IMAGES
  static const String muzPhoto = "assets/images/muz_login.png";
  static const String grapePhoto = "assets/images/grape_login.png";
  static const String strawberryPhoto = "assets/images/strawberry_login.png";
  static const String blueberryPhoto = "assets/images/blueberry.png";
  static const String pomegranatePhoto = "assets/images/pomegranate_login.png";
  static const String apricotPhoto = "assets/images/apricot_login.png";
  static const String figPhoto = "assets/images/fig_login.png";
  static const String cherryPhoto = "assets/images/cherry_login.png";
  static const String applePhoto = "assets/images/apple_login.png";
  static const String watermelonPhoto = "assets/images/watermelon_login.png";
  static const String pineapplePhoto = "assets/images/pineapple_login.png";
  static const String pearPhoto = "assets/images/pear_login.png";
  static const String noPhoto = "assets/images/no_photo.png";
  static const String scooter = "assets/drawable/scooter.png";

  // MUZ LOGIN COLORS
  static const Color muzPrimaryColor = Color(0XFF3C67F7);
  static const Color muzBackgroundColor = Color(0xFFF2F3F8);
  static const Color muzShadow = Color(0x70000000);
  static const Color muzButtonshadow = Color(0x403C67F7);
  static const Color muzTextColor = Color(0xFF5A7BB5);

  // STRAWBERRY LOGIN COLORS
  static const Color strawberryPrimaryColor = Color(0xFFFE0000);
  static const Color strawberrySecondaryColor = Color(0xFFC40000);
  static const Color strawberryShadow = Color(0x70000000);
  static const Color strawberryButtonshadow = Color(0x403C67F7);
  static const Color strawberryTextColor = Color(0xFF5A7BB5);
  static const Color strawberryFocusColor = Color(0xFFFF5A35);

  // BLUEBERRY LOGIN COLORS
  static const Color blueberryBlue = Color(0xFF4D7DF9);
  static const Color blueberryBlack = Color(0xFF222222);
  static const Color blueberryOrange = Color(0xFFFFD164);
  static const Color blueberryGrey = Color(0xFFF7F9FA);
  static const Color blueberryTextColor = Color(0xFFBBC3CE);

  // POMEGRANATE LOGIN COLORS
  static const Color pomegranatePrimaryColor = Color(0xFFFF5E7A);
  static const Color pomegranateShadowColor = Color(0x60FF5E7A);
  static const Color pomegranateTextColor = Color(0xFF6D7278);

  // APRICOT LOGIN COLORS
  static const Color apricotPrimaryColor = Color(0xFFFEB209);
  static const Color apricotShadowColor = Color(0x60FF5E7A);
  static const Color apricotTextColor = Color(0xFFC2C2C2);

  // FIG LOGIN COLORS
  static const Color figPrimaryColor = Color(0xFF182058);
  static const Color figSecondaryColor = Color(0xFFE03E3E);
  static const Color figShadowColor = Color(0x60FF5E7A);
  static const Color figTextColor = Color(0xFF9E9D9D);
  static const Color figForgetTextColor = Color(0xFF38B5F2);

  // CHERRY LOGIN COLORS
  static const Color cherryPrimaryColor = Color(0xFF1566E0);
  static const Color cherryInputTextColor = Color(0xFF1EA5FF);

  // APPLE LOGIN COLORS
  static const Color appleGradientColorOne = Color(0xFFFBC79A);
  static const Color appleGradientColorTwo = Color(0xFFDD5671);

  // WATERMELON LOGIN COLORS
  static const Color watermelonPrimaryColor = Color(0xFFC72C41);
  static const Color watermelonShadow = Color(0x40C72C41);

  // PINEAPPLE LOGIN COLOR
  static const Color pineapplePrimaryColor = Color(0xFF71CEEB);
  static const Color pineappleSecondaryColor = Color(0xFFF1F0F2);
  static const Color pineappleShadow = Color(0x30000000);

  // PEAR LOGIN COLOR
  static const Color pearPrimaryColor = Color(0xFF4873FF);

  // AVOCADOS LOGIN COLOR
  static const Color avocadosPrimaryColor = Color(0xFF0B5D47);
  static const Color avocadosSecondaryColor = Color(0xFFFEA839);

  // GLOBAL COLORS
  static const Color spotifyColor = Color(0xFF1DB954);
  static const Color spotifyTextColor = Color(0xFFF4F6FC);
  static const Color spotifyShadow = Color(0x401DB954);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color themePrimary = Color(0XFF575C79);
  static const Color themeLight = Color(0XFF8489A8);
  static const Color themeDark = Color(0XFF2D334D);
  static const Color backgroundColor = Color(0XFFAEB2D1);
  static const Color facebookColor = Color(0xFF3B5998);

  // SPACE
  static dynamicHeight(double height) => ScreenUtil().setHeight(height);
  static dynamicWidth(double width) => ScreenUtil().setWidth(width);
  // static dynamicSp(double fontsize) => ScreenUtil.setSp(fontsize);
}
