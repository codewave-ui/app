import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CUIFormValidator {
  static FormFieldValidator<T> gitUrl<T>() {
    return (T? valueCandidate) {
      if (valueCandidate is String) {
        String? temp = FormBuilderValidators.url()(valueCandidate);
        if (temp == null) return null;
        final regex = RegExp(
            r"(?:git|ssh|https?|git@[-\w.]+):(//)?(.*?)(\.git)(/?|#[-\w._]+?)$");
        if (regex.hasMatch(valueCandidate)) {
          return null;
        }
        return "The url is not a git URL";
      }
      return "The value is not a string!";
    };
  }

  static FormFieldValidator<T> minVersion<T>({
    required int major,
    required int minor,
    required int patch,
    String? errorText,
  }) {
    return (T? valueCandidate) {
      String err =
          errorText ?? "The minimum version required is $major.$minor.$patch!";
      if (valueCandidate == null) return err;
      if (valueCandidate is! String) return "The input value is not a string!";
      List<String> parsedValue = valueCandidate.split(".");
      if (parsedValue.length != 3) {
        return "The input value was not using semantic versioning!";
      }

      int majorInt = parsedValue[0].toInt();

      if (majorInt < major) {
        return err;
      } else if (majorInt > major) {
        return null;
      }

      int minorInt = parsedValue[1].toInt();

      if (majorInt == major && minorInt < minor) {
        return err;
      }

      if (minorInt == minor && parsedValue[2].toInt() < patch) {
        return err;
      }

      return null;
    };
  }
}

extension StringParserExtension on String {
  int toInt() {
    return int.parse(this);
  }
}
