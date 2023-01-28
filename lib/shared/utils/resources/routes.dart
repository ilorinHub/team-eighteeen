import 'package:egov/core/viewmodels/state_provider/state_provider.dart';
import 'package:egov/main.dart';
import 'package:egov/screens/auth/ui/forgot_password_screen.dart';
import 'package:egov/screens/auth/ui/login_screen.dart';
import 'package:egov/screens/auth/ui/reset_password_screen.dart';
import 'package:egov/screens/auth/ui/signup_screen.dart';
import 'package:egov/screens/dashboard/ui/dasboard.dart';
import 'package:egov/screens/dashboard/ui/in_demand_routes.dart';
import 'package:egov/screens/dashboard/ui/map_screen.dart';
import 'package:egov/screens/dashboard/ui/rate_rider.dart';
import 'package:egov/screens/dashboard/ui/rider_dashboard.dart';
import 'package:egov/screens/notifications/ui/notifications.dart';
import 'package:egov/screens/payment/ui/add_new_payment.dart';
import 'package:egov/screens/payment/ui/payment_details.dart';
import 'package:egov/screens/payment/ui/payment_history.dart';
import 'package:egov/screens/payment/ui/share.dart';
import 'package:egov/screens/payment/ui/withdraw.dart';
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
      case AddNewCard.routeName:
        return MaterialPageRoute(builder: (_) => const AddNewCard());
      case PaymentDetails.routeName:
        return MaterialPageRoute(builder: (_) => const PaymentDetails());
      case PaymentHistory.routeName:
        return MaterialPageRoute(builder: (_) => const PaymentHistory());
      case WithdrawFunds.routeName:
        return MaterialPageRoute(builder: (_) => const WithdrawFunds());
      case ShareFunds.routeName:
        return MaterialPageRoute(builder: (_) => const ShareFunds());
      case RateRider.routeName:
        return MaterialPageRoute(builder: (_) => const RateRider());
      case RiderDashBoard.routeName:
        return MaterialPageRoute(builder: (_) => const RiderDashBoard());
      case MapScreen.routeName:
        return MaterialPageRoute(builder: (_) => const MapScreen());
      case InDemandScreen.routeName:
        return MaterialPageRoute(builder: (_) => const InDemandScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
