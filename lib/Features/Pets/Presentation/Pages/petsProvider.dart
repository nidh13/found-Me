import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Pets/Presentation/Pages/petsPage.dart';
import 'package:neopolis/Features/Pets/Presentation/bloc/pets_bloc.dart';
import 'package:neopolis/injection_container.dart';

class PetsProvider extends StatelessWidget {
  final Profile profile;
  final int index;
  final String route;
  const PetsProvider(
      {Key key, @required this.profile, this.index, @required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        body: BlocProvider(
          builder: (_) => sl<PetsBloc>(),
          child: PetsPage(
            profile: profile,
            index: index,
            route: route,
          ),
        ),
      ),
    );
  }
}
