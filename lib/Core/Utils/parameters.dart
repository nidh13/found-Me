import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;
  final String type;

  LoginParams(
      {@required this.email, @required this.password, @required this.type})
      : super([email, password]);
}

class RegisterParams extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterParams({
    this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
  }) : super([firstName, lastName, email, password]);
}

class ResetPasswordParams extends Equatable {
  final Profile profile;
  final String oldPassword;
  final String newPassword;

  ResetPasswordParams({
    @required this.profile,
    @required this.oldPassword,
    @required this.newPassword,
  }) : super([profile, oldPassword, newPassword]);
}

class AddEditTagParams extends Equatable {
  final Profile profile;
  final String type;
  final int index;
  final int indexu;

  AddEditTagParams({
    @required this.profile,
    @required this.type,
    @required this.index,
    @required this.indexu,
  }) : super([profile, index]);
}

class AddEditUsersParams extends Equatable {
  final Profile profile;
  final int index;

  AddEditUsersParams({
    @required this.profile,
    @required this.index,
  }) : super([profile, index]);
}

class DeteleReminderParams extends Equatable {
  final Profile profile;
  final Reminders reminder;

  DeteleReminderParams({
    @required this.profile,
    @required this.reminder,
  }) : super([profile, reminder]);
}

class AddEditUploadFileUsersParams extends Equatable {
  final Profile profile;
  final int index;

  AddEditUploadFileUsersParams({
    @required this.profile,
    @required this.index,
  }) : super([profile, index]);
}

class AddEditObjectTagParams extends Equatable {
  final Profile profile;
  final int indexu;
  final int index;

  AddEditObjectTagParams({
    @required this.profile,
    @required this.indexu,
    @required this.index,
  }) : super([profile, index]);
}

class AddEditUploadFilePetsParams extends Equatable {
  final Profile profile;
  final int index;

  AddEditUploadFilePetsParams({
    @required this.profile,
    @required this.index,
  }) : super([profile, index]);
}

class EditNotificationsParams extends Equatable {
  final Profile profile;
  final int index;

  EditNotificationsParams({
    @required this.profile,
    @required this.index,
  }) : super([profile, index]);
}
