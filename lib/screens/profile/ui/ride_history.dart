import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:egov/shared/utils/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideHistory extends StatelessWidget {
  static const String routeName = '/ride_history';
  const RideHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride History'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [RideHistoryWidget(themeProvider: themeProvider)],
        ),
      ),
    );
  }
}

class RideHistoryWidget extends StatelessWidget {
  const RideHistoryWidget({
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: themeProvider.themeMode().kColorGrey,
        borderRadius: BorderRadius.circular(buttonBorderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Agbabiaka road, Ilorin, Kwara state.',
              style: themeProvider.textTheme().bodyText1?.copyWith(
                    fontSize: (textFontSize),
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              '22nd, January, 2023 : 3pm',
              style: themeProvider.textTheme().bodyText1?.copyWith(
                    fontSize: (textFontSize),
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              '${naira}400',
              style: themeProvider.textTheme().bodyText1?.copyWith(
                    fontSize: (textFontSize),
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ]),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(buttonBorderRadius),
              border: Border.all(
                color: themeProvider.themeMode().kPrimaryColorLight!,
              ),
            ),
            child: const Text('Shared'),
          )
        ],
      ),
    );
  }
}
