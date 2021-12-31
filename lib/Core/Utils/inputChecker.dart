import 'package:easy_localization/easy_localization.dart';

RegExp regExpName = RegExp(
  r'(^[a-zA-Z0-9 ]*$)',
);
RegExp regExpEmail = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$",
);
RegExp regExpPassword = RegExp(
  r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$",
);
RegExp regExpNumber = RegExp(
  r'^\d+(?:\.\d+)?$',
);

Pattern passwordPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
Pattern emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
Pattern namePattern = r'(^[a-zA-Z0-9 ]*$)';
Pattern specialCharacterPatter =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)';
Pattern numberPatten = r'^(?:[+0]9)?[0-9]{10}$';
Pattern onedigit = r'^(?=.*?[0-9])';
Pattern uppercasePattern = r'^(?=.*[A-Z])';
Pattern specialCaracPattern = r'^(?=.*?[!@#\$&*~]).{8,}$';

String validPassword(String value) {
  RegExp passwordRegex = new RegExp(passwordPattern);
  if (value == null)
    return '';
  else if (value.isEmpty)
    return 'inputchecker_label_passwordrequired'.tr();
  else if (value.contains(' '))
    return 'inputchecker_label_spacesmsg'.tr();
  else if (!passwordRegex.hasMatch(value.toString()))
    return 'inputchecker_label_validpassword'.tr();
  else if (value.length < 7)
    return 'inputchecker_label_passwordmsg'.tr();
  else
    return '';
}

String validemail(String value) {
  RegExp regex = new RegExp(emailPattern);
  if (value == null) {
    return '';
  } else if (value.isEmpty) {
    return 'inputchecker_label_emailrequired'.tr();
  } else if (!regex.hasMatch(value.toString())) {
    return 'inputchecker_label_emailmsg'.tr();
  }
  return '';
}

String validfName(String value) {
  RegExp regex = new RegExp(namePattern);
  if (value == null) {
    return '';
  } else if (value.isEmpty) {
    return 'inputchecker_label_firstnamerequired'.tr();
  } else if (!regex.hasMatch(value.toString())) {
    return 'inputchecker_label_firstnamemsg'.tr();
  }
  return '';
}

String validlName(String value) {
  RegExp regex = new RegExp(namePattern);
  if (value == null) {
    return '';
  } else if (value.isEmpty) {
    return 'inputchecker_label_lastnamerequired'.tr();
  } else if (!regex.hasMatch(value.toString())) {
    return 'inputchecker_label_lastnamemsg'.tr();
  }
  return '';
}

String validnumber(String value) {
  RegExp regex = new RegExp(numberPatten);
  if (value == null) {
    return '';
  } else if (value.isEmpty) {
    return 'inputchecker_label_serialnumberrequired'.tr();
  } else if (!regex.hasMatch(value.toString())) {
    return 'inputchecker_label_serialnumbermsg'.tr();
  }
  return '';
}
