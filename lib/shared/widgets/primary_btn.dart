import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EGOvButton extends StatelessWidget {
  const EGOvButton(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.loading,
      required this.hasIcon,
      this.disabled = true,
      this.btnColor,
      this.textColor,
      this.secondaryButton = false})
      : super(key: key);
  final VoidCallback onTap;
  final String text;
  final bool loading, hasIcon;
  final bool? disabled, secondaryButton;
  final Color? btnColor, textColor;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: (textFieldBorderRadius),
      ),
      child: InkWell(
        onTap: loading ? null : onTap,
        borderRadius: BorderRadius.circular(
          (textFieldBorderRadius) / 4,
        ),
        child: Container(
          alignment: Alignment.center,
          height: (buttonHeight),
          decoration: BoxDecoration(
            border: secondaryButton!
                ? Border.all(
                    color: kColorMagenta,
                  )
                : null,
            color: secondaryButton!
                ? Colors.transparent
                : !loading
                    ? btnColor ?? primaryColor
                    : primaryColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(
              (buttonBorderRadius) / 1.2,
            ),
          ),
          child: (disabled! && loading)
              ? SizedBox(
                  height: (buttonHeight) / 2.2,
                  width: (buttonHeight) / 2.2,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (hasIcon)
                      Container(
                          padding: EdgeInsets.all(
                            (textFieldBorderRadius) / 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(
                              (textFieldBorderRadius) / 4,
                            ),
                          ),
                          child: const Icon(Icons.add, color: Colors.white)),
                    WSpace(
                      (textFieldBorderRadius) / 2,
                    ),
                    Text(
                      text,
                      style: GoogleFonts.inter(
                        color: !secondaryButton!
                            ? textColor ?? Colors.white
                            : themeProvider.themeMode().ktextColor,
                        fontSize: textFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
