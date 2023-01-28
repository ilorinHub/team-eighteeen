import 'package:egov/core/viewmodels/dashboard/rider_dashboard_viewmodel.dart';
import 'package:egov/core/viewmodels/map_view_model/map_view_model.dart';
import 'package:egov/core/viewmodels/state_provider/state_provider.dart';
import 'package:egov/core/viewmodels/tab/tab_view_model.dart';
import 'package:egov/core/viewmodels/view_models.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// exports
export 'theme/theme_view_model.dart';
export 'dashboard/dashboard_viewmodels.dart';
export 'auth/authviewmodel.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider<DashboardViewmodel>(
    create: (_) => GetIt.I<DashboardViewmodel>(),
  ),
  ChangeNotifierProvider<AuthViewModel>(
    create: (_) => GetIt.I<AuthViewModel>(),
  ),
  ChangeNotifierProvider<MapViewModel>(
    create: (_) => GetIt.I<MapViewModel>(),
  ),
  ChangeNotifierProvider<StateProvider>(
    create: (_) => GetIt.I<StateProvider>(),
  ),
  ChangeNotifierProvider<TabViewModel>(
    create: (_) => GetIt.I<TabViewModel>(),
  ),
  ChangeNotifierProvider<ThemeProvider>(
    create: (_) => GetIt.I<ThemeProvider>(),
  ),
  ChangeNotifierProvider<RiderDashboardViewmodel>(
    create: (_) => GetIt.I<RiderDashboardViewmodel>(),
  ),
];
