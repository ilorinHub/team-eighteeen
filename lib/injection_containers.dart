import 'package:egov/app_injection_container.dart';
import 'package:egov/core/viewmodels/auth/authviewmodel.dart';
import 'package:egov/core/viewmodels/dashboard/dashboard_viewmodels.dart';
import 'package:egov/core/viewmodels/map_view_model/map_view_model.dart';
import 'package:egov/core/viewmodels/state_provider/state_provider.dart';
import 'package:egov/core/viewmodels/tab/tab_view_model.dart';
import 'package:egov/core/viewmodels/theme/theme_view_model.dart';

class AuthInjectionContainer {
  static Future<void> init() async {
    sl.registerLazySingleton<AuthViewModel>(() => AuthViewModel());
    sl.registerLazySingleton<StateProvider>(
        () => StateProvider(storageService: sl()));
  }
}

class ThemeInjectionContainer {
  static Future<void> init() async {
    sl.registerFactory<ThemeProvider>(() => ThemeProvider(isLightTheme: true));
  }
}

class DashboardInjectionContainer {
  static Future<void> init() async {
    sl.registerFactory<DashboardViewmodel>(() => DashboardViewmodel());
  }
}

class TabInjectionContainer {
  static Future<void> init() async {
    sl.registerFactory<TabViewModel>(() => TabViewModel());
  }
}

class MapInjectionContainer {
  static Future<void> init() async {
    sl.registerFactory<MapViewModel>(() => MapViewModel());
  }
}
