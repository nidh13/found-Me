import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Home/Presentation/Pages/homePage.dart';
import 'package:neopolis/Features/Home/Presentation/bloc/home_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/injection_container.dart';

class HomeProvider extends StatelessWidget {
  final Profile profile;
  const HomeProvider({Key key, @required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        body: BlocProvider(
          builder: (_) => sl<HomeBloc>(),
          child: HomePage(
            profile: profile,
          ),
        ),
      ),
    );
  }
}
