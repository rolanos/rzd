import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class Validator {
  const Validator();

  bool validate(String str);
}

///Пустой валидатор - всегда вернет true
class EmptyValidator extends Validator {
  const EmptyValidator();

  @override
  bool validate(String str) {
    return true;
  }
}

///Валидатор для имени
class NameValidator extends Validator {
  @override
  bool validate(String str) {
    if (str.isEmpty) {
      return false;
    }
    return true;
  }
}

///Валидатор для даты
class DateValidator extends Validator {
  @override
  bool validate(String str) {
    if (str.isEmpty) {
      return false;
    }
    if (RegExp(r'^[.0-9]+$').hasMatch(str)) {
      if (str.length >= 2) {
        if ((int.tryParse(str[0] + str[1]) ?? 0) > 31) {
          return false;
        }
      }
      if (str.length >= 5) {
        if ((int.tryParse(str[3] + str[4]) ?? 0) > 12) {
          return false;
        }
      }
      if (str.length == 10) {
        if ((int.tryParse(str[6] + str[7] + str[8] + str[9]) ?? 0) > 2023) {
          return false;
        }
      }
      if (str.length <= 10) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

///Валидатор для номера телефона
class PhoneValidator extends Validator {
  static String toNumber(String phone) {
    phone.replaceAll(' ', '');
    phone.replaceAll('+', '');
    log("Phone validation ->$phone");
    while (phone.length > 8) {
      phone = phone.substring(1, phone.length);
    }
    return phone;
  }

  @override
  bool validate(String str) {
    return true;
  }
}

class PasportSeriesValidator extends Validator {
  @override
  bool validate(String str) {
    if (str.length < 4) {
      return false;
    }
    return true;
  }
}

class PasportNumberValidator extends Validator {
  @override
  bool validate(String str) {
    if (str.length < 6) {
      return false;
    }
    return true;
  }
}

///Валидатор для номера почты
class EmailValidator extends Validator {
  @override
  bool validate(String str) {
    if (str.isEmpty) {
      return false;
    }
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
        .hasMatch(str)) {
      return true;
    }
    return false;
  }
}

class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    var dateText = _addSeperators(newValue.text, '.');
    return newValue.copyWith(
        text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll('.', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 1) {
        newString += seperator;
      }
      if (i == 3) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
