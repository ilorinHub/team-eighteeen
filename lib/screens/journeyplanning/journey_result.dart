import 'package:egov/screens/journeyplanning/plan_journey_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JourneyResultView extends ConsumerWidget {
  const JourneyResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(children: [
            ExpansionTile(
              title: const Text('Route A'),
              subtitle: Row(
                children: const [
                  Text('total cost: \$2000'),
                  Text("distance: 4.1km")
                ],
              ),
              trailing: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_downward)),
              children: [
                const SizedBox(width: 200, height: 200, child: Placeholder()),
                ListTile(
                  title: const Text('Bus from first roundabout to Karo'),
                  leading: const Icon(Icons.bus_alert),
                  trailing: const Text('time: 8:00AM'),
                  subtitle: Row(
                    children: const [
                      Text('cost: 900'),
                      Text('distance: 90m'),
                    ],
                  ),
                ),
                const ListTile(
                  title: Text('Transit'),
                  leading: Icon(Icons.spatial_tracking),
                  subtitle: Text('duration: 10 mins approx'),
                ),
                const ListTile(
                  title: Text('Taxi from first Karo to Maraba'),
                  leading: Icon(Icons.car_repair_outlined),
                  subtitle: Text('time: 8:45AM'),
                  trailing: Text('cost: 500'),
                ),
                const ListTile(
                  title: Text('Transit'),
                  leading: Icon(Icons.spatial_tracking),
                  subtitle: Text('duration: 1 min approx'),
                ),
                const ListTile(
                  title: Text('Tricycle from Maraba to Apo'),
                  leading: Icon(Icons.car_repair_outlined),
                  subtitle: Text('time: 9:05AM'),
                  trailing: Text('cost: 400'),
                ),
              ],
            )
          ]),
        )),
      ),
    );
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
