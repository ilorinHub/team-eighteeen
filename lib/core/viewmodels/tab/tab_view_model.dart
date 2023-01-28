import 'package:egov/screens/dashboard/ui/dasboard.dart';
import 'package:egov/screens/journeyplanning/plan_journey_view.dart';
import 'package:egov/screens/notifications/ui/notifications.dart';
import 'package:egov/screens/profile/ui/profile.dart';
import 'package:flutter/material.dart';

class TabViewModel extends ChangeNotifier {
  CurrentTab _currentTab = CurrentTab.dashboard;
  CurrentTab get currentTab => _currentTab;
  set currentTab(CurrentTab val) {
    _currentTab = val;
    notifyListeners();
  }

  Widget _widgetToDisplay = const DashboardScreen();
  Widget get widgetToDisplay => _widgetToDisplay;
  set widgetToDisplay(Widget val) {
    _widgetToDisplay = val;
    notifyListeners();
  }

  void setCurrentTab() {
    switch (currentTab) {
      case CurrentTab.dashboard:
        widgetToDisplay = const DashboardScreen();

        break;
      case CurrentTab.search:
        widgetToDisplay = const PlanJourneyView();

        break;
      case CurrentTab.notifications:
        widgetToDisplay = const NotificationsScreen();

        break;
      case CurrentTab.profile:
        widgetToDisplay = const ProfileScreen();

        break;
      default:
        widgetToDisplay = const DashboardScreen();
    }
  }
}

enum CurrentTab { dashboard, search, notifications, profile }
