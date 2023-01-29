import 'dart:io';

import 'package:egov/core/viewmodels/map_view_model/map_view_model.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    Key? key,
    required this.showLocationIcon,
    required this.showMarkers,
  }) : super(key: key);
  final bool showLocationIcon, showMarkers;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapViewModel>(builder: (context, viewmodel, _) {
      return Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: viewmodel.initCoordinates,
              zoom: viewmodel.initZoom,
            ),
            onMapCreated: (GoogleMapController controller) {
              if (!viewmodel.controller.isCompleted) {
                viewmodel.controller.complete(controller);
              }
              viewmodel.newGoogleMapController = controller;
            },
            onCameraMove: (CameraPosition newPosition) {
              if (widget.showLocationIcon) {
                viewmodel.value = newPosition.target;
                viewmodel.updatePinMargin();
              }
            },
            onCameraIdle: () async {
              if (widget.showLocationIcon) {
                viewmodel.pinMargin = 0;
                if (mounted) {}
              }
            },
            mapType: MapType.normal,
            myLocationButtonEnabled: widget.showLocationIcon,
            myLocationEnabled: widget.showLocationIcon,
            zoomGesturesEnabled: true,
            padding: EdgeInsets.all(50.h),
            markers: widget.showMarkers
                ? Set<Marker>.of(viewmodel.markers)
                : <Marker>{},
            polylines: widget.showMarkers
                ? Set<Polyline>.of(viewmodel.polylineSet)
                : <Polyline>{},
            buildingsEnabled: true,
            cameraTargetBounds: CameraTargetBounds.unbounded,
            compassEnabled: true,
            indoorViewEnabled: false,
            mapToolbarEnabled: true,
            minMaxZoomPreference: MinMaxZoomPreference.unbounded,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            trafficEnabled: false,
          ),
          if (viewmodel.hasError)
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.w),
                  color: Colors.white,
                ),
                child: Text(
                  viewmodel.error,
                  style: TextStyle(
                    color: colorSkyBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.69..sp,
                  ),
                ),
              ),
            ),
          if (Platform.isAndroid && widget.showLocationIcon)
            Positioned(
              bottom: 30,
              left: 30,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () async {
                    viewmodel.determineUserCurrentPosition();
                    final GoogleMapController controller =
                        await viewmodel.controller.future;
                    controller.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(viewmodel.value.latitude,
                                viewmodel.value.longitude),
                            zoom: viewmodel.initZoom)));
                  },
                  icon: const Icon(
                    Icons.my_location,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
