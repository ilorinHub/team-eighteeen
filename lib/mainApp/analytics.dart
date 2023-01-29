import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsView extends ConsumerWidget {
  const AnalyticsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ref.watch(showGraph) == false
            ? ElevatedButton(
                onPressed: () async {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    body: Center(
                      child: Column(children: [
                        const Text("Select the type of graph to be plotted"),
                        DropdownButton(
                            hint: const Text('Select y-axis value'),
                            value: ref.watch(_selectedyAxis),
                            items: yAxis.values
                                .map((e) => DropdownMenuItem(
                                    value: e, child: Text(describeEnum(e))))
                                .toList(),
                            onChanged: (selectedvalue) {
                              ref.watch(_selectedyAxis.notifier).state =
                                  selectedvalue! as yAxis;
                            }),
                        DropdownButton(
                            value: ref.watch(_selectedxAxis),
                            hint: const Text('Select x-axis value'),
                            items: xAxis.values
                                .map((e) => DropdownMenuItem(
                                    value: e, child: Text(describeEnum(e))))
                                .toList(),
                            onChanged: (selectedvalue) {
                              ref.watch(_selectedxAxis.notifier).state =
                                  selectedvalue! as xAxis;
                            })
                      ]),
                    ),
                    btnCancelOnPress: () {
                      // Navigator.of(context).pop();
                    },
                    btnOkOnPress: () {
                      ref.watch(showGraph.notifier).state = true;
                      // Navigator.of(context).pop();
                    },
                  ).show();
                },
                child: const Text("Plot Graph"))
            : graph(context, ref),
        ref.watch(showGraph2) == false
            ? ElevatedButton(
                onPressed: () async {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    body: Center(
                      child: Column(children: [
                        const Text("Select the type of graph to be plotted"),
                        DropdownButton(
                            hint: const Text('Select y-axis value'),
                            value: ref.watch(_selectedyAxis2),
                            items: yAxis.values
                                .map((e) => DropdownMenuItem(
                                    value: e, child: Text(describeEnum(e))))
                                .toList(),
                            onChanged: (selectedvalue) {
                              ref.watch(_selectedyAxis2.notifier).state =
                                  selectedvalue! as yAxis;
                            }),
                        DropdownButton(
                            value: ref.watch(_selectedxAxis2),
                            hint: const Text('Select x-axis value'),
                            items: xAxis.values
                                .map((e) => DropdownMenuItem(
                                    value: e, child: Text(describeEnum(e))))
                                .toList(),
                            onChanged: (selectedvalue) {
                              ref.watch(_selectedxAxis2.notifier).state =
                                  selectedvalue! as xAxis;
                            })
                      ]),
                    ),
                    btnCancelOnPress: () {
                      // Navigator.of(context).pop();
                    },
                    btnOkOnPress: () {
                      ref.watch(showGraph2.notifier).state = true;
                      // Navigator.of(context).pop();
                    },
                  ).show();
                },
                child: const Text("Plot Graph"))
            : graph2(context, ref),
      ],
    )));
  }

  Widget graph(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              ref.watch(showGraph.notifier).state = false;
            },
            child: const Text('reset')),
        SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            height: 400,
            child: const Placeholder()),
      ],
    );
  }

  Widget graph2(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              ref.watch(showGraph2.notifier).state = false;
            },
            child: const Text('Reset')),
        SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            height: 400,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(
                  text:
                      '${ref.watch(_selectedxAxis2)} -vs- ${ref.watch(_selectedyAxis2)}'),
              legend: Legend(isVisible: true),
              series: getDefaultData(),
              tooltipBehavior: TooltipBehavior(enable: true),
            )),
      ],
    );
  }

  static List<LineSeries<SampleData, DateTime>> getDefaultData() {
    final List<SampleData> chartData = <SampleData>[];
    for (int month = 0; month < 2; month++) {
      for (var day = 0; day < 30; day++) {
        chartData.add(SampleData(
          time: DateTime(2022, month, day),
          amount: (Random().nextDouble() + 0.1) * 3,
          rating: Random().nextInt(5).ceilToDouble(),
        ));
      }
    }
    return <LineSeries<SampleData, DateTime>>[
      LineSeries<SampleData, DateTime>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (SampleData data, _) => data.time,
          yValueMapper: (SampleData data, _) => data.amount,
          width: 2,
          markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              borderWidth: 3,
              borderColor: Colors.red),
          dataLabelSettings: const DataLabelSettings(isVisible: true)),
    ];
  }
}

enum yAxis { ratings, money, requests }

enum xAxis { days, month, year, hr }

final showGraph = StateProvider((ref) => false);
final _selectedxAxis = StateProvider((ref) => xAxis.days);
final _selectedyAxis = StateProvider((ref) => yAxis.money);
final buttonshow = StateProvider((ref) => 0);

final showGraph2 = StateProvider((ref) => false);
final _selectedxAxis2 = StateProvider((ref) => xAxis.days);
final _selectedyAxis2 = StateProvider((ref) => yAxis.money);
final buttonshow2 = StateProvider((ref) => 0);

class SampleData {
  DateTime time;
  double amount;
  double rating;
  SampleData({
    required this.time,
    required this.amount,
    required this.rating,
  });
}
