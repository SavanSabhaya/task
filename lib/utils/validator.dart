import 'package:task/common/constants/string_constants.dart';

class Validator {

  static bool isEmpty(String? value){
    return value == null || value.isEmpty;
  }

  static bool isEmail(String em) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return !regex.hasMatch(em);
  }

  static bool isPassword(String value){
    if(value.length < 8){
      return true;
    }
    return false;
  }

  static String? emptyValidator(String? value, String errorString) {
    if (value?.isEmpty ?? true) {
      return errorString;
    } else {
      return null;
    }
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return emptyEmailError;
    } else if (isEmail(value)) {
      return invalidEmailError;
    } else {
      return null;
    }
  }
}
