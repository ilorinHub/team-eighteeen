import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:egov/shared/utils/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  static const String routeName = "/notifications";
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Notifications'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: Column(
          children: const [
            NotificationItems(
              title: 'Money added to wallet',
              subtitle: '${naira}2000',
              timeStamp: '30 January 2023 (13:00)',
            ),
            NotificationItems(
              title: 'Ride Completed',
              subtitle: 'Tanke to Fate, Single, ${naira}100',
              timeStamp: '27th January 2023 (14:00)',
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItems extends StatelessWidget {
  const NotificationItems({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.timeStamp,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String timeStamp;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: (smallVerticalPadding),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: (smallHorizontalPadding),
              vertical: (smallVerticalPadding),
            ),
            decoration: BoxDecoration(
              color: themeProvider.themeMode().kColorWhite,
              borderRadius: BorderRadius.circular(
                (textFieldBorderRadius),
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/success.svg',
                ),
                HSpace(
                  (horizontalPadding),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.mulish(
                        color: themeProvider.themeMode().kPrimaryColor,
                        fontSize: (header3FontSize),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    HSpace(
                      (verticalPadding) / 3,
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.mulish(
                        color: themeProvider.themeMode().ktextColor,
                        fontSize: (textFontSize) - 3,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    HSpace(
                      (verticalPadding) / 3,
                    ),
                    Text(
                      timeStamp,
                      style: GoogleFonts.mulish(
                        color: themeProvider
                            .themeMode()
                            .ktextColor!
                            .withOpacity(0.5),
                        fontSize: (textFontSize) - 3,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          HSpace(smallVerticalPadding),
          const Divider()
        ],
      ),
    );
  }
}
