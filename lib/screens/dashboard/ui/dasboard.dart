import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/screens/payment/ui/add_new_payment.dart';
import 'package:egov/screens/payment/ui/payment_details.dart';
import 'package:egov/screens/payment/ui/payment_history.dart';
import 'package:egov/screens/payment/ui/share.dart';
import 'package:egov/screens/payment/ui/withdraw.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:egov/shared/utils/resources/strings.dart';
import 'package:egov/shared/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = "/dash";
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _showCurrentRide = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    return Consumer<DashboardViewmodel>(builder: (context, value, child) {
      return Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HSpace(buttonHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WalletWidget(
                      showCurrentRide: _showCurrentRide,
                      size: size,
                      themeProvider: themeProvider),
                  if (_showCurrentRide)
                    CurrentRide(size: size, themeProvider: themeProvider)
                ],
              ),
              HSpace(verticalPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WalletActionWidgets(
                    title: 'Add',
                    size: size,
                    themeProvider: themeProvider,
                    icon: Icons.arrow_upward,
                    onTap: () {
                      if (value.cardAdded) {
                        Navigator.pushNamed(context, PaymentDetails.routeName);
                      } else {
                        Navigator.pushNamed(context, AddNewCard.routeName);
                      }
                    },
                  ),
                  WalletActionWidgets(
                    title: 'Withdraw',
                    size: size,
                    themeProvider: themeProvider,
                    icon: Icons.arrow_downward,
                    onTap: () {
                      Navigator.pushNamed(context, WithdrawFunds.routeName);
                    },
                  ),
                  WalletActionWidgets(
                    title: 'Share',
                    size: size,
                    themeProvider: themeProvider,
                    icon: Icons.swap_horiz,
                    onTap: () {
                      Navigator.pushNamed(context, ShareFunds.routeName);
                    },
                  ),
                  WalletActionWidgets(
                    title: 'History',
                    size: size,
                    themeProvider: themeProvider,
                    icon: Icons.history,
                    onTap: () {
                      Navigator.pushNamed(context, PaymentHistory.routeName);
                    },
                  ),
                ],
              ),
              HSpace(buttonHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardButton(
                      size: size,
                      themeProvider: themeProvider,
                      title: 'Book A Ride',
                      icon: Icons.swap_horiz,
                      onTap: () {
                        showEGovBottomSheetModal(
                                context: context,
                                child: Column(
                                  children: [
                                    Text(
                                      'Select Ride Option',
                                      style: themeProvider
                                          .textTheme()
                                          .headline2
                                          ?.copyWith(
                                            color: themeProvider
                                                .themeMode()
                                                .ktextColor,
                                          ),
                                    ),
                                    HSpace(buttonHeight),
                                    ChooseRideType(
                                      themeProvider: themeProvider,
                                      icon: Icons.emoji_people,
                                      title: 'Single',
                                      onTap: () {
                                        value.userRideType = RideType.single;
                                        // Navigator.pushNamed(
                                        //     context, BookRideView.routeName);
                                      },
                                    ),
                                    HSpace(smallVerticalPadding),
                                    const Divider(),
                                    HSpace(smallVerticalPadding),
                                    ChooseRideType(
                                      themeProvider: themeProvider,
                                      icon: Icons.people_sharp,
                                      title: 'Shared',
                                      onTap: () {
                                        value.userRideType = RideType.shared;
                                        // Navigator.pushNamed(
                                        //     context, BookRideView.routeName);
                                      },
                                    ),
                                  ],
                                ),
                                size: size,
                                themeProvider: themeProvider)
                            .then((value) {
                          setState(() {
                            _showCurrentRide = true;
                          });
                        });
                      }),
                  DashboardButton(
                    size: size,
                    themeProvider: themeProvider,
                    title: 'Emergency Request',
                    icon: Icons.bike_scooter,
                    onTap: () {},
                  ),
                ],
              ),
              HSpace(padding * 1.5),
              PlanAJourneyWidget(
                size: size,
                themeProvider: themeProvider,
                onTap: () {},
              ),
              HSpace(padding * 1.5),
            ],
          ),
        ),
      );
    });
  }
}

