import 'package:egov/core/viewmodels/tab/tab_view_model.dart';
import 'package:egov/core/viewmodels/theme/theme_view_model.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const String routeName = "/nav";

  const BottomNavigationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<TabViewModel>(builder: (context, value, child) {
      return Scaffold(
        body: value.widgetToDisplay,
        backgroundColor: themeProvider.themeMode().kBackgroundColor,
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          color: themeProvider.isLightTheme ? Colors.white : kColorBlack,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                radius: (padding),
                splashColor: themeProvider.themeMode().kColorBlack,
                onTap: () {
                  value.currentTab = CurrentTab.dashboard;
                  value.setCurrentTab();
                },
                child: _SelectedBottomNavItem(
                  iconData: Icons.home_filled,
                  selected: value.currentTab == CurrentTab.dashboard,
                  title: 'Home',
                  color: kColorRed,
                ),
              ),
              InkWell(
                radius: (padding),
                splashColor: themeProvider.themeMode().kColorBlack,
                onTap: () {
                  value.currentTab = CurrentTab.search;
                  value.setCurrentTab();
                },
                child: _SelectedBottomNavItem(
                  iconData: Icons.search,
                  selected: value.currentTab == CurrentTab.search,
                  title: 'Search',
                  color: primaryColor,
                ),
              ),
              InkWell(
                radius: (padding),
                splashColor: themeProvider.themeMode().kColorBlack,
                onTap: () {
                  value.currentTab = CurrentTab.notifications;
                  value.setCurrentTab();
                },
                child: _SelectedBottomNavItem(
                  iconData: Icons.notification_add,
                  selected: value.currentTab == CurrentTab.notifications,
                  title: 'Notifications',
                  color: kColorRed,
                ),
              ),
              InkWell(
                radius: (padding),
                splashColor: themeProvider.themeMode().kColorBlack,
                onTap: () {
                  value.currentTab = CurrentTab.profile;
                  value.setCurrentTab();
                },
                child: _SelectedBottomNavItem(
                  iconData: Icons.person,
                  selected: value.currentTab == CurrentTab.profile,
                  title: 'Profile',
                  color: kColorBlack,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _SelectedBottomNavItem extends StatelessWidget {
  const _SelectedBottomNavItem({
    Key? key,
    this.color,
    required this.selected,
    required this.title,
    required this.iconData,
  }) : super(key: key);
  final String title;
  final Color? color;
  final bool selected;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: selected
                ? kColorMagenta
                : themeProvider.isLightTheme
                    ? colorBottomNav.withOpacity(0.5)
                    : colorGrey,
          ),
          HSpace(
            (smallVerticalPadding) / 2,
          ),
          AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.elasticIn,
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: selected
                      ? kColorMagenta
                      : themeProvider.isLightTheme
                          ? colorBottomNav.withOpacity(0.5)
                          : colorGrey,
                  fontSize: (textFontSize * 0.7),
                ),
              )),
        ],
      ),
    );
  }
}
