import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/loadingWidget.dart';
import 'package:neopolis/Core/Utils/splashScreenWidget.dart';
import 'package:neopolis/Features/Signin/Presentation/Widgets/TermsPoliceyDisplay.dart';
import 'package:neopolis/Features/Signin/Presentation/Widgets/forgotPasswordDisplay.dart';
import 'package:neopolis/Features/Signin/Presentation/Widgets/loginDisplay.dart';
import 'package:neopolis/Features/Signin/Presentation/Widgets/registerDisplay.dart';
import 'package:neopolis/Features/Signin/Presentation/Widgets/splashScreenDisplay.dart';
import 'package:neopolis/Features/Signin/Presentation/bloc/login_bloc.dart';

class SignInPage extends StatelessWidget {
  bool fromLogout;

  SignInPage({Key key, this.fromLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (fromLogout == true) {
          fromLogout = false;
          return LoginDisplay();
        }

        if (state is SplashScreenDisplayState) {
          return SplashScreenDisplay();
        }

        if (state is SplashScreenWidgetState) {
          return SplashScreenWidget();
        }

        if (state is EmptyLoginState) {
          return LoginDisplay();
        }

        if (state is LoadingLoginState) {
          return LoadingWidget();
        }

        if (state is ErrorLoginState) {
          return LoginDisplay(
            message: state.message,
          );
        }

        if (state is LoadedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/homeProvider',
              arguments: state.profile,
            );
          });
        }

        if (state is GoToSignupState) {
          return RegisterDisplay();
        }

        if (state is GoToSigninState) {
          return LoginDisplay();
        }

        if (state is GoToForgotPasswordState) {
          return ForgotPasswordDisplay();
        }

        if (state is GoToTermsOfUseState) {
          return TermsOfUseDisplay();
        }

        if (state is GoToPrivacyPolicyState) {
          return PrivacyPolicyDisplay();
        }

        if (state is RegistredState) {
          return LoginDisplay(
            message: state.message,
          );
        }

        if (state is ForgotPasswordState) {
          return LoginDisplay(
            message: state.message,
          );
        }

        return LoadingWidget();
      },
    );
  }
}