class CurrentRide extends StatelessWidget {
  const CurrentRide({
    Key? key,
    required this.size,
    required this.themeProvider,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final ThemeProvider themeProvider;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.44,
        height: size.height * 0.23,
        padding: EdgeInsets.symmetric(
            horizontal: smallHorizontalPadding, vertical: smallVerticalPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(buttonBorderRadius * 2),
            gradient: LinearGradient(begin: Alignment.topLeft, stops: const [
              0.3,
              0.5,
              0.8,
              1
            ], colors: [
              themeProvider.themeMode().kPrimaryColor!.withOpacity(0.3),
              themeProvider.themeMode().kPrimaryColor!.withOpacity(0.7),
              themeProvider.themeMode().kPrimaryColor!.withOpacity(0.5),
              themeProvider.themeMode().kPrimaryColor!.withOpacity(0.7),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.train,
                  color: themeProvider.themeMode().kColorBlack,
                ),
                WSpace(smallHorizontalPadding / 2),
                Text('Current Ride',
                    style: themeProvider
                        .textTheme()
                        .bodyText2
                        ?.copyWith(fontSize: textFontSize * 0.9)),
                WSpace(smallHorizontalPadding / 2),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: themeProvider.themeMode().kColorBlack,
                ),
              ],
            ),
            Text(
              'origin:Agbabiaka',
              style: themeProvider.textTheme().bodyText1,
            ),
            Text(
              'destination: Unity',
              style: themeProvider.textTheme().bodyText2,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: themeProvider.themeMode().kDarkGreen,
                  size: horizontalPadding,
                ),
                WSpace(smallHorizontalPadding),
                Text('Single',
                    style: themeProvider
                        .textTheme()
                        .bodyText1
                        ?.copyWith(fontSize: textFontSize * 0.7)),
                WSpace(smallHorizontalPadding),
                Text('(${naira}980)',
                    style: themeProvider
                        .textTheme()
                        .bodyText1
                        ?.copyWith(fontSize: textFontSize * 0.7)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    Key? key,
    required bool showCurrentRide,
    required this.size,
    required this.themeProvider,
  })  : _showCurrentRide = showCurrentRide,
        super(key: key);

  final bool _showCurrentRide;
  final Size size;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _showCurrentRide ? size.width * 0.44 : size.width * 0.89,
      height: size.height * 0.23,
      padding: EdgeInsets.symmetric(
          horizontal:
              _showCurrentRide ? smallHorizontalPadding : horizontalPadding,
          vertical: smallVerticalPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(buttonBorderRadius * 2),
          gradient: LinearGradient(begin: Alignment.topLeft, stops: const [
            0.3,
            0.5,
            0.8,
            1
          ], colors: [
            themeProvider.themeMode().kPrimaryColor!.withOpacity(0.3),
            themeProvider.themeMode().kPrimaryColor!.withOpacity(0.7),
            themeProvider.themeMode().kPrimaryColor!.withOpacity(0.5),
            themeProvider.themeMode().kPrimaryColor!.withOpacity(0.7),
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.wallet,
                color: themeProvider.themeMode().kColorBlack,
              ),
              WSpace(smallHorizontalPadding / 2),
              Text('Main Wallet',
                  style: themeProvider
                      .textTheme()
                      .bodyText2
                      ?.copyWith(fontSize: textFontSize * 0.9)),
              WSpace(smallHorizontalPadding / 2),
              Icon(
                Icons.keyboard_arrow_down,
                color: themeProvider.themeMode().kColorBlack,
              ),
            ],
          ),
          Text(
            '$naira 45,000.00',
            style: themeProvider.textTheme().headline1,
          ),
          Row(
            children: [
              Icon(
                Icons.arrow_upward,
                color: themeProvider.themeMode().kDarkGreen,
                size: horizontalPadding,
              ),
              WSpace(smallHorizontalPadding),
              Text('8.2%',
                  style: themeProvider
                      .textTheme()
                      .bodyText1
                      ?.copyWith(fontSize: textFontSize * 0.7)),
              WSpace(smallHorizontalPadding),
              Text('(${naira}980)',
                  style: themeProvider
                      .textTheme()
                      .bodyText1
                      ?.copyWith(fontSize: textFontSize * 0.7)),
            ],
          ),
        ],
      ),
    );
  }
}

