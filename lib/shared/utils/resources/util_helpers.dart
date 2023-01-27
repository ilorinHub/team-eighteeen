import 'package:intl/intl.dart';

class UtilsHelpers {
  UtilsHelpers._();

  static String? validateEmail(String? email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp("$pattern");
    if (email!.trim().isEmpty && email.trim().length > 80) {
      return 'Email is required';
    } else if (!regex.hasMatch(email)) {
      return 'Enter Valid Email';
    }
    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    // Pattern pattern = r'^[0]\d{10}$';
    // RegExp regex = RegExp("$pattern");

    if (phoneNumber!.trim().isEmpty) {
      return 'Phone Number is required';
    }
    // else if (!regex.hasMatch(phoneNumber)) {
    //   return 'Enter a valid phone number';
    // }
    else if (phoneNumber.trim().length > 15) {
      return 'Enter a valid phone number';
    } else {
      return null;
    }
  }

  static String? validateRequiredFields(String? value,
      {required String label}) {
    if (value!.trim().isEmpty || value.trim().length > 70) {
      return '$label field cannot be empty';
    }
    return null;
  }

  static String? validateRequiredFieldsIsNotMatch(String? value, String? match,
      {required String label}) {
    if (value!.trim().length < 2 && value.trim().length > 70) {
      return '$label field cannot be empty';
    } else if (value == match!) {
      return 'You cannot send to your $label';
    }
    return null;
  }

  static String? validateWalletAddressField(String? value) {
    if (value!.trim().length < 42 || value.trim().length > 45) {
      return 'Please enter a valid Address';
    }
    return null;
  }

  static String? validatePassword1(String? value) {
    if (value!.trim().length < 7 || value.trim().length > 50) {
      return 'Please enter a valid password';
    }
    return null;
  }

  static String? validatePassword2(String? value, String? match) {
    if (value!.isEmpty) {
      return 'Please enter a valid password';
    } else if (value != match!) {
      return 'Passwords don\'t match';
    }
    return null;
  }

  static String cleanString(String value, {String pattern = ' '}) {
    List<String> splittedValues = value.split(pattern);

    String cleanedString = '';

    for (int i = 0; i < splittedValues.length; i++) {
      cleanedString += '${toUpperCase(splittedValues[i])} ';
    }

    return cleanedString;
  }

  static String toUpperCase(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }

  static String formatDate(DateTime dateTime, {required String pattern}) {
    String formattedDate;
    DateFormat dateFormat;

    dateFormat = DateFormat(pattern);
    formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  static String formatCurrencyInput(String amount, {bool naira = true}) {
    final formatter = NumberFormat.currency(
      locale: naira ? "en_NG" : 'en_US',
      name: !naira ? 'USD' : 'NGN',
      symbol: !naira ? '\$' : "₦",
      decimalDigits: 2,
    );
    amount = amount.replaceAll(RegExp(r'[^0-9\.]'), "");
    final amountDouble = double.tryParse(amount);
    if (amountDouble == null) {
      return "";
    }
    return formatter.format(amountDouble);
  }

  static String formatNumber(String amount) {
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
    final returnedAmount = numberFormat.format(double.parse(amount));
    return returnedAmount;
  }
}
