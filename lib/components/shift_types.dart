import 'package:flutter/material.dart';

enum ShiftType {
  none,       // 无班次
  morning,    // 早班
  afternoon,  // 中班
  night,      // 晚班
  off         // 休息
}

class ShiftUtils {
  static String getShiftName(ShiftType type) {
    switch (type) {
      case ShiftType.none:
        return '';
      case ShiftType.morning:
        return '早班';
      case ShiftType.afternoon:
        return '中班';
      case ShiftType.night:
        return '晚班';
      case ShiftType.off:
        return '休息';
    }
  }

  static Color getShiftColor(ShiftType type) {
    switch (type) {
      case ShiftType.none:
        return Colors.transparent;
      case ShiftType.morning:
        return Colors.blue.shade100;
      case ShiftType.afternoon:
        return Colors.orange.shade100;
      case ShiftType.night:
        return Colors.purple.shade100;
      case ShiftType.off:
        return Colors.green.shade100;
    }
  }

  static Color getShiftTextColor(ShiftType type) {
    switch (type) {
      case ShiftType.none:
        return Colors.black;
      case ShiftType.morning:
        return Colors.blue.shade800;
      case ShiftType.afternoon:
        return Colors.orange.shade800;
      case ShiftType.night:
        return Colors.purple.shade800;
      case ShiftType.off:
        return Colors.green.shade800;
    }
  }
}
