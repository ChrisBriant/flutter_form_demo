import 'package:validators/validators.dart';

class Validators {
    static bool _isDecimal(String s) {
      // if(s == null) {
      //   return false;
      // }
      try {
        double.parse(s);
        return true;
      } catch(e) {
        return false;
      }
      
    }


  static String? validEmail(val) {
    if (val!.isEmpty || !val.contains('@')) {
      return 'Invalid email!';
    }
    return null;
  }

  static String? validIsNumeric(val) {
    if (!_isDecimal(val)) {
      return 'Please enter a numeric value.';
    }
    return null;
  }

  static String? validHasText(val) {
    if (val!.isEmpty) {
      return 'Please enter a value.';
    }
    return null;
  }
}