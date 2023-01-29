import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppAlert {
  static void showSnackBar(
      {required BuildContext context,
      required String message,
      bool isError = false,
      Color? backgroundColor,
      Color? backgroundDarkColor,
      required Widget icon,
      double fontSize = 15}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 2),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor:
              isError ? Colors.red.withOpacity(0.7) : backgroundColor,
          brightness: Brightness.light,
          barrierDismissible: true,
          behavior: FlashBehavior.floating,
          position: FlashPosition.top,
          child: FlashBar(
            padding: EdgeInsets.zero,
            content: SizedBox(
              height: 70.h,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      color: isError ? Colors.redAccent : backgroundDarkColor,
                      child: icon,
                    ),
                  ),
                  WSpace(20.w),
                  Expanded(
                    flex: 4,
                    child: Text(
                      message,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize.sp),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showSuccessMessage(
      {required BuildContext context, required message}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 1),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: colorSkyBlue,
          brightness: Brightness.light,
          barrierDismissible: true,
          behavior: FlashBehavior.floating,
          position: FlashPosition.top,
          child: FlashBar(
            padding: EdgeInsets.zero,
            content: SizedBox(
              height: 70,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  message,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
