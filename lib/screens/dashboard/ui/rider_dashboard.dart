import 'package:egov/core/viewmodels/dashboard/rider_dashboard_viewmodel.dart';
import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/screens/dashboard/ui/dasboard.dart';
import 'package:egov/screens/dashboard/ui/in_demand_routes.dart';
import 'package:egov/screens/dashboard/ui/map_screen.dart';
import 'package:egov/screens/dashboard/widgets/rider_dash_drawer.dart';
import 'package:egov/screens/payment/ui/payment_history.dart';
import 'package:egov/screens/payment/ui/share.dart';
import 'package:egov/screens/payment/ui/withdraw.dart';
import 'package:egov/shared/utils/resources/colors.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:egov/shared/widgets/app_alert.dart';
import 'package:egov/shared/widgets/drawer_button.dart';
import 'package:egov/shared/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RiderDashBoard extends StatefulWidget {
  static const String routeName = '/rider_dash';
  const RiderDashBoard({super.key});

  @override
  State<RiderDashBoard> createState() => _RiderDashBoardState();
}

class _RiderDashBoardState extends State<RiderDashBoard> {
  bool _isAvailable = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    return Consumer<RiderDashboardViewmodel>(builder: (context, value, child) {
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: EdgeInsets.only(left: horizontalPadding),
                child: const RiderDrawerButton(),
              ),
              actions: [
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, InDemandScreen.routeName),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10..h)),
                        child: const Text('View in-demand routes')),
                  ),
                )
              ],
            ),
            drawer: const RiderDashBoardDrawer(),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HSpace(20),
                  WalletWidget(
                      showCurrentRide: false,
                      size: size,
                      themeProvider: themeProvider),
                  HSpace(padding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                          Navigator.pushNamed(
                              context, PaymentHistory.routeName);
                        },
                      ),
                    ],
                  ),
                  HSpace(buttonHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Availability status',
                        style: themeProvider.textTheme().bodyText1,
                      ),
                      Switch(
                          activeColor: themeProvider.themeMode().ktextColor,
                          value: _isAvailable,
                          onChanged: (s) {
                            _isAvailable = s;
                            setState(() {});
                          })
                    ],
                  ),
                  HSpace(padding * 1.5),
                  if (value.newOrderDetailsList.isNotEmpty)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'New Order',
                        style: themeProvider.textTheme().headline2,
                      ),
                    ),
                  HSpace(padding * 1.5),
                  ...value.newOrderDetailsList.map(
                    (e) => NewOrderWidget(
                        themeProvider: themeProvider, newOrderDetails: e),
                  ),
                  if (value.newOrderDetailsList.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.4,
                          child: EGOvButton(
                            hasIcon: false,
                            loading: false,
                            onTap: () async {
                              value.toggleAuthLoading();
                              await Future.delayed(const Duration(seconds: 2),
                                  () {
                                AppAlert.showSuccessMessage(
                                    context: context,
                                    message: 'Order accepted successfully');
                                value.newOrderDetailsList = [];
                                value.toggleAuthLoading();
                                Navigator.pushNamed(
                                    context, MapScreen.routeName);
                              });
                            },
                            text: 'Accept',
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: EGOvButton(
                            hasIcon: false,
                            loading: false,
                            btnColor: Colors.red,
                            onTap: () async {
                              value.toggleAuthLoading();
                              await Future.delayed(const Duration(seconds: 2),
                                  () {
                                AppAlert.showSuccessMessage(
                                    context: context,
                                    message: 'Order cancelled successful');
                                value.newOrderDetailsList = [];
                                value.toggleAuthLoading();
                              });
                            },
                            text: 'Reject',
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
          if (value.loading)
            const Center(
              child: CircularProgressIndicator.adaptive(),
            )
        ],
      );
    });
  }
}

class NewOrderWidget extends StatelessWidget {
  const NewOrderWidget({
    Key? key,
    required this.themeProvider,
    required this.newOrderDetails,
  }) : super(key: key);

  final ThemeProvider themeProvider;
  final NewOrderDetails newOrderDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Name:',
              style: themeProvider.textTheme().bodyText2,
            ),
            Text(
              newOrderDetails.orderName,
              style: themeProvider.textTheme().bodyText1,
            ),
          ],
        ),
        HSpace(verticalPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order destination: ',
              style: themeProvider.textTheme().bodyText2,
            ),
            Text(
              newOrderDetails.orderDestination,
              style: themeProvider.textTheme().bodyText1,
            ),
          ],
        ),
        HSpace(verticalPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pickup location: ',
              style: themeProvider.textTheme().bodyText2,
            ),
            Text(
              newOrderDetails.pickUpLocation,
              style: themeProvider.textTheme().bodyText1,
            ),
          ],
        ),
        HSpace(verticalPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Estimated duration: ',
              style: themeProvider.textTheme().bodyText2,
            ),
            Text(
              newOrderDetails.estimatedDuration,
              style: themeProvider.textTheme().bodyText1,
            ),
          ],
        ),
        HSpace(padding * 2),
      ],
    );
  }
}
