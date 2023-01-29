import 'dart:developer';

import 'package:egov/core/models/auth/requests/signup_request.dart';
import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:egov/shared/widgets/bottom_nav.dart';
import 'package:egov/shared/widgets/have_account_text.dart';
import 'package:egov/shared/widgets/primary_btn.dart';
import 'package:egov/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/signup";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _pass1 = TextEditingController();
  final TextEditingController _pass2 = TextEditingController();
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
                Text('Create Account',
                    style: themeProvider.textTheme().headline1?.copyWith(
                          color: themeProvider.isLightTheme
                              ? primaryColorDeep
                              : textColor,
                        )),
                HSpace(50.h),
                TextFieldWidget(
                  hintText: "Full Name",
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  controller: _name,
                  textInputType: TextInputType.name,
                  validator: (String? val) =>
                      UtilsHelpers.validateRequiredFields(val!.trim(),
                          label: "Full Name"),
                ),
                HSpace((padding)),
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
                  hintText: "Phone Number",
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  controller: _phoneNumber,
                  textInputType: TextInputType.phone,
                  validator: (String? val) => UtilsHelpers.validatePhoneNumber(
                    val!.trim(),
                  ),
                ),
                HSpace((padding)),
                TextFieldWidget(
                  hintText: "Password",
                  textInputAction: TextInputAction.done,
                  obscureText: !viewmodel.show,
                  controller: _pass1,
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
                TextFieldWidget(
                  hintText: "Re-Enter Password",
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  controller: _pass2,
                  textInputType: TextInputType.emailAddress,
                  validator: (String? val) =>
                      UtilsHelpers.validatePassword2(val!.trim(), _pass2.text),
                ),
                HSpace((padding)),
                HSpace(
                  buttonHeight,
                ),
                SizedBox(
                  width: double.infinity,
                  child: EGOvButton(
                    hasIcon: false,
                    loading: false,
                    secondaryButton: false,
                    text: 'Proceed',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        viewmodel
                            .createAccount(SignupRequest(
                                email: _email.text.trim(),
                                password: _pass1.text.trim(),
                                fullName: _name.text.trim(),
                                phoneNumber: _phoneNumber.text.trim()))
                            .then((value) {
                          if (value) {
                            Navigator.pushReplacementNamed(
                                context, BottomNavigationScreen.routeName);
                          } else {
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
                  login: true,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
