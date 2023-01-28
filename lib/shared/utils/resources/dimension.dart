import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//screen sizes

//h1
double header1FontSize = 24.sp;

//h2
double header2FontSize = 21..sp;

//h3
double header3FontSize = 18..sp;

//padding
double padding = 20..sp;

//body text
double textFontSize = 16..sp;

//small padding vertical
double smallVerticalPadding = 10..sp;

//small padding horizontal
double smallHorizontalPadding = 10..sp;

//horizontal padding
double horizontalPadding = 20..sp;

// vertical padding big screen
double verticalPadding = 20..sp;

//button heights
double buttonHeight = 50..sp;

//button border radius
double buttonBorderRadius = 10..sp;

//text field border radius
double textFieldBorderRadius = 12..sp;

class HSpace extends StatelessWidget {
  final double _height;
  const HSpace(this._height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height..sp,
    );
  }
}

class WSpace extends StatelessWidget {
  final double _width;

  const WSpace(this._width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width..w,
    );
  }
}
