import 'package:flutter/material.dart';

Color primaryColor = Colors.green.withOpacity(0.8);
Color darkGreyColor = const Color(0xff767680);
Color primaryColorLight = Colors.green.withOpacity(0.4);
Color primaryColorDeep = Colors.green;
Color colorTextField = const Color.fromARGB(255, 225, 225, 231);
Color colorBottomNav = const Color(0xff393939);
Color colorSkyBlue = const Color(0xff28B9F8);
Color colorBlue = const Color(0xff0C3378);
Color kColorMagenta = const Color(0xff33D1BA);
Color textColor = const Color(0xff01070F);
Color textColorLight = const Color(0xff01070F).withOpacity(0.6);
Color dividerColor = const Color(0xffEDEDED);
Color backDropColor = const Color(0XFF979797);
Color eGovDrawerOptionsColor = const Color(0XFF771FCB);
Color backgroundColor = const Color.fromARGB(255, 245, 242, 242);
Color colorGrey = const Color(0XFFF5F6F8);
Color kborderColor = const Color(0xff9BA7B7);
Color kColorRed = const Color(0xffFD6150);

Color kColorBlack = const Color(0xff252A31);

final linearGradient1 = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  stops: const [0.1, 0.5, 0.7, 0.9],
  colors: [
    primaryColor.withOpacity(0.3),
    primaryColor.withOpacity(0.4),
    primaryColor.withOpacity(0.6),
    primaryColor.withOpacity(0.8),
  ],
);

final linearGradient2 = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  stops: const [0.1, 0.5, 0.7, 0.9],
  colors: [
    primaryColor.withOpacity(0.3),
    Colors.black.withOpacity(0.4),
    primaryColor.withOpacity(0.6),
    Colors.black.withOpacity(0.4),
  ],
);
