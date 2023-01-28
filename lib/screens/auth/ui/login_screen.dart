import 'dart:developer';

import 'package:egov/core/models/auth/requests/login_request.dart';
import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/screens/auth/ui/forgot_password_screen.dart';
import 'package:egov/screens/dashboard/ui/rider_dashboard.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:egov/shared/widgets/have_account_text.dart';
import 'package:egov/shared/widgets/primary_btn.dart';
import 'package:egov/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<AuthViewModel>(builder: (context, viewmodel, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Login',
                    style: themeProvider.textTheme().headline1?.copyWith(
                          color: themeProvider.isLightTheme
                              ? primaryColorDeep
                              : textColor,
                        )),
                HSpace(50.h),
                TextFieldWidget(
                  hintText: "Email Address",
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  controller: _email,
                  textInputType: TextInputType.emailAddress,
                  validator: (String? val) => UtilsHelpers.validateEmail(
                    val!.trim(),
                  ),
                ),
                HSpace((padding)),
                TextFieldWidget(
                  hintText: "Password",
                  textInputAction: TextInputAction.done,
                  obscureText: !viewmodel.show,
                  controller: _pass,
                  textInputType: TextInputType.text,
                  validator: (String? val) => UtilsHelpers.validatePassword1(
                    val!.trim(),
                  ),
                  hasSuffixIcon: true,
                  suffixIcon: GestureDetector(
                    onTap: () => viewmodel.togglePasswordVisibility(),
                    child: Icon(
                      viewmodel.show ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                HSpace((verticalPadding)),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      ForgotPasswordScreen.routeName,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: themeProvider.textTheme().bodyText2?.copyWith(
                          color: themeProvider.isLightTheme
                              ? primaryColorDeep
                              : textColor,
                          fontSize: (textFontSize),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                HSpace(
                  buttonHeight,
                ),
                SizedBox(
                  width: double.infinity,
                  child: EGOvButton(
                    hasIcon: false,
                    loading: viewmodel.loading,
                    secondaryButton: false,
                    text: 'Login',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        log('${_email.text}, ${_pass.text}');
                        _formKey.currentState!.save();
                        viewmodel
                            .loginUser(LoginRequest(
                                email: _email.text.trim(),
                                password: _pass.text.trim()))
                            .then((value) {
                          if (value) {
                            log('Login success');
                            Navigator.pushReplacementNamed(
                                context, RiderDashBoard.routeName);
                          } else {
                            log('Login failed');
                            log(viewmodel.message);
                          }
                        });
                      }
                    },
                  ),
                ),
                HSpace(
                  (smallVerticalPadding),
                ),
                const HaveAccountText(
                  login: false,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
