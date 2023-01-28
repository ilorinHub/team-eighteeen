import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:egov/shared/widgets/app_alert.dart';
import 'package:egov/shared/widgets/primary_btn.dart';
import 'package:egov/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ShareFunds extends StatefulWidget {
  static const String routeName = '/share_funds';
  const ShareFunds({super.key});

  @override
  State<ShareFunds> createState() => _ShareFundsState();
}

class _ShareFundsState extends State<ShareFunds> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _id = TextEditingController();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
              Text('Withdraw',
                  style: themeProvider.textTheme().headline1?.copyWith(
                        color: themeProvider.isLightTheme
                            ? primaryColorDeep
                            : textColor,
                      )),
              HSpace(50.h),
              TextFieldWidget(
                hintText: "Amount",
                textInputAction: TextInputAction.next,
                obscureText: false,
                controller: _amount,
                textInputType: TextInputType.number,
                validator: (String? val) => UtilsHelpers.validateRequiredFields(
                    val!.trim(),
                    label: 'Amount'),
              ),
              HSpace((padding)),
              TextFieldWidget(
                hintText: "Beneficiary ID",
                textInputAction: TextInputAction.done,
                obscureText: false,
                controller: _id,
                textInputType: TextInputType.text,
                validator: (String? val) => UtilsHelpers.validateRequiredFields(
                    val!.trim(),
                    label: 'ID'),
              ),
              HSpace(
                buttonHeight,
              ),
              SizedBox(
                width: double.infinity,
                child: EGOvButton(
                  hasIcon: false,
                  loading: _loading,
                  secondaryButton: false,
                  text: 'Share Funds',
                  onTap: () async {
                    setState(() {
                      _loading = true;
                    });
                    await Future.delayed(const Duration(seconds: 3), () {
                      setState(() {
                        _loading = false;
                      });
                      AppAlert.showSuccessMessage(
                          context: context, message: 'Share Funds Successful');
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
