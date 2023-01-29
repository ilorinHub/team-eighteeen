import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:etransport/mainApp/analytics.dart';
import 'package:etransport/mainApp/dashboard_view.dart';
import 'package:etransport/mainApp/drivers_view.dart';
import 'package:etransport/mainApp/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainApp extends ConsumerWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenwidth = MediaQuery.of(context).size.width;
    bool isMobile = screenwidth < 500;
    PageController pageController = PageController();
    SideMenuController sideMenuController = SideMenuController();
    List<SideMenuItem> sideMenuItems = [
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 0,
        title: 'Dashboard',
        onTap: (index, _) => sideMenuController.changePage(index),
        icon: const Icon(Icons.dashboard),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Drivers',
        onTap: (index, _) => sideMenuController.changePage(index),
        icon: const Icon(Icons.people),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Analytics',
        onTap: (index, _) => sideMenuController.changePage(index),
        icon: const Icon(Icons.analytics),
      ),
      SideMenuItem(
        priority: 3,
        title: 'Profile',
        onTap: (index, _) => sideMenuController.changePage(index),
        icon: const Icon(Icons.person),
      ),
    ];
    sideMenuController.addListener((p0) {
      pageController.jumpToPage(p0);
    });
    return Scaffold(
      body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SideMenu(
          items: sideMenuItems,
          controller: sideMenuController,
          style: SideMenuStyle(
            displayMode: SideMenuDisplayMode.auto,
            hoverColor: Colors.blue[100],
            selectedColor: Colors.blue[600],
            selectedTitleTextStyle: const TextStyle(color: Colors.white),
            selectedIconColor: Colors.white,
            unselectedIconColor: Colors.white70,
            unselectedTitleTextStyle: const TextStyle(color: Colors.white70),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 79, 117, 134),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ]),
            backgroundColor: const Color.fromARGB(255, 79, 117, 134),
            // openSideMenuWidth: 200
          ),
        ),
        Expanded(
            child: PageView(
          controller: pageController,
          children: const [
            DashboardView(),
            DriversView(),
            AnalyticsView(),
            ProfileView()
          ],
        ))
      ]),
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
              currentIndex:
                  _bottomNavBarItems.values.indexOf(ref.watch(currentPage)),
              onTap: (selected) {
                ref.watch(currentPage.notifier).state =
                    _bottomNavBarItems.values[selected];
              },
              items: _bottomNavBarItems.values.map((e) {
                Widget icon = const Icon(Icons.person);
                String label = '';
                switch (e) {
                  case _bottomNavBarItems.dashboard:
                    icon = const Icon(Icons.dashboard);
                    label = 'Dashbaord';
                    break;
                  case _bottomNavBarItems.drivers:
                    icon = const Icon(Icons.people);
                    label = 'Drivers';
                    break;
                  case _bottomNavBarItems.analysis:
                    icon = const Icon(Icons.analytics);
                    label = 'Analysis';
                    break;
                  case _bottomNavBarItems.profile:
                    icon = const Icon(Icons.account_box);
                    label = 'Profile';
                    break;
                }
                return BottomNavigationBarItem(icon: icon, label: label);
              }).toList())
          : null,
    );
  }
}

enum _bottomNavBarItems { dashboard, drivers, analysis, profile }

final currentPage = StateProvider((ref) => _bottomNavBarItems.dashboard);
