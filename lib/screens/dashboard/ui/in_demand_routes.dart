import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InDemandScreen extends StatefulWidget {
  static const String routeName = "/indemand";
  const InDemandScreen({Key? key}) : super(key: key);

  @override
  State<InDemandScreen> createState() => _InDemandScreenState();
}

class _InDemandScreenState extends State<InDemandScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('In-Demand Routes')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            InDemandRoutesItem(
              themeProvider: themeProvider,
              demand: '1000+',
              lga: 'Ilorin South',
              routeName: 'University Of Ilorin',
              mostFrequentDestination: 'Tanke, Ilorin',
            ),
            InDemandRoutesItem(
              themeProvider: themeProvider,
              demand: '500+',
              lga: 'Ilorin West',
              routeName: 'Untiy Road, Ilorin',
              mostFrequentDestination: 'Offa-Garrage',
            ),
            InDemandRoutesItem(
              themeProvider: themeProvider,
              demand: '100+',
              lga: 'Ilorin South',
              routeName: 'Fate Road, Ilorin',
              mostFrequentDestination: 'Taiwo, Ilorin',
            ),
          ],
        ),
      ),
    );
  }
}

class InDemandRoutesItem extends StatelessWidget {
  const InDemandRoutesItem({
    Key? key,
    required this.themeProvider,
    required this.routeName,
    required this.lga,
    required this.demand,
    required this.mostFrequentDestination,
  }) : super(key: key);

  final ThemeProvider themeProvider;
  final String routeName, lga, demand, mostFrequentDestination;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HSpace(smallVerticalPadding),
        Text(
          'Address: $routeName',
          style: themeProvider.textTheme().bodyText1,
        ),
        HSpace(smallVerticalPadding),
        Text(
          'LGA: $lga',
          style: themeProvider.textTheme().bodyText1,
        ),
        HSpace(smallVerticalPadding),
        Text(
          'Demand: $demand',
          style: themeProvider.textTheme().bodyText1,
        ),
        HSpace(smallVerticalPadding),
        Text(
          'Most frequent destination: $mostFrequentDestination ',
          style: themeProvider.textTheme().bodyText1,
        ),
        HSpace(smallVerticalPadding),
        const Divider(),
        HSpace(smallVerticalPadding),
      ],
    );
  }
}
