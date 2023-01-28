import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/screens/payment/widgets/saved_banks.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:egov/shared/widgets/app_alert.dart';
import 'package:egov/shared/widgets/primary_btn.dart';
import 'package:egov/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WithdrawFunds extends StatefulWidget {
  static const String routeName = '/withdraw_funds';
  const WithdrawFunds({super.key});

  @override
  State<WithdrawFunds> createState() => _ShareFundsState();
}

class _ShareFundsState extends State<WithdrawFunds> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amount = TextEditingController();

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Withdraw funds',
                  style: themeProvider.textTheme().headline1?.copyWith(
                        color: themeProvider.isLightTheme
                            ? primaryColorDeep
                            : textColor,
                      )),
              HSpace(50.h),
              TextFieldWidget(
                hintText: "Amount",
                textInputAction: TextInputAction.done,
                obscureText: false,
                controller: _amount,
                textInputType: TextInputType.number,
                validator: (String? val) => UtilsHelpers.validateRequiredFields(
                    val!.trim(),
                    label: 'Amount'),
              ),
              HSpace((padding)),
              Text(
                'Bank Account',
                style: themeProvider.textTheme().bodyText2?.copyWith(
                    color: themeProvider.isLightTheme
                        ? primaryColorDeep
                        : textColor,
                    fontSize: (textFontSize),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline),
              ),
              HSpace((verticalPadding)),
              SavedBankCard(
                accountName: 'Olaolu Ojerinde',
                accountNumber: '2209546323',
                bankName: 'Kuda Bank',
                onTap: () => setState(() {}),
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
                  text: 'Withdraw Funds',
                  onTap: () async {
                    setState(() {
                      _loading = true;
                    });
                    await Future.delayed(const Duration(seconds: 3), () {
                      setState(() {
                        _loading = false;
                      });
                      AppAlert.showSuccessMessage(
                          context: context,
                          message: 'Withdraw Funds Successful');
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
