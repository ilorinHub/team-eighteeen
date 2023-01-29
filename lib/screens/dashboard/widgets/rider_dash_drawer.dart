import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/screens/dashboard/ui/rider_dashboard.dart';
import 'package:egov/screens/driver/ui/customer_feedback.dart';
import 'package:egov/screens/driver/ui/driver_orders.dart';
import 'package:egov/screens/profile/ui/profile.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RiderDashBoardDrawer extends StatefulWidget {
  const RiderDashBoardDrawer({Key? key}) : super(key: key);

  @override
  State<RiderDashBoardDrawer> createState() => _RiderDashBoardDrawerState();
}

class _RiderDashBoardDrawerState extends State<RiderDashBoardDrawer> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: buttonHeight,
          ),
          EGovDrawerOptions(
            icon: const Icon(Icons.menu),
            themeProvider: themeProvider,
            onTap: () => Navigator.pop(context),
          ),
          const HSpace(24),
          EGovDrawerOptions(
            title: "Dashboard",
            icon: const Icon(Icons.dashboard),
            themeProvider: themeProvider,
            onTap: () {
              Navigator.of(context).popAndPushNamed(
                RiderDashBoard.routeName,
              );
            },
          ),
          const HSpace(24),
          EGovDrawerOptions(
            title: "My Profile",
            icon: const Icon(Icons.person),
            themeProvider: themeProvider,
            onTap: () {
              Navigator.popAndPushNamed(context, ProfileScreen.routeName);
            },
          ),
          const HSpace(24),
          EGovDrawerOptions(
            title: "Orders",
            icon: const Icon(Icons.offline_bolt),
            themeProvider: themeProvider,
            onTap: () {
              Navigator.of(context)
                  .popAndPushNamed(DriverOrdersScreen.routeName);
            },
          ),
          const HSpace(24),
          EGovDrawerOptions(
            title: "Customer Feedback",
            icon: const Icon(Icons.feedback),
            themeProvider: themeProvider,
            onTap: () {
              Navigator.of(context).popAndPushNamed(
                CustomerFeedbackScreen.routeName,
              );
            },
          ),
          const Spacer(),
          EGovDrawerOptions(
            title: "Sign Out",
            onTap: () async {},
            icon: const Icon(Icons.logout),
            themeProvider: themeProvider,
            //   context.read<CustomersViewModel>().disposeValues();
            //   context.read<DriversViewModel>().disposeValues();
            //   setState(() {
            //     _loading = true;
            //   });
            //   await context.read<AuthSessionStateManager>().logout();
            //   Timer(const Duration(milliseconds: 500), () async {
            //     setState(() {
            //       _loading = false;
            //     });

            //     Navigator.of(context).pushNamedAndRemoveUntil(
            //         LoginScreen.routeName, (route) => false);
            //   });
            // },
          ),
          const HSpace(24),
        ],
      ),
    ));
  }
}

class EGovDrawerOptions extends StatelessWidget {
  const EGovDrawerOptions(
      {Key? key,
      this.title = '',
      required this.onTap,
      this.icon,
      this.height,
      required this.themeProvider})
      : super(key: key);
  final String? title;
  final Widget? icon;
  final void Function()? onTap;
  final double? height;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.centerLeft, width: (40), child: icon),
            Text(
              title!,
              style: GoogleFonts.poppins(
                  color: themeProvider.themeMode().kPrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: textFontSize),
            ),
          ],
        ),
      ),
    );
  }
}
