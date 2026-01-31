import 'package:flutter/widgets.dart';

typedef Validator = String? Function(String? value);

class Validators {
  static Validator required(String message) =>
      (value) => (value == null || value.trim().isEmpty) ? message : null;

  static Validator minLength(int min, String message) =>
      (value) => (value != null && value.length < min) ? message : null;

  static Validator email(String message) => (value) {
        if (value == null || value.trim().isEmpty) return null;
        // 更宽松且正确的邮箱正则，支持类似 123213@qq.com 的常见邮箱格式
        final emailReg = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[A-Za-z]{2,}$');
        return emailReg.hasMatch(value) ? null : message;
      };

  static Validator match(TextEditingController other, String message) =>
      (value) => (value != null && value != other.text) ? message : null;

  static Validator compose(List<Validator> validators) => (value) {
        for (final v in validators) {
          final res = v(value);
          if (res != null) return res;
        }
        return null;
      };
}
