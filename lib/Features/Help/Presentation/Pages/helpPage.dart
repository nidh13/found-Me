import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/loadingWidget.dart';
import 'package:neopolis/Features/Help/Presentation/Widgets/helpDisplay.dart';
import 'package:neopolis/Features/Help/Presentation/bloc/help_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

class HelpPage extends StatelessWidget {
  final Profile profile;

  const HelpPage({Key key, @required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelpBloc, HelpState>(
      builder: (context, state) {
        if (state is EmptyHelpState) {
          return HelpDisplay(
            profile: profile,
          );
        }

        if (state is LoadingHelpState) {
          return LoadingWidget();
        }

        if (state is GoToHelpState) {
          Navigator.of(context).pushReplacementNamed(
            '/helpProvider',
          );
        }

/*
        if (state is LogoutState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/signinProvider',
              arguments: true,
            );
          });
        }
*/
        return LoadingWidget();
      },
    );
  }
}
