import 'dart:io';
import 'dart:ui';
import 'package:html/parser.dart';
import 'package:rzd/core/colors.dart';

extension DataFormat on DateTime {
  String format() {
    String monthStr = '';
    switch (month) {
      case 1:
        monthStr = 'янв';
        break;
      case 2:
        monthStr = 'фев';
        break;
      case 3:
        monthStr = 'март';
        break;
      case 4:
        monthStr = 'апр';
        break;
      case 5:
        monthStr = 'май';
        break;
      case 6:
        monthStr = 'июнь';
        break;
      case 7:
        monthStr = 'июль';
        break;
      case 8:
        monthStr = 'авг';
        break;
      case 9:
        monthStr = 'сент';
        break;
      case 10:
        monthStr = 'окт';
        break;
      case 11:
        monthStr = 'ноя';
        break;
      case 12:
        monthStr = 'дек';
        break;
      default:
        monthStr = '-';
    }
    String minStr = minute.toString();
    String hourStr = hour.toString();
    if (minute < 10) {
      minStr = '0$minStr';
    }
    if (hour < 10) {
      hourStr = '0$hourStr';
    }
    return '$day $monthStr в $hourStr:$minStr';
  }
}

extension GetColor on String {
  //here goes the function
  String? parseHtmlString() {
    final document = parse(this);
    final String? parsedString =
        parse(document.body?.text).documentElement?.text;

    return parsedString;
  }

  Color getStatusColorText() {
    switch (this) {
      case 'Принято':
        return const Color.fromRGBO(3, 46, 65, 1);
      case 'Ошибка':
        return const Color.fromRGBO(235, 65, 55, 1);
      case 'Обработано':
        return const Color.fromRGBO(41, 148, 32, 1);
      default:
        return ColorsUI.mainText;
    }
  }

  Color getStatusColorContainer() {
    switch (this) {
      case 'Принято':
        return const Color.fromRGBO(247, 247, 247, 1);
      case 'Ошибка':
        return const Color.fromRGBO(253, 240, 239, 1);
      case 'Обработано':
        return const Color.fromRGBO(221, 252, 217, 1);
      default:
        return ColorsUI.containerGrey;
    }
  }
}
