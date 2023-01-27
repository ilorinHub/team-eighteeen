import 'package:egov/screens/dashboard/widgets/rider_dash_drawer.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:egov/shared/widgets/drawer_button.dart';
import 'package:flutter/material.dart';

class RiderDashBoard extends StatefulWidget {
  static const String routeName = '/rider_dash';
  const RiderDashBoard({super.key});

  @override
  State<RiderDashBoard> createState() => _RiderDashBoardState();
}

class _RiderDashBoardState extends State<RiderDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: horizontalPadding),
          child: const RiderDrawerButton(),
        ),
      ),
      drawer: const RiderDashBoardDrawer(),
    );
  }
}