class ChooseRideType extends StatelessWidget {
  const ChooseRideType({
    Key? key,
    required this.themeProvider,
    required this.title,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  final ThemeProvider themeProvider;
  final String title;
  final void Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: themeProvider.themeMode().kPrimaryColorLight,
                  shape: BoxShape.circle),
              child: Icon(icon, color: themeProvider.themeMode().kColorBlue)),
          WSpace(padding),
          Text(
            title,
            style: themeProvider.textTheme().bodyText1?.copyWith(
                  color: themeProvider.themeMode().ktextColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class PlanAJourneyWidget extends StatelessWidget {
  const PlanAJourneyWidget({
    Key? key,
    required this.size,
    required this.themeProvider,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final ThemeProvider themeProvider;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: size.height * 0.17,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, stops: const [
            0.5,
            1
          ], colors: [
            themeProvider.themeMode().kPrimaryColor!.withOpacity(0.2),
            themeProvider.themeMode().kPrimaryColor!.withOpacity(0.4),
          ]),
          borderRadius: BorderRadius.circular(padding * 1.4),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  HSpace(padding),
                  Text(
                    'Plan A Journey',
                    style: themeProvider.textTheme().headline2?.copyWith(
                          color: themeProvider.themeMode().kQwikColor,
                        ),
                  ),
                  HSpace(smallVerticalPadding),
                  Text(
                    'Easily plan your journey to suit your daily transport needs',
                    style: themeProvider.textTheme().bodyText1?.copyWith(
                          color: themeProvider.themeMode().kColorBlue,
                        ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: themeProvider.themeMode().kPrimaryColor,
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.train,
                    color: themeProvider.themeMode().kColorWhite,
                    size: buttonHeight * 0.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  const DashboardButton({
    Key? key,
    required this.size,
    required this.themeProvider,
    required this.title,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  final Size size;
  final ThemeProvider themeProvider;
  final String title;
  final void Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width * 0.43,
        height: size.height * 0.23,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, stops: const [
            0.5,
            1
          ], colors: [
            themeProvider.themeMode().kPrimaryColor!.withOpacity(0.2),
            themeProvider.themeMode().kPrimaryColor!.withOpacity(0.4),
          ]),
          borderRadius: BorderRadius.circular(padding * 1.4),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: themeProvider.themeMode().kPrimaryColor,
                    shape: BoxShape.circle),
                child: Icon(
                  icon,
                  color: themeProvider.themeMode().kColorWhite,
                  size: buttonHeight * 0.6,
                ),
              ),
            ),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: themeProvider.textTheme().headline2?.copyWith(
                      color: themeProvider.themeMode().kQwikColor,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WalletActionWidgets extends StatelessWidget {
  const WalletActionWidgets({
    Key? key,
    required this.size,
    required this.themeProvider,
    required this.icon,
    this.onTap,
    required this.title,
  }) : super(key: key);

  final Size size;
  final ThemeProvider themeProvider;
  final IconData icon;
  final void Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width * 0.21,
        height: size.width * 0.2,
        decoration: BoxDecoration(
          color: themeProvider.themeMode().kPrimaryColor,
          borderRadius: BorderRadius.circular(padding * 1.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: themeProvider.themeMode().kColorWhite,
              size: buttonHeight * 0.6,
            ),
            Text(title,
                style: themeProvider.textTheme().bodyText1?.copyWith(
                      color: themeProvider.themeMode().kColorWhite,
                    ))
          ],
        ),
      ),
    );
  }
}
