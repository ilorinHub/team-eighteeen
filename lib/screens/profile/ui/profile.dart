import 'package:egov/app_container.dart';
import 'package:egov/core/services/storage/storage_service.dart';
import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/screens/payment/ui/payment_history.dart';
import 'package:egov/screens/profile/ui/ride_history.dart';
import 'package:egov/shared/utils/resources/dimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/profile";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ThemeProvider? themeProvider;
  void _onChanged(bool val) {
    setState(() {
      val = !val;
      themeProvider!.toggleThemeData(
        value: val,
        shouldLoad: false,
      );
      //this shows that the theme settings has been modified
      sl<StorageService>().saveThemeValue(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              HSpace(verticalPadding),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: const [
                    CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    ),
                  ],
                ),
              ),
              HSpace(smallVerticalPadding),
              Text(
                'Olaolu Ojerinde',
                style: themeProvider!.textTheme().bodyText1?.copyWith(
                      fontSize: (textFontSize),
                      fontWeight: FontWeight.w500,
                    ),
              ),
              HSpace(buttonHeight),
              ProfileItem(
                themeProvider: themeProvider!,
                icon: Icons.history,
                title: 'Ride History',
                onTap: () {
                  Navigator.pushNamed(context, RideHistory.routeName);
                },
              ),
              ProfileItem(
                themeProvider: themeProvider!,
                icon: Icons.security,
                title: 'Secure your account',
              ),
              ProfileItem(
                themeProvider: themeProvider!,
                icon: Icons.history_outlined,
                title: 'Payment History',
                onTap: () {
                  Navigator.pushNamed(context, PaymentHistory.routeName);
                },
              ),
              ProfileItem(
                themeProvider: themeProvider!,
                icon: Icons.change_circle,
                title: 'Change Payment Methods',
              ),
              ProfileItem(
                themeProvider: themeProvider!,
                icon: Icons.settings,
                title: 'Settings',
              ),
              ProfileItem(
                themeProvider: themeProvider!,
                icon: Icons.room_preferences_outlined,
                title: 'Preferences',
              ),
              ProfileItem(
                themeProvider: themeProvider!,
                icon: Icons.light_mode,
                isTheme: true,
                value: !themeProvider!.isLightTheme,
                onChanged: _onChanged,
                title: 'Toggle Team',
              ),
              ProfileItem(
                themeProvider: themeProvider!,
                icon: Icons.logout,
                title: 'Logout',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.themeProvider,
    required this.title,
    required this.icon,
    this.isTheme = false,
    this.value = false,
    this.onChanged,
    this.onTap,
  }) : super(key: key);

  final ThemeProvider themeProvider;
  final String title;
  final IconData icon;
  final bool? isTheme, value;
  final void Function(bool)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: verticalPadding),
        child: Row(
          children: [
            Icon(icon),
            WSpace(horizontalPadding),
            Text(
              title,
              style: themeProvider.textTheme().bodyText1?.copyWith(
                    fontSize: (textFontSize),
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Spacer(),
            if (isTheme!)
              Switch(value: value!, onChanged: onChanged)
            else
              const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
