import 'package:egov/core/viewmodels/view_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = "/dash";
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  themeProvider.themeMode().kPrimaryColor!,
                  themeProvider.themeMode().kPrimaryColor!.withOpacity(0.7),
                  themeProvider.themeMode().kPrimaryColor!.withOpacity(0.7),
                ])),
              )
            ],
          )
        ],
      ),
    );
  }
}
