import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/screens/auth/ui/login_screen.dart';
import 'package:egov/screens/auth/ui/signup_screen.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HaveAccountText extends StatelessWidget {
  const HaveAccountText({
    Key? key,
    required this.login,
  }) : super(key: key);
  final bool login;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          login ? "Already have an account?" : 'Don\'t have an account?',
          style: themeProvider.textTheme().bodyText2,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: (padding) / 6,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context,
                  login ? LoginScreen.routeName : SignUpScreen.routeName);
            },
            child: Text(
              login ? "Log In" : 'Sign Up',
              style: GoogleFonts.poppins(
                  color: themeProvider.themeMode().ktextColor,
                  fontSize: (textFontSize),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
