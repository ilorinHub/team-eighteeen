import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:egov/shared/widgets/bottom_nav.dart';
import 'package:egov/shared/widgets/primary_btn.dart';
import 'package:egov/shared/widgets/ratings.dart';
import 'package:egov/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RateRider extends StatefulWidget {
  static const String routeName = "/rate_rider";
  const RateRider({super.key});

  @override
  State<RateRider> createState() => _RateRiderState();
}

class _RateRiderState extends State<RateRider> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: themeProvider.themeMode().kBackgroundColor,
        child: SizedBox(
          height: size.height * 0.15,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                EGOvButton(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, BottomNavigationScreen.routeName);
                    },
                    text: 'Send Review',
                    loading: false,
                    hasIcon: false),
                HSpace(smallVerticalPadding),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: Column(
          children: [
            const HSpace(100),
            Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeProvider.themeMode().kPrimaryColor,
                ),
                child: const Icon(
                  Icons.done_rounded,
                  color: Colors.white,
                )),
            HSpace(verticalPadding),
            Text(
              'Ride Completed',
              style: themeProvider.textTheme().headline1!.copyWith(
                    color: themeProvider.themeMode().kPrimaryColorDeep,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            HSpace(smallVerticalPadding),
            Text(
              'Rate your Experience',
              style: themeProvider.textTheme().headline3!.copyWith(
                    color: themeProvider.themeMode().ktextColor,
                    fontSize: (textFontSize),
                    fontWeight: FontWeight.w700,
                  ),
            ),
            HSpace(padding),
            const RatingsWidget(
              ratings: 0,
              isActive: true,
              size: 50,
            ),
            HSpace(buttonHeight),
            const MultiLineTextFieldWidget(
                hintText: 'Comment for the rider',
                textInputType: TextInputType.text,
                controller: null,
                textInputAction: TextInputAction.done),
          ],
        ),
      ),
    );
  }
}
