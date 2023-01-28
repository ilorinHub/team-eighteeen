import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PickCardWidget extends StatelessWidget {
  const PickCardWidget({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final String icon;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: EdgeInsets.only(
        bottom: (verticalPadding),
      ),
      decoration: BoxDecoration(
        color: themeProvider.isLightTheme ? Colors.white : kColorMagenta,
        borderRadius: BorderRadius.circular(
          (buttonBorderRadius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: (padding),
          horizontal: (horizontalPadding),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (smallHorizontalPadding),
                  vertical: (textFieldBorderRadius) / 2,
                ),
                child: Image.asset(
                  icon,
                  width: (padding) + 3,
                  height: (padding) + 3,
                ),
              ),
            ),
            HSpace(
              (padding),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '4322 4536 **** 342',
                  style: GoogleFonts.inter(
                    fontSize: (textFontSize),
                    color: themeProvider.themeMode().kPrimaryColorDeep,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                HSpace((smallVerticalPadding) / 2),
                Text(
                  'Olaolu Ojerinde',
                  style: GoogleFonts.inter(
                    fontSize: (textFontSize),
                    color: themeProvider
                        .themeMode()
                        .kPrimaryColorDeep!
                        .withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.delete,
              color: kColorRed,
            )
          ],
        ),
      ),
    );
  }
}
