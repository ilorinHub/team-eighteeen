import 'dart:developer';

import 'package:egov/app_container.dart';
import 'package:egov/core/services/storage/storage_service.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  ThemeProvider({
    required this.isLightTheme,
  });

  // use to toggle the theme
  toggleThemeData({required bool value, bool shouldLoad = true}) async {
    log('value on toggle is $value');
    sl<StorageService>().saveThemeValue(value);
    isLightTheme = value;
    if (!shouldLoad) notifyListeners();
  }

  // Global theme data we are always check if the light theme is enabled #isLightTheme

  ThemeData theme() {
    return ThemeData(
      appBarTheme: appBarTheme(),
      primarySwatch: Colors.green,
      toggleableActiveColor: Colors.white,
      splashColor: themeMode().kPrimaryColor,
      scaffoldBackgroundColor: themeMode().kBackgroundColor,
      primaryColor: themeMode().kPrimaryColor,
      fontFamily: GoogleFonts.inter().fontFamily,
      backgroundColor: !isLightTheme ? Colors.white : Colors.black,
      textTheme: textTheme(),
      tabBarTheme: tabBarTheme(),
      dividerTheme: const DividerThemeData(
        color: Colors.grey,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      disabledColor: isLightTheme ? Colors.grey : Colors.white,
      hintColor: Colors.black,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: kColorMagenta,
      ),
      indicatorColor: kColorMagenta,
    );
  }

  TextTheme textTheme() {
    return TextTheme(
      headline1: GoogleFonts.inter(
        color: themeMode().kPrimaryColorDeep,
        fontSize: (header1FontSize),
        fontWeight: FontWeight.w800,
      ),
      headline2: GoogleFonts.inter(
        color: themeMode().kPrimaryColorDeep,
        fontSize: (header2FontSize),
        fontWeight: FontWeight.w600,
      ),
      headline3: GoogleFonts.inter(
        color: themeMode().ktextColor,
        fontSize: (textFontSize),
        fontWeight: FontWeight.w500,
      ),
      subtitle1: GoogleFonts.inter(
        fontSize: (header2FontSize) * 1.4,
        fontWeight: FontWeight.bold,
        color: themeMode().ktextColor,
      ),
      subtitle2: GoogleFonts.inter(
        fontSize: (header3FontSize) * 1.1,
        fontWeight: FontWeight.bold,
        color: themeMode().kPrimaryColor,
      ),
      bodyText1: GoogleFonts.inter(
        color: themeMode().ktextColor,
        fontSize: (textFontSize),
        fontWeight: FontWeight.w400,
      ),
      bodyText2: GoogleFonts.inter(
        color: themeMode().ktextColorLight,
        fontSize: (textFontSize),
        fontWeight: FontWeight.normal,
      ),
      caption: GoogleFonts.montserrat(
        color: themeMode().ktextColor!.withOpacity(0.71),
        fontSize: (textFontSize) * 0.6,
        fontWeight: FontWeight.normal,
      ),
    ).apply(fontFamily: GoogleFonts.inter().fontFamily);
  }

  TabBarTheme tabBarTheme() {
    return TabBarTheme(
      unselectedLabelColor: themeMode().ktextColor,
      labelStyle: GoogleFonts.inter(
        fontSize: (textFontSize),
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: (textFontSize),
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  AppBarTheme appBarTheme() {
    return AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryColor),
      titleTextStyle: textTheme().headline1,
    );
  }

  // Theme mode to display unique properties not cover in theme data
  ThemeColor themeMode() {
    return ThemeColor(
      ktextColor: isLightTheme ? textColor : Colors.white,
      ktextColorLight:
          isLightTheme ? textColorLight : Colors.white.withOpacity(0.8),
      kColorGrey: isLightTheme ? colorGrey : primaryColor,
      kBackgroundColor: isLightTheme ? Colors.white : Colors.black,
      kPrimaryColor: isLightTheme ? primaryColor : kColorBlack,
      kPrimaryColorDeep: isLightTheme ? primaryColorDeep : Colors.black,
      kPrimaryColorLight: isLightTheme ? primaryColorLight : primaryColorLight,
      kColorWhite: isLightTheme ? Colors.white : Colors.white.withOpacity(0.2),
      kColorBlack: isLightTheme ? kColorBlack : Colors.white,
    );
  }
}

// A class to manage specify colors and styles in the app not supported by theme data
class ThemeColor {
  Color? kBackgroundColor;
  Color? ktextColor;
  Color? kPrimaryColor;
  Color? kPrimaryColorDeep;

  Color? kPrimaryColorLight;

  Color? kDarkGrey;
  Color? ktextColorLight;

  Color? kbackDropColor;

  Color? kColorGrey;
  Color? kborderColor;

  Color? kcolorGreenOpacity;
  Color? kcolorGreen;
  Color? lightGrey;

  Color? kColorWhite;
  Color? kBottomModalSheetColor;
  Color? kColorBlack;

  ThemeColor({
    this.kColorGrey,
    this.kbackDropColor,
    this.kBackgroundColor,
    this.kcolorGreen,
    this.kcolorGreenOpacity,
    this.kPrimaryColor,
    this.kPrimaryColorLight,
    this.ktextColor,
    this.ktextColorLight,
    this.kPrimaryColorDeep,
    this.kColorWhite,
    this.kColorBlack,
  });
}
