import 'package:egov/shared/utils/resources/colors.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:egov/shared/widgets/primary_btn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'search_result_view.dart';

class ShareRideView extends ConsumerWidget {
  static const String routeName = '/share_ride';
  const ShareRideView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getlocation).when(data: (data) {
      return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              HSpace(verticalPadding),
              RadioGroup<SharableRides>.builder(
                direction: Axis.horizontal,
                activeColor: primaryColor,
                groupValue: ref.watch(selectedRide),
                onChanged: (value) =>
                    ref.watch(selectedRide.notifier).state = value!,
                items: SharableRides.values,
                itemBuilder: (item) => RadioButtonBuilder(
                  describeEnum(item),
                ),
              ),
              HSpace(verticalPadding),
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
                      location: LatLng(data.latitude, data.longitude),
                      radius: 3000,
                      onSelected: (Place place) async {},
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
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: EGOvButton(
                    hasIcon: false,
                    loading: false,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ShareRideSearchResult()));
                    },
                    text: "Search..."),
              ),
              HSpace(verticalPadding),
            ],
          ));
    }, error: (er, st) {
      return Container();
    }, loading: () {
      return const SizedBox(
          height: 30, width: 30, child: CircularProgressIndicator.adaptive());
    });
  }

  Future<bool> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // state = AsyncValue.error(CustomException(message: "ServiceError"));
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // state = AsyncValue.error(
          // CustomException(message: "DeniedPermissionError"));
        }
      } else if (permission == LocationPermission.whileInUse) {
        return true;
      } else if (permission == LocationPermission.deniedForever) {
        // state =
        //     AsyncValue.error(CustomException(message: "DeniedForeverError"));
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

final selectedRide = StateProvider((ref) => SharableRides.taxi);
final selectedBusStop = StateProvider((ref) => BusStops.first);
final selectedBusTime = StateProvider((ref) => TimeOfDay.now());
final getlocation = FutureProvider((ref) async {
  return const LatLng(6.7, 6.7);
});

enum SharableRides { bike, bus, taxi }

enum BusStops { first, second, third, fourth, fifth }
