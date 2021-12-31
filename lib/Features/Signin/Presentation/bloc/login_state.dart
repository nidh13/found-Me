part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const <dynamic>[]]) : super(props);
}

class SplashScreenDisplayState extends LoginState {}

class SplashScreenWidgetState extends LoginState {}

class EmptyLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class LoadedState extends LoginState {
  final Profile profile;

  LoadedState({@required this.profile});
}

class ErrorLoginState extends LoginState {
  final String email;
  final String password;
  final String message;

  ErrorLoginState({
    this.email,
    this.password,
    @required this.message,
  });
}

class GoToSignupState extends LoginState {}

class GoToSigninState extends LoginState {}

class GoToForgotPasswordState extends LoginState {}

class GoToTermsOfUseState extends LoginState {}

class GoToPrivacyPolicyState extends LoginState {}

class RegistredState extends LoginState {
  final String message;

  RegistredState({@required this.message});
}

class ForgotPasswordState extends LoginState {
  final String message;

  ForgotPasswordState({@required this.message});
}
