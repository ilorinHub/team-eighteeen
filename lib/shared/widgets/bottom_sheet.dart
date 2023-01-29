import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showEGovBottomSheetModal({
  required BuildContext context,
  required Widget child,
  required Size size,
  required ThemeProvider themeProvider,
  bool dismiss = true,
  Color? barrierColor,
  Color? backgroundColor,
  double? heightOfSheet,
}) async {
  showModalBottomSheet(
    isDismissible: dismiss,
    useRootNavigator: false,
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height,
    ),
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => GestureDetector(
      onTap: () {
        if (dismiss) Navigator.pop(context);
      },
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: heightOfSheet ?? MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  color:
                      themeProvider.isLightTheme ? Colors.white : primaryColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  HSpace(smallVerticalPadding),
                  Container(
                    height: 4..sp,
                    width: 64..sp,
                    decoration: BoxDecoration(
                      color: themeProvider.themeMode().kPrimaryColor,
                      borderRadius:
                          BorderRadius.circular(smallHorizontalPadding..sp),
                    ),
                  ),
                  HSpace(padding..sp),
                  Expanded(
                      child: SingleChildScrollView(
                          padding:
                              EdgeInsets.symmetric(horizontal: padding / 2),
                          child: child)),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    isScrollControlled: true,
    barrierColor: barrierColor ?? textColor.withOpacity(0.3),
    enableDrag: true,
  );
}
