import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RideDetailsView extends ConsumerWidget {
  const RideDetailsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(geolocatorContStaNotiPro).when(data: (data) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Scaffold(
              body: Column(
            children: [
              SizedBox(
                width: 275,
                height: 275,
                child: GoogleMap(
                    markers: {
                      Marker(
                          markerId: const MarkerId('liveLocation'),
                          position: LatLng(data.latitude, data.longitude))
                    },
                    initialCameraPosition: CameraPosition(
                        zoom: 13,
                        target: LatLng(data.latitude, data.longitude))),
              ),
              const Text("TOTAl Cost is 900"),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text("Call driver"),
                onTap: () {
                  //call the driver
                },
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Cancel Trip"))
            ],
          )),
        ),
      );
    }, error: (error, st) {
      return const Center(child: Text("ERROR"));
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    });
  }
}

final currentLocation =
    FutureProvider.family<LocationData, Location>((ref, location) async {
  return await location.getLocation();
});

final geolocatorContStaNotiPro = StateNotifierProvider.autoDispose<
    GeolocatorContStaNoti, AsyncValue<Position>>(
  (ref) => GeolocatorContStaNoti(const AsyncValue.loading())
    ..getContinuousLocation(),
);

class GeolocatorContStaNoti extends StateNotifier<AsyncValue<Position>> {
  GeolocatorContStaNoti(AsyncValue<Position> state) : super(state);

  Future<void> getContinuousLocation() async {
    try {
      if (await checkPermission()) {
        final position = await Geolocator.getCurrentPosition();
        state = AsyncValue.data(position);
      }
      // ignore: nullable_type_in_catch_clause
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
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
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
