import 'package:egov/screens/journeyplanning/plan_journey_view.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:egov/shared/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JourneyResultView extends ConsumerWidget {
  const JourneyResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            ExpansionTile(
              title: Text(
                'Route A',
                style: TextStyle(
                  fontSize: textFontSize,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    'total cost: \$2000',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                  Text(
                    "distance: 4.1km",
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  )
                ],
              ),
              trailing: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_downward)),
              children: [
                const SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: MapWidget(
                      showLocationIcon: false,
                      showMarkers: true,
                    )),
                HSpace(horizontalPadding),
                ListTile(
                  title: Text(
                    'Bus from first roundabout to Karo',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                  leading: const Icon(Icons.bus_alert),
                  trailing: Text(
                    'time: 8:00AM',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                  subtitle: Text(
                    'cost: 900\nDistance: 90m',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Transit',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                  leading: const Icon(Icons.spatial_tracking),
                  subtitle: Text(
                    'duration: 10 mins approx',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Taxi from first Karo to Maraba',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                  leading: const Icon(Icons.car_repair_outlined),
                  subtitle: Text(
                    'time: 8:45AM',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                  trailing: Text(
                    'cost: 500',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Transit',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                  leading: const Icon(Icons.spatial_tracking),
                  subtitle: Text(
                    'duration: 1 min approx',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Tricycle from Maraba to Apo',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                  leading: const Icon(Icons.car_repair_outlined),
                  subtitle: Text(
                    'time: 9:05AM',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                  trailing: Text(
                    'cost: 400',
                    style: TextStyle(
                      fontSize: textFontSize,
                    ),
                  ),
                ),
              ],
            )
          ]),
        ));
  }
}

final routeCalculator =
    FutureProvider.family<void, RouteInfo>((ref, routeInfo) async {
  //calculate Route information here, return the markers, polylines, and information for this
});

class RouteInfo {
  LatLng start;
  LatLng stop;
  RouteOptions optimization;
  RouteInfo({
    required this.start,
    required this.stop,
    required this.optimization,
  });
}
