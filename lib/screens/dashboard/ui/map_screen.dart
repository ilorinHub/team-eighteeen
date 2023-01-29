import 'package:egov/core/viewmodels/map_view_model/map_view_model.dart';
import 'package:egov/screens/dashboard/widgets/rider_dash_drawer.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:egov/shared/widgets/drawer_button.dart';
import 'package:egov/shared/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/map_screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MapViewModel>().determineUserCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapViewModel>(builder: (context, value, child) {
      return Stack(
        children: [
          Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: EdgeInsets.only(left: horizontalPadding),
                  child: const RiderDrawerButton(),
                ),
              ),
              drawer: const RiderDashBoardDrawer(),
              body: const MapWidget(showLocationIcon: true, showMarkers: true)),
        ],
      );
    });
  }
}
