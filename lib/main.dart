import 'dart:async';

import 'package:egov/app_injection_container.dart';
import 'package:egov/core/services/storage/storage_service.dart';
import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/screens/auth/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screens/ridesharing/share_ride_view.dart';
import 'shared/utils/resources/routes.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await StorageService.initStorageService();
//   // StorageService().getThemeValue();
//   await AppConfig.initDependencies();
//   runApp(MultiProvider(providers: [
//     ...providers,
//   ], child: const MyApp()));
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MaterialApp(home: ShareRideView())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storageService = sl<StorageService>();
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final settingsModified = storageService.getThemeValue();
    if (settingsModified == false) {
      sl<ThemeProvider>().toggleThemeData(
        value: !isDarkMode,
      );
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        designSize: const Size(400, 850),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
              theme: sl<ThemeProvider>().theme(),
              home: const SplashScreen(),
              onGenerateRoute: (settings) {
                return AppRoute.routes(settings, context);
              });
        });
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        LoginScreen.routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.train_sharp,
          size: 50.h,
        ),
      ),
    );
  }
}
