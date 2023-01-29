import 'package:egov/screens/bookride/ride_book_view.dart';
import 'package:egov/screens/journeyplanning/journey_result.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:location/location.dart';

class PlanJourneyView extends ConsumerWidget {
  const PlanJourneyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Plan a trip"),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton(
                isExpanded: true,
                value: ref.watch(selectedLocation),
                items: _Locations.values
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          describeEnum(e),
                          style: TextStyle(fontSize: textFontSize),
                        )))
                    .toList(),
                onChanged: (selectedlocation) async {
                  ref.watch(selectedLocation.notifier).state =
                      selectedlocation!;
                }),
          ),
          ref.watch(selectedLocation) == _Locations.search
              ? SearchGooglePlacesWidget(
                  placeholder: 'Enter starting point',
                  apiKey: 'AIzaSyAor7DamjJerzkBJnD7vtbrmSOFQm3DKAA',
                  language: 'en',
                  onSelected: (Place place) async {
                    final geolocation = await place.geolocation;
                    final latlng = geolocation!.coordinates as LatLng;

                    ref.watch(startDestination.notifier).state = latlng;
                  },
                  onSearch: (Place place) {},
                )
              : Container(),
          SearchGooglePlacesWidget(
            placeholder: 'Enter Destination location',
            apiKey: 'AIzaSyAor7DamjJerzkBJnD7vtbrmSOFQm3DKAA',
            language: 'en',
            onSelected: (Place place) async {
              final geolocation = await place.geolocation;
              final latlng = geolocation!.coordinates as LatLng;
              ref.watch(destinationPosition.notifier).state = latlng;
            },
            onSearch: (Place place) {},
          ),
          RadioGroup<RouteOptions>.builder(
            direction: Axis.horizontal,
            horizontalAlignment: MainAxisAlignment.start,
            activeColor: primaryColor,
            groupValue: ref.watch(selectedOptimization),
            onChanged: (value) =>
                ref.watch(selectedOptimization.notifier).state = value!,
            items: RouteOptions.values,
            itemBuilder: (item) => RadioButtonBuilder(
              describeEnum(item),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                var time = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                time != null
                    ? ref.watch(_selectedBusTime.notifier).state = time
                    : null;
              },
              child: const Text("Pick Time")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (buildcontext) {
                  return const JourneyResultView();
                }));
              },
              child: const Text("Calculate"))
        ]));
  }

  Future<LatLng> getCurrentLocation() async {
    var location = (await Location().getLocation());
    return LatLng(location.latitude!, location.longitude!);
  }
}

enum _Locations { currentLocation, search }

final selectedLocation = StateProvider((ref) => _Locations.currentLocation);
final selectedOptimization = StateProvider((ref) => RouteOptions.price);
final startingPosition = StateProvider<LatLng>((ref) => const LatLng(0, 0));
final destinationPosition = StateProvider<LatLng>((ref) => const LatLng(0, 0));
final _selectedBusTime = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());
// Users should be able to plan their journey using fare infomritaton

enum RouteOptions { price, time }
