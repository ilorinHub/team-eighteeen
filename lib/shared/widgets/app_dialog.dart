import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialog {
  static Future<T?> showDDialog<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
      content: child,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.purple,
          ),
          child: Text(
            "Yes",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.purple,
                fontSize: 15.sp),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.purple,
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            "No",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.purple,
                fontSize: 15.sp),
          ),
        ),
      ],
    );
    AlertDialog alert = AlertDialog(
      content: SizedBox(height: 100, child: child),
      actions: [
        SizedBox(
          width: 150.w,
          child: ElevatedButton(
            child: const Text("Yes"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
        SizedBox(
          width: 150.w,
          child: ElevatedButton(
            child: const Text("No"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        )
      ],
    );
    if (Platform.isAndroid) {
      return await showDialog<T>(
        context: context,
        barrierColor: Colors.grey.withOpacity(0.5),
        builder: (context) {
          return alert;
        },
      );
    }
    return await showCupertinoDialog<T>(
        context: context, builder: (context) => cupertinoAlertDialog);
  }
}
