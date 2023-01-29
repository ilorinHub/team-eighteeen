import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [statistics(context), mapView(context)],
    ));
  }

  Widget statistics(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("TAXI", style: TextStyle(fontSize: 15)),
                        SizedBox(
                          width: 250,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Bookings made: 4,087"),
                            leading: Icon(Icons.note),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Amount made: 1.2M"),
                            leading: Icon(Icons.currency_bitcoin),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Average rating: 3.4 stars"),
                            leading: Icon(Icons.star),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("BUS", style: TextStyle(fontSize: 15)),
                        SizedBox(
                          width: 250,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Bookings made: 6,087"),
                            leading: Icon(Icons.note),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Amount made: 2.2M"),
                            leading: Icon(Icons.currency_bitcoin),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Average rating: 3.0 stars"),
                            leading: Icon(Icons.star),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("BIKE", style: TextStyle(fontSize: 15)),
                        SizedBox(
                          width: 200,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Bookings made: 8,087"),
                            leading: Icon(Icons.note),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Amount made: 1.0M"),
                            leading: Icon(Icons.currency_bitcoin),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Average rating: 2 stars"),
                            leading: Icon(Icons.star),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("TRICYCLE", style: TextStyle(fontSize: 15)),
                        SizedBox(
                          width: 200,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Bookings made: 7,087"),
                            leading: Icon(Icons.note),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Amount made: 6.2M"),
                            leading: Icon(Icons.currency_bitcoin),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: ListTile(
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(4.0),
                            title: Text("Average rating: 4.4 stars"),
                            leading: Icon(Icons.star),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }

  Widget mapView(BuildContext context) {
    return FutureBuilder(
        future: getMarkers(),
        builder: (context, sh) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              height: 350,
              child: GoogleMap(
                  markers: sh.hasData ? sh.data as Set<Marker> : {},
                  initialCameraPosition: const CameraPosition(
                      target: LatLng(8.476743732549302, 4.56834457160564),
                      zoom: 15)),
            ),
          );
        });
  }

  Future<Set<Marker>> getMarkers() async {
    final Set<Marker> markersSet = {};
    var firstLocation = const LatLng(8.476743732549302, 4.56834457160564);
    var secondLocation = const LatLng(8.470959396000517, 4.564097819344169);
    var third = const LatLng(8.480531112683396, 4.550279078988629);
    var fourth = const LatLng(8.482610966365126, 4.551824031257188);
    var fifth = const LatLng(8.479788305038483, 4.558025298578856);
    var sixth = const LatLng(8.475385441297309, 4.566134431554785);
    var seven = const LatLng(8.474535747865858, 4.56706970858443);
    var eigth = const LatLng(8.472519520986708, 4.569000898920136);
    var nine = const LatLng(8.480584365065416, 4.567584692673957);
    var ten = const LatLng(8.47413250333565, 4.561125933884566);
    var eleven = const LatLng(8.475236118939602, 4.556469619408492);
    var twelve = const LatLng(8.480584365065416, 4.560374915420683);
    var thirtheen = const LatLng(8.48003256533672, 4.56443041512565);
    var fourteen = const LatLng(8.481082911665922, 4.55549329347205);
    var fi15 = const LatLng(8.48333254559365, 4.558003840908459);
    var i16 = const LatLng(8.48333254559365, 4.552575050298106);
    var i17 = const LatLng(8.483077870715912, 4.5661362979887885);
    var i18 = const LatLng(8.482504851623665, 4.570148882352963);
    var i19 = const LatLng(8.484754477224547, 4.5665010783855315);
    var i20 = const LatLng(8.472572384939681, 4.566265044011169);
    BitmapDescriptor busicon = BitmapDescriptor.defaultMarker;
    BitmapDescriptor taxiIcon = BitmapDescriptor.defaultMarker;
    BitmapDescriptor tricycleIcon = BitmapDescriptor.defaultMarker;
    BitmapDescriptor bikeIcon = BitmapDescriptor.defaultMarker;
    busicon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), 'assets/images/bus.png');
    taxiIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), 'assets/images/taxi.png');
    tricycleIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/images/tricycle.png');
    bikeIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), 'assets/images/bike.png');
    markersSet.add(Marker(
        markerId: const MarkerId('1'), position: firstLocation, icon: busicon));
    markersSet.add(Marker(
        markerId: const MarkerId('2'),
        position: secondLocation,
        icon: busicon));
    markersSet.add(
        Marker(markerId: const MarkerId('3'), position: third, icon: busicon));
    markersSet.add(
        Marker(markerId: const MarkerId('4'), position: fourth, icon: busicon));
    markersSet.add(
        Marker(markerId: const MarkerId('5'), position: fifth, icon: busicon));
    markersSet.add(
        Marker(markerId: const MarkerId('6'), position: sixth, icon: taxiIcon));
    markersSet.add(
        Marker(markerId: const MarkerId('7'), position: seven, icon: taxiIcon));
    markersSet.add(
        Marker(markerId: const MarkerId('8'), position: eigth, icon: taxiIcon));
    markersSet.add(
        Marker(markerId: const MarkerId('9'), position: nine, icon: taxiIcon));
    markersSet.add(
        Marker(markerId: const MarkerId('10'), position: ten, icon: taxiIcon));
    markersSet.add(Marker(
        markerId: const MarkerId('11'), position: eleven, icon: tricycleIcon));
    markersSet.add(Marker(
        markerId: const MarkerId('12'), position: twelve, icon: tricycleIcon));
    markersSet.add(Marker(
        markerId: const MarkerId('13'),
        position: thirtheen,
        icon: tricycleIcon));
    markersSet.add(Marker(
        markerId: const MarkerId('14'),
        position: fourteen,
        icon: tricycleIcon));
    markersSet.add(Marker(
        markerId: const MarkerId('15'), position: fi15, icon: tricycleIcon));

    markersSet.add(
        Marker(markerId: const MarkerId('16'), position: i16, icon: bikeIcon));
    markersSet.add(
        Marker(markerId: const MarkerId('17'), position: i17, icon: bikeIcon));
    markersSet.add(
        Marker(markerId: const MarkerId('18'), position: i18, icon: bikeIcon));
    markersSet.add(
        Marker(markerId: const MarkerId('19'), position: i19, icon: bikeIcon));
    markersSet.add(
        Marker(markerId: const MarkerId('20'), position: i20, icon: bikeIcon));
    return markersSet;
  }
}
