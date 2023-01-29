import 'dart:async';

import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrCodeView extends StatefulWidget {
  const QrCodeView({super.key});

  @override
  State<QrCodeView> createState() => _QrCodeViewState();
}

class _QrCodeViewState extends State<QrCodeView> {
  bool _success = false;
  @override
  void initState() {
    super.initState();
    showSuccess();
  }

  void showSuccess() async {
    await Future.delayed(const Duration(seconds: 2), () {
      _success = true;
      setState(() {});
      Timer(const Duration(seconds: 1), () {
        Navigator.pop(context, false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _success
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      child: const Icon(
                        Icons.done_rounded,
                        color: Colors.white,
                        size: 100,
                      )),
                  const HSpace(20),
                  const Text('Payment Successful'),
                ],
              )
            : PrettyQr(
                typeNumber: 3,
                size: 200,
                data: 'https://www.google.ru',
                errorCorrectLevel: QrErrorCorrectLevel.M,
                roundEdges: true,
              ),
      ),
    );
  }
}
