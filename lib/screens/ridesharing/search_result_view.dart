import 'package:egov/screens/ridesharing/share_ride_view.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:egov/shared/utils/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareRideSearchResult extends ConsumerWidget {
  const ShareRideSearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: ref.watch(selectedRide) == SharableRides.bus
              ? [
                  // bus result
                  Text(ref.watch(selectedBusTime).toString()),
                  const ListTile(
                    leading: Icon(Icons.bus_alert),
                    title: Text("Name: AVG445"),
                    subtitle: Text("Estimated time of Arrival: 4:15PM"),
                    trailing: Text("Current Capacity: 12"),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Text("500 naira"),
                    trailing: ElevatedButton(
                        onPressed: () {
                          //
                          showDialog(
                              context: context,
                              builder: (buildcontext) {
                                return SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Column(
                                      children: [
                                        const Text("Confirm Booking"),
                                        ButtonBar(
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Confirm"))
                                          ],
                                        )
                                      ],
                                    ));
                              });
                        },
                        child: const Text("Book now")),
                  )
                ]
              : [
                  //taxi result
                  Text(
                    "Available Cars",
                    style: TextStyle(fontSize: header2FontSize),
                  ),
                  const Divider(),

                  ListTile(
                    leading: const Text("3 mins away"),
                    title: const Text("Af45-DF7"),
                    subtitle: const Text("${naira}150"),
                    trailing: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (buildcontext) {
                                return Center(
                                  child: Material(
                                    child: ClipRRect(
                                      child: SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("Confirm Booking"),
                                              ButtonBar(
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text("Cancel")),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text("Confirm"))
                                                ],
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: const Text("Book now")),
                  )
                ],
        ));
  }
}
