import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'mainApp/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'eTransport App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LocationView(),
      home: const MainApp(),
    );
  }
}

// 3:30 pm to maitama
final getRoute = FutureProvider((ref) async {
  return Future.delayed(
      const Duration(seconds: 5),
      () => {
            // Let k be a field between 23 axis labelled between 1 and 45
          });
});

final gg = FutureProvider<Position>((ref) async {
  bool serviceEnabled;
  LocationPermission permission;
  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    debugPrint("LOCATION SERVICE NOT ENABLED");
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      debugPrint("PERMISSIN DENIED");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    debugPrint(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  var location = await Geolocator.getCurrentPosition();
  return location;
});
final geolocator = FutureProvider((ref) async {
  var url = Uri.https('googleapis.com',
      'geolocation/v1/geolocate?key=AIzaSyAor7DamjJerzkBJnD7vtbrmSOFQm3DKAA');
  var response = await http.post(url);
  debugPrint(jsonDecode(response.body));
});

final liveLocationStream =
    StreamProvider.family<Stream<TestLocation>, TestLocation>(
        (ref, currentLocation) async* {
  // return Geolocator.getPositionStream();

  yield Stream.periodic(const Duration(seconds: 1), (_) {
    return TestLocation(
        latitude: currentLocation.latitude + 0.01,
        longitude: currentLocation.longitude);
  });
});

class TestLocation {
  double latitude;
  double longitude;
  TestLocation({
    required this.latitude,
    required this.longitude,
  });
}

// geolocator and google maps location
class LocationView extends ConsumerWidget {
  LocationView({Key? key}) : super(key: key);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TestLocation liveLocation = TestLocation(latitude: 0, longitude: 0);
    return ref.watch(gg).when(data: (data) {
      debugPrint(data.latitude.toString());
      debugPrint(data.longitude.toString());
      return ref
          .watch(liveLocationStream(
              TestLocation(latitude: data.latitude, longitude: data.longitude)))
          .when(
              data: (data2) {
                data2.listen((data) {
                  liveLocation = data;
                });
                return SafeArea(
                    child: Scaffold(
                  body: GoogleMap(
                    markers: {
                      Marker(
                        markerId: const MarkerId('first'),
                        position: const LatLng(10, 11),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen),
                      ),
                      const Marker(
                        markerId: MarkerId('second'),
                        position: LatLng(11, 11),
                      ),
                      const Marker(
                        markerId: MarkerId('third'),
                        position: LatLng(12, 11),
                      ),
                      Marker(
                          markerId: const MarkerId('liveLocation'),
                          position: LatLng(
                              liveLocation.latitude, liveLocation.longitude))
                    },
                    initialCameraPosition: CameraPosition(
                        target: LatLng(data.latitude, data.longitude)),
                    mapType: MapType.normal,
                    onMapCreated: ((controller) =>
                        _controller.complete(controller)),
                  ),
                ));
              },
              error: (error, st) {
                return const Center(child: Text("ERROR"));
              },
              loading: () => const SafeArea(
                    child: Scaffold(
                        body: Center(
                            child: CircularProgressIndicator.adaptive())),
                  ));
    }, error: (error, st) {
      return const Scaffold(
        body: Center(child: Text("ERROR")),
      );
    }, loading: () {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator.adaptive()));
    });
  }
}


//get current location --DONE
//plot it on a map --DONE
//get multiple locations, plot them --DONE
//update certain locations via a stream and watch the live update
//view attached information on clicking
//route from one point to another
//get multiple routes
//Journey planning