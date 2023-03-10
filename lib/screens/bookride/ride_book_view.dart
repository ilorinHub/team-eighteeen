import 'dart:async';

import 'package:egov/core/models/geocoding/geo.dart';
import 'package:egov/core/services/map/geolocating_methods.dart';
import 'package:egov/screens/bookride/ride_book_progress_view.dart';
import 'package:egov/shared/utils/resources/colors.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:egov/shared/utils/resources/strings.dart';
import 'package:egov/shared/widgets/primary_btn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:group_radio_button/group_radio_button.dart';

class BookRideView extends ConsumerWidget {
  static const String routeName = '/book_review';
  BookRideView({super.key});
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markersSet = {};
  final firstLocation = const LatLng(8.476743732549302, 4.56834457160564);
  final secondLocation = const LatLng(8.470959396000517, 4.564097819344169);
  final third = const LatLng(8.480531112683396, 4.550279078988629);
  final fourth = const LatLng(8.482610966365126, 4.551824031257188);
  final fifth = const LatLng(8.479788305038483, 4.558025298578856);
  final sixth = const LatLng(8.475385441297309, 4.566134431554785);
  final seven = const LatLng(8.474535747865858, 4.56706970858443);
  final eigth = const LatLng(8.472519520986708, 4.569000898920136);
  final nine = const LatLng(8.480584365065416, 4.567584692673957);
  final ten = const LatLng(8.47413250333565, 4.561125933884566);
  final eleven = const LatLng(8.475236118939602, 4.556469619408492);
  final twelve = const LatLng(8.480584365065416, 4.560374915420683);
  final thirtheen = const LatLng(8.48003256533672, 4.56443041512565);
  final fourteen = const LatLng(8.481082911665922, 4.55549329347205);
  final fi15 = const LatLng(8.48333254559365, 4.558003840908459);
  final i16 = const LatLng(8.48333254559365, 4.552575050298106);
  final i17 = const LatLng(8.483077870715912, 4.5661362979887885);
  final i18 = const LatLng(8.482504851623665, 4.570148882352963);
  final i19 = const LatLng(8.484754477224547, 4.5665010783855315);
  final i20 = const LatLng(8.472572384939681, 4.566265044011169);
  final List<double> longitudes = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton(
                  value: ref.watch(selectedLocation),
                  isExpanded: true,
                  items: _Locations.values
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            describeEnum(e),
                            style: TextStyle(fontSize: textFontSize),
                          )))
                      .toList(),
                  onChanged: (selectedlocation) {
                    ref.watch(selectedLocation.notifier).state =
                        selectedlocation!;
                  }),
            ),
            ref.watch(selectedLocation) == _Locations.search
                ? SearchGooglePlacesWidget(
                    placeholder: 'Enter pickup point',
                    apiKey: 'AIzaSyAor7DamjJerzkBJnD7vtbrmSOFQm3DKAA',
                    language: 'en',
                    location: const LatLng(10, 11),
                    radius: 3000,
                    onSelected: (Place place) async {
                      final geolocation = await place.geolocation;
                      final latlng = geolocation!.coordinates as LatLng;
                      final GoogleMapController controller =
                          await _controller.future;
                      controller.animateCamera(
                          CameraUpdate.newLatLng(geolocation.coordinates));
                      controller.animateCamera(
                          CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                      ref.watch(startDestination.notifier).state = latlng;
                    },
                    onSearch: (Place place) {},
                  )
                : Container(),
            HSpace(20..h),
            SearchGooglePlacesWidget(
              placeholder: 'Enter destination',
              apiKey: 'AIzaSyAor7DamjJerzkBJnD7vtbrmSOFQm3DKAA',
              language: 'en',
              location: const LatLng(10, 11),
              radius: 3000,
              onSelected: (Place place) async {
                final geolocation = await place.geolocation;
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newLatLng(geolocation!.coordinates));
                controller.animateCamera(
                    CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                //
                await loadMarkers(
                    ref: ref,
                    origin: GeoDetails(
                        latitude: ref.watch(startDestination).latitude,
                        longitude: ref.watch(startDestination).longitude),
                    destination: GeoDetails(
                        latitude: (geolocation.coordinates as LatLng).latitude,
                        longitude:
                            (geolocation.coordinates as LatLng).longitude));
                ref.watch(polylines.notifier).state =
                    await getPolyLinesAndDistance(
                        true, await _controller.future,
                        origin:
                            GeoDetails(
                                latitude: ref.watch(startDestination).latitude,
                                longitude:
                                    ref.watch(startDestination).longitude),
                        destination: GeoDetails(
                            latitude:
                                (geolocation.coordinates as LatLng).latitude,
                            longitude:
                                (geolocation.coordinates as LatLng).longitude),
                        ref: ref);
              },
              onSearch: (Place place) {},
            ),
            RadioGroup<TransportationTypes>.builder(
              direction: Axis.horizontal,
              groupValue: ref.watch(selectedTransport),
              activeColor: primaryColor,
              onChanged: (value) =>
                  ref.watch(selectedTransport.notifier).state = value!,
              items: TransportationTypes.values,
              horizontalAlignment: MainAxisAlignment.center,
              textStyle: TextStyle(fontSize: textFontSize * 0.9),
              itemBuilder: (item) => RadioButtonBuilder(
                describeEnum(item),
              ),
            ),
            HSpace(20..h),
            SizedBox(
              height: 400,
              width: 400,
              child: GoogleMap(
                polylines: ref.watch(polylines),
                markers: ref.watch(updateMarkers).toSet()
                  ..addAll(getMarkers(ref.watch(selectedTransport))),
                initialCameraPosition:
                    const CameraPosition(target: LatLng(10, 11), zoom: 7),
                mapType: MapType.normal,
                onMapCreated: ((controller) =>
                    _controller.complete(controller)),
              ),
            ),
            HSpace(20..h),
            Text('$naira${ref.watch(pricesUpdater)}'),
            HSpace(20..h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: EGOvButton(
                hasIcon: false,
                loading: false,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RideBookingProgress()));
                },
                text: 'Proceed',
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> loadMarkers(
      {required GeoDetails origin,
      required GeoDetails destination,
      required WidgetRef ref}) async {
    _markersSet.clear();
    final pickUpCordinate = origin;
    final deliveryCordinates = destination;
    final List<LatLng> latLen = [
      LatLng(pickUpCordinate.latitude!, pickUpCordinate.longitude!),
      LatLng(deliveryCordinates.latitude!, deliveryCordinates.longitude!),
    ];

    Marker pickUpLocationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(10),
      infoWindow: const InfoWindow(title: '', snippet: "Pickup location"),
      position: latLen[0],
      markerId: const MarkerId("pickUpId"),
    );
    Marker dropOffLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(10),
        infoWindow: const InfoWindow(title: '', snippet: "Destination"),
        position: latLen[1],
        markerId: const MarkerId("dropOffId"));

    for (int i = 0; i < 2; i++) {
      ref.watch(updateMarkers.notifier).addtoMarker(pickUpLocationMarker);
      ref.watch(updateMarkers.notifier).addtoMarker(dropOffLocationMarker);
      // _markersSet.add(pickUpLocationMarker);
      // _markersSet.add(dropOffLocationMarker);
    }
    debugPrint("MARKERS ARE:");
    var rp = ref.read(updateMarkers);
    for (var element in rp) {
      debugPrint(element.toString());
    }

    // return _markersSet;
  }

  Future<Set<Polyline>> getPolyLinesAndDistance(
      bool updateMap, GoogleMapController newGoogleMapController,
      {required GeoDetails origin,
      required GeoDetails destination,
      required WidgetRef ref}) async {
    JourneyDetails? tripDirectionDetails;
    List<LatLng> polyLineCoordinates = [];
    final Set<Polyline> polylineSet = {};

    final result = await GoogleGeolocatingApi.obtainPlaceDirectionDetails(
        origin, destination);
    if (result.distanceText != null) {
      tripDirectionDetails = result;
      PolylinePoints polyLinePoints = PolylinePoints();
      List<PointLatLng> decodedPolyLinePointsResult =
          polyLinePoints.decodePolyline(tripDirectionDetails.encodedPoints!);
      polyLineCoordinates.clear();
      if (decodedPolyLinePointsResult.isNotEmpty) {
        for (var pointLatLng in decodedPolyLinePointsResult) {
          polyLineCoordinates
              .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
        }
      }
      int i = 0;
      polylineSet.clear();
      for (i = 0; i < polyLineCoordinates.length; i++) {
        Polyline polyLine = Polyline(
          color: Colors.blue,
          polylineId: const PolylineId("PolylineID"),
          jointType: JointType.mitered,
          points: polyLineCoordinates,
          width: 4,
          geodesic: false,
          zIndex: 0,
        );
        polylineSet.add(polyLine);
      }
      if (updateMap) {
        LatLngBounds latLngBounds;
        final LatLng pickup = LatLng(origin.latitude!, origin.longitude!);
        final LatLng delivery =
            LatLng(destination.latitude!, destination.longitude!);

        if (pickup.latitude > delivery.latitude &&
            pickup.longitude > delivery.longitude) {
          latLngBounds = LatLngBounds(southwest: delivery, northeast: pickup);
        } else if (pickup.longitude > delivery.longitude) {
          latLngBounds = LatLngBounds(
              southwest: LatLng(pickup.latitude, delivery.longitude),
              northeast: LatLng(delivery.latitude, pickup.longitude));
        } else if (pickup.latitude > delivery.latitude) {
          latLngBounds = LatLngBounds(
              southwest: LatLng(delivery.latitude, pickup.longitude),
              northeast: LatLng(pickup.latitude, delivery.longitude));
        } else {
          latLngBounds = LatLngBounds(northeast: delivery, southwest: pickup);
        }

        newGoogleMapController
            .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 50));

        // await loadMarkers(origin: origin, destination: destination, ref: ref);
      }
    }
    return polylineSet;
  }

  getMarkers(TransportationTypes selected) {
    switch (selected) {
      case TransportationTypes.bike:
        return {
          Marker(
            markerId: const MarkerId('first'),
            position: firstLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
          Marker(
            markerId: const MarkerId('second'),
            position: secondLocation,
          ),
          Marker(
            markerId: const MarkerId('third'),
            position: third,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
          Marker(markerId: const MarkerId('fourth'), position: fourth),
          Marker(
            markerId: const MarkerId('fifth'),
            position: fifth,
          ),
        };
      case TransportationTypes.bus:
        return {
          Marker(
            markerId: const MarkerId('sixth'),
            position: sixth,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
          Marker(markerId: const MarkerId('7'), position: seven),
          Marker(
            markerId: const MarkerId('8'),
            position: eigth,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
          Marker(
            markerId: const MarkerId('9'),
            position: nine,
          ),
          Marker(
            markerId: const MarkerId('10'),
            position: ten,
          ),
        };
      case TransportationTypes.tricycle:
        return {
          Marker(
            markerId: const MarkerId('11'),
            position: eleven,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
          Marker(
            markerId: const MarkerId('12'),
            position: twelve,
          ),
          Marker(
            markerId: const MarkerId('13'),
            position: thirtheen,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
          Marker(
            markerId: const MarkerId('14'),
            position: fourteen,
          ),
          Marker(markerId: const MarkerId('15'), position: fi15),
        };
      case TransportationTypes.taxi:
        return {
          Marker(
            markerId: const MarkerId('16'),
            position: i16,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
          Marker(
            markerId: const MarkerId('17'),
            position: i17,
          ),
          Marker(
            markerId: const MarkerId('18'),
            position: i18,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
          Marker(
            markerId: const MarkerId('19'),
            position: i19,
          ),
          Marker(
            markerId: const MarkerId('20'),
            position: i20,
          ),
        };
    }
  }
}

enum _Locations { currentLocation, search }

final updateMarkers = StateNotifierProvider<MarkersList, List<Marker>>((ref) {
  return MarkersList();
});
final selectedLocation = StateProvider((ref) => _Locations.currentLocation);
final startDestination = StateProvider((ref) => const LatLng(0, 0));
final polylines = StateProvider((ref) => <Polyline>{});
final selectedTransport = StateProvider((ref) => TransportationTypes.taxi);
final pricesUpdater = StateProvider((ref) {
  switch (ref.watch(selectedTransport)) {
    case TransportationTypes.bus:
      return '500';
    case TransportationTypes.tricycle:
      return '100';
    case TransportationTypes.taxi:
      return '1000';
    case TransportationTypes.bike:
      return '250';
  }
});

enum TransportationTypes { bus, tricycle, taxi, bike }

class MarkersList extends StateNotifier<List<Marker>> {
  MarkersList() : super([]);

  addtoMarker(Marker marker) {
    state = [...state, marker];
  }

  removeMarker(Marker marker) {
    state = [
      for (final m in state)
        if (m.markerId != marker.markerId) m,
    ];
  }
}
