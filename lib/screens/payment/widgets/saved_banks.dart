import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SavedBankCard extends StatelessWidget {
  const SavedBankCard({
    Key? key,
    required this.onTap,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
  }) : super(key: key);
  final VoidCallback onTap;
  final String bankName, accountName, accountNumber;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            vertical: (verticalPadding),
            horizontal: (horizontalPadding),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    accountName,
                    style: GoogleFonts.inter(
                      fontSize: (textFontSize),
                      color: themeProvider.themeMode().kPrimaryColorDeep,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  HSpace((smallVerticalPadding)),
                  Text(
                    bankName,
                    style: GoogleFonts.inter(
                      fontSize: (textFontSize),
                      color: themeProvider
                          .themeMode()
                          .ktextColor!
                          .withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  HSpace((smallVerticalPadding)),
                  Text(
                    accountNumber,
                    style: GoogleFonts.inter(
                      fontSize: (textFontSize),
                      color: themeProvider.themeMode().kPrimaryColorDeep,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
