import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/screens/payment/widgets/picked_cards.dart';
import 'package:egov/screens/payment/widgets/saved_banks.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentDetails extends StatefulWidget {
  static const String routeName = '/payment_details';
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String _text = '';
  void getText() {
    if (_tabController?.index == 1) {
      _text = 'Add Bank';
    } else {
      _text = 'Add Card';
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    getText();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment methods'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: (smallVerticalPadding),
              left: (horizontalPadding),
              right: (horizontalPadding),
            ),
            child: Container(
              padding: EdgeInsets.all(
                (smallVerticalPadding) / 2,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: themeProvider.isLightTheme
                      ? primaryColor.withOpacity(
                          0.5,
                        )
                      : Colors.white,
                ),
                color: themeProvider.isLightTheme
                    ? Colors.white
                    : primaryColorDeep,
              ),
              child: TabBar(
                controller: _tabController,
                padding: EdgeInsets.zero,
                indicator: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(
                    (buttonBorderRadius) / 1.5,
                  ),
                ),
                onTap: ((value) {
                  getText();
                }),
                labelColor: themeProvider.themeMode().kColorWhite,
                unselectedLabelColor:
                    themeProvider.themeMode().kPrimaryColorDeep,
                unselectedLabelStyle:
                    themeProvider.textTheme().bodyText1?.copyWith(
                          color: primaryColor,
                          fontSize: (textFontSize),
                          fontWeight: FontWeight.w600,
                        ),
                labelStyle: themeProvider.textTheme().bodyText1?.copyWith(
                      color: Colors.white,
                      fontSize: (textFontSize),
                      fontWeight: FontWeight.w600,
                    ),
                tabs: const [
                  Tab(
                    text: 'Cards',
                  ),
                  Tab(
                    text: 'Banks',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                physics: const ScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: (horizontalPadding),
                    ),
                    child: Column(
                      children: [
                        HSpace((padding)),
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: const PickCardWidget(
                            icon: visaPNG,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: (padding),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HSpace(
                          (verticalPadding),
                        ),
                        SavedBankCard(
                          accountName: 'Olaolu Ojerinde',
                          accountNumber: '2209546323',
                          bankName: 'Kuda Bank',
                          onTap: () => setState(() {}),
                        ),
                      ],
                    ),
                  ),
                ]),
          )
        ],
      ),
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height / 8,
        child: Column(
          children: [
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: themeProvider.themeMode().kPrimaryColorDeep,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            HSpace((smallVerticalPadding) / 2),
            Text(_text),
          ],
        ),
      ),
    );
  }
}
