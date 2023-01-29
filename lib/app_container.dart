import 'package:egov/core/api/network/network.dart';
import 'package:egov/core/api/network/socket_client.dart';
import 'package:egov/core/services/storage/storage_service.dart';
import 'package:egov/injection_containers.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class AppInjectionContainer {
  static Future<void> init() async {
    //general dependencies
    final prefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => prefs);
    sl.registerLazySingleton<StorageService>(
      () => StorageServiceImpl(sharedPreferences: sl()),
    );
    sl.registerLazySingleton<ApiClient>(
      () => ApiClient(storageService: sl()),
    );
    sl.registerLazySingleton<SocketClient>(
      () => SocketClient(storageService: sl()),
    );

    AuthInjectionContainer.init();
    ThemeInjectionContainer.init();
    DashboardInjectionContainer.init();
    TabInjectionContainer.init();
    MapInjectionContainer.init();
  }
}
