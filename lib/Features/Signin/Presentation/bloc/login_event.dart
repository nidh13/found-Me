part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const <dynamic>[]]) : super(props);
}

class SigninEvent extends LoginEvent {
  final String email;
  final String password;
  final String type;
  final bool isConnected;

  SigninEvent(
      {@required this.email,
      @required this.password,
      @required this.type,
      @required this.isConnected})
      : super([email, password, isConnected]);
}

class SigningGoogleEvent extends LoginEvent {}

class SignupGoogleEvent extends LoginEvent {}

class SigningFacebookEvent extends LoginEvent {}

class ProfileShowEvent extends LoginEvent {
  final String idUser;
  final String idLanguage;
  final String idSession;

  ProfileShowEvent({
    @required this.idUser,
    @required this.idLanguage,
    @required this.idSession,
  }) : super([idUser, idLanguage, idSession]);
}

class GoToSigninEvent extends LoginEvent {}

class GoToSignupEvent extends LoginEvent {}

class GoToForgotPasswordEvent extends LoginEvent {}

class GoToTermsOfUseEvent extends LoginEvent {}

class GoToPrivacyPolicyEvent extends LoginEvent {}

class SignupEvent extends LoginEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  SignupEvent({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
  }) : super([firstName, lastName, email, password]);
}

class ForgotPasswordEvent extends LoginEvent {
  final String email;

  ForgotPasswordEvent({
    @required this.email,
  }) : super([email]);
}
