import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Help/Presentation/Pages/helpPage.dart';
import 'package:neopolis/Features/Help/Presentation/bloc/help_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/injection_container.dart';

class HelpProvider extends StatelessWidget {
  final Profile profile;
  const HelpProvider({Key key, @required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        body: BlocProvider(
          builder: (_) => sl<HelpBloc>(),
          child: HelpPage(
            profile: profile,
          ),
        ),
      ),
    );
  }
}
