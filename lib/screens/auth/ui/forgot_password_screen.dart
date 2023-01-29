import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:egov/shared/widgets/header_texts.dart';
import 'package:egov/shared/widgets/primary_btn.dart';
import 'package:egov/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = "/forgot";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<AuthViewModel>(builder: (context, viewmodel, child) {
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HSpace(50.h),
              const HeaderTexts(
                richText: false,
                title: 'Reset password',
                description: 'Enter your email to reset your password',
              ),
              HSpace(50.h),
              Form(
                key: _formKey,
                child: TextFieldWidget(
                  hintText: "Email Address",
                  textInputAction: TextInputAction.done,
                  obscureText: false,
                  controller: _email,
                  textInputType: TextInputType.emailAddress,
                  validator: (String? val) => UtilsHelpers.validateEmail(
                    val!.trim(),
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
                  loading: false,
                  secondaryButton: false,
                  text: 'Proceed',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      viewmodel
                          .requestResetPassword(
                            _email.text.trim(),
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
