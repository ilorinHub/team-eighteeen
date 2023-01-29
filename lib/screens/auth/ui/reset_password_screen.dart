import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:egov/shared/widgets/header_texts.dart';
import 'package:egov/shared/widgets/primary_btn.dart';
import 'package:egov/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = "/reset_pass";
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass1 = TextEditingController();
  final TextEditingController _pass2 = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<AuthViewModel>(builder: (context, viewmodel, child) {
      return Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              HSpace(50.h),
              const HeaderTexts(
                richText: false,
                title: 'Confirm otp',
                description:
                    'Enter the email sent to your email and new password',
              ),
              HSpace(50.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      hintText: "Enter OTP",
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      controller: _otp,
                      textInputType: TextInputType.number,
                      validator: (String? val) =>
                          UtilsHelpers.validateRequiredFields(val!.trim(),
                              label: 'Otp'),
                    ),
                    HSpace(20.h),
                    TextFieldWidget(
                      hintText: "Enter New Password",
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      controller: _pass1,
                      textInputType: TextInputType.text,
                      validator: (String? val) =>
                          UtilsHelpers.validatePassword1(
                        val!.trim(),
                      ),
                    ),
                    HSpace(20.h),
                    TextFieldWidget(
                      hintText: "Re-Enter Password",
                      textInputAction: TextInputAction.done,
                      obscureText: false,
                      controller: _pass2,
                      textInputType: TextInputType.text,
                      validator: (String? val) =>
                          UtilsHelpers.validatePassword2(
                              val!.trim(), _pass1.text),
                    ),
                  ],
                ),
              ),
              HSpace(
                buttonHeight,
              ),
              SizedBox(
                width: double.infinity,
                child: EGOvButton(
                  hasIcon: false,
                  loading: false,
                  secondaryButton: false,
                  text: 'Login',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      viewmodel
                          .resetPassword(
                            _otp.text,
                            _pass1.text.trim(),
                          )
                          .then((value) {});
                    }
                  },
                ),
              ),
              HSpace(
                (smallVerticalPadding),
              ),
            ],
          ),
        ),
      );
    });
  }
}
