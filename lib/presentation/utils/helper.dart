import 'package:intl/intl.dart';

class Helper {
  static String getLocalTimeString(String utcTimeString) {
    if (utcTimeString.isEmpty) {
      return "-";
    }
    final utcTime =
        DateFormat("MMM dd, yyyy HH:mm:ss 'UTC'").parseUtc(utcTimeString);
    final localTime = utcTime.toLocal();
    final formatter = DateFormat("MMM dd, yyyy HH:mm:ss");
    final localTimeString = formatter.format(localTime);
    return localTimeString;
  }

  static String twoDecimalPlaces(double rate) {
    try {
      final formatter = NumberFormat("#,##0.00", "en_US");
      return formatter.format(rate);
    } catch (e) {
      return "0.00";
    }
  }

  static String fourDecimalPlaces(double rate) {
    try {
      final formatter = NumberFormat("#,##0.0000", "en_US");
      return formatter.format(rate);
    } catch (e) {
      return "0.0000";
    }
  }

  static String? numberValidator(String? value) {
    if (value != null && value != "") {
      if (double.tryParse(value) == null) {
        return 'Please enter valid amount';
      }
    } else {
      return 'Please enter amount';
    }
    return null;
  }

  static String? intergerValidator(String? value) {
    if (value != null && value != "") {
      if (int.tryParse(value) == null) {
        return 'Please enter valid number';
      }
    } else {
      return 'Please enter number';
    }
    return null;
  }

  static Map<bool, String> validatePincode(String? pincode) {
    //Pincode must be greater than or equal to 6 characters
    if (pincode == null || pincode.isEmpty || pincode.length < 6) {
      return {false: "Pincode must be at least 6 characters"};
    }
    //Pincode must be number
    for (int i = 0; i < pincode.length; i++) {
      if (int.tryParse(pincode[i]) == null) {
        return {false: "Pincode must be number"};
      }
    }

    int countDuplicates = 0;
    int currentDigit;

    for (int i = 0; i < pincode.length; i++) {
      currentDigit = int.parse(pincode[i]);
      if (i > 0 && currentDigit == int.parse(pincode[i - 1])) {
        countDuplicates++;
        //Pincode must not have more than 2 sets of repeating numbers.
        if (countDuplicates > 2) {
          return {false: "Limit pincode to 2 repeating number sets or less."};
        }
      } else if (i > 1) {
        int digit1 = int.parse(pincode[i - 2]);
        int digit2 = int.parse(pincode[i - 1]);
        int digit3 = int.parse(pincode[i]);
        if ((digit3 == digit1 + 2 && digit2 == digit1 + 1) ||
            (digit3 == digit1 - 2 && digit2 == digit1 - 1)) {
          //Pincode must not have more than 2 consecutive numbers.
          return {false: "Max 2 consecutive numbers allowed in pincode."};
        }
      }
    }
    return {true: "Pincode is valid!"};
  }
}
