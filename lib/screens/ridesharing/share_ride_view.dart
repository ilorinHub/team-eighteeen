import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:location/location.dart';

import 'search_result_view.dart';

class ShareRideView extends ConsumerWidget {
  const ShareRideView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getlocation).when(data: (data) {
      return Scaffold(
          body: Column(
        children: [
          RadioGroup<SharableRides>.builder(
            direction: Axis.horizontal,
            groupValue: ref.watch(selectedRide),
            onChanged: (value) =>
                ref.watch(selectedRide.notifier).state = value!,
            items: SharableRides.values,
            itemBuilder: (item) => RadioButtonBuilder(
              describeEnum(item),
            ),
          ),
          ref.watch(selectedRide) == SharableRides.bus
              ? DropdownButton(
                  hint: const Text("Select Bus Stop"),
                  items: BusStops.values
                      .map((e) => DropdownMenuItem(
                          value: e, child: Text(describeEnum(e))))
                      .toList(),
                  onChanged: (selected) {
                    ref.watch(selectedBusStop.notifier).state = selected!;
                  })
              : SearchGooglePlacesWidget(
                  placeholder: 'Enter pickup point',
                  apiKey: 'AIzaSyAor7DamjJerzkBJnD7vtbrmSOFQm3DKAA',
                  language: 'en',
                  location: LatLng(data.latitude!, data.longitude!),
                  radius: 3000,
                  onSelected: (Place place) async {
                    final geolocation = await place.geolocation;
                  },
                  onSearch: (Place place) {},
                ),
          ref.watch(selectedRide) == SharableRides.bus
              ? ElevatedButton(
                  onPressed: () async {
                    var time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    time != null
                        ? ref.watch(selectedBusTime.notifier).state = time
                        : null;
                  },
                  child: const Text("Pick Time"))
              : Container(),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ShareRideSearchResult()));
              },
              child: const Text("Search..."))
        ],
      ));
    }, error: (er, st) {
      return Container();
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
  }
}

final selectedRide = StateProvider((ref) => SharableRides.taxi);
final selectedBusStop = StateProvider((ref) => BusStops.first);
final selectedBusTime = StateProvider((ref) => TimeOfDay.now());
final getlocation = FutureProvider((ref) async {
  return await Location().getLocation();
});

enum SharableRides { bike, bus, taxi }

enum BusStops { first, second, third, fourth, fifth }
