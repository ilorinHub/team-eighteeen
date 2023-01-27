import 'package:egov/core/viewmodels/state_provider/state_provider.dart';
import 'package:egov/main.dart';
import 'package:egov/screens/auth/ui/forgot_password_screen.dart';
import 'package:egov/screens/auth/ui/login_screen.dart';
import 'package:egov/screens/auth/ui/reset_password_screen.dart';
import 'package:egov/screens/auth/ui/signup_screen.dart';
import 'package:egov/screens/dashboard/ui/dasboard.dart';
import 'package:egov/screens/notifications/ui/notifications.dart';
import 'package:egov/screens/profile/ui/profile.dart';
import 'package:egov/screens/search/ui/search.dart';
import 'package:egov/shared/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings, BuildContext context) {
    String routeName = settings.name!;
    final authProv = context.read<StateProvider>();
    if (settings.name == LoginScreen.routeName &&
        authProv.stateStatus == StateStatus.authenticated) {
      routeName = BottomNavigationScreen.routeName;
    }

    switch (routeName) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case BottomNavigationScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const BottomNavigationScreen());
      case SignUpScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case ResetPasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case SearchScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case DashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case NotificationsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
