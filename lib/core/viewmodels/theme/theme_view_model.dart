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
      backgroundColor: isLightTheme ? backgroundColor : primaryColorDeep,
      focusColor: themeMode().kcolorDashboard,
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
      iconTheme: IconThemeData(
        color: themeMode().ktoggleButtonColor,
      ),
      titleTextStyle: textTheme().headline1,
    );
  }

  // Theme mode to display unique properties not cover in theme data
  ThemeColor themeMode() {
    return ThemeColor(
      kgradient1: isLightTheme ? linearGradient1 : linearGradient1,
      kgradient2: !isLightTheme ? linearGradient2 : linearGradient2,
      ktextColor: isLightTheme ? textColor : Colors.white,
      ktextColorLight:
          isLightTheme ? textColorLight : Colors.white.withOpacity(0.8),
      kColorGrey: isLightTheme ? colorGrey : primaryColor,
      kBackgroundColor: isLightTheme ? Colors.white : primaryColorDeep,
      kborderColor: isLightTheme ? kborderColor : kborderColor,
      kcolorDashboard: isLightTheme ? kColorMagenta : kColorMagenta,
      kColorRed: isLightTheme ? kColorRed : Colors.white,
      kcolorTextField: isLightTheme ? colorTextField : kColorBlack,
      kPrimaryColor: isLightTheme ? primaryColor : Colors.white,
      kPrimaryColorDeep: isLightTheme ? primaryColorDeep : Colors.white,
      fundAccountColor: isLightTheme ? primaryColorDeep : kColorBlack,
      kPrimaryColorLight: isLightTheme ? primaryColorLight : primaryColorLight,
      kColorWhite: isLightTheme ? Colors.white : Colors.white.withOpacity(0.2),
      kBottomModalSheetColor: isLightTheme ? Colors.white : primaryColor,
      kycCardTextColor: isLightTheme ? Colors.white : Colors.white,
      kColorBlack: isLightTheme ? kColorBlack : Colors.white,
      kycBaseCardColor: isLightTheme ? Colors.white : kColorBlack,
      ktoggleButtonColor: isLightTheme ? primaryColor : Colors.white,
      ktoggleBackgroundColor: isLightTheme ? primaryColor : Colors.white,
      kColorBlue: isLightTheme ? colorBlue : Colors.white,
      kDarkGrey: isLightTheme ? darkGreyColor.withOpacity(0.25) : darkGreyColor,
      kshadow: [
        if (isLightTheme)
          const BoxShadow(
              color: Color(0xFFd8d7da),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(2, 2)),
        if (!isLightTheme)
          const BoxShadow(
              color: Color(0x66000000),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(2, 2))
      ],
    );
  }
}

// A class to manage specify colors and styles in the app not supported by theme data
class ThemeColor {
  LinearGradient? kgradient1;
  LinearGradient? kgradient2;
  Color? kBackgroundColor;
  Color? ktoggleButtonColor;
  Color? ktoggleBackgroundColor;
  Color? ktextColor;
  Color? kPrimaryColor;
  Color? kPrimaryColorDeep;
  Color? fundAccountColor;
  Color? kyCSelectedCardColor;
  Color? kPrimaryColorLight;
  Color? kcolorTextField;
  Color? kDarkGrey;
  Color? ktextColorLight;
  Color? kcolorDashboard;
  Color? kDarkGreen;
  List<BoxShadow>? kshadow;
  Color? kbackDropColor;
  Color? kcolorPurple;
  Color? kColorGrey;
  Color? kborderColor;
  Color? kColorRed;
  Color? kColorRedOpacity;
  Color? kcolorGreenOpacity;
  Color? kcolorGreen;
  Color? lightGrey;
  Color? kQwikColor;
  Color? kColorWhite;
  Color? kBottomModalSheetColor;
  Color? kColorBlack;
  Color? kycBaseCardColor;
  Color? kColorBlue;
  Color? ksearchTextField;
  Color? kProfileCardColor;
  Color? kReverseProfileCardColor;
  Color? kycCardTextColor;

  ThemeColor({
    this.kColorGrey,
    this.kQwikColor,
    this.kbackDropColor,
    this.kBackgroundColor,
    this.kborderColor,
    this.kcolorDashboard,
    this.kcolorGreen,
    this.kcolorGreenOpacity,
    this.kcolorPurple,
    this.kColorRed,
    this.kColorRedOpacity,
    this.kcolorTextField,
    this.kgradient1,
    this.kgradient2,
    this.kPrimaryColor,
    this.kPrimaryColorLight,
    this.kDarkGreen,
    this.kshadow,
    this.ktextColor,
    this.ktextColorLight,
    this.ktoggleBackgroundColor,
    this.ktoggleButtonColor,
    this.lightGrey,
    this.fundAccountColor,
    this.kPrimaryColorDeep,
    this.kColorWhite,
    this.kColorBlack,
    this.kDarkGrey,
    this.ksearchTextField,
    this.kProfileCardColor,
    this.kColorBlue,
    this.kReverseProfileCardColor,
    this.kyCSelectedCardColor,
    this.kycBaseCardColor,
    this.kycCardTextColor,
    this.kBottomModalSheetColor,
  });
}
