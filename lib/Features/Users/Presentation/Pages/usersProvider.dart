import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Presentation/bloc/users_bloc.dart';
import 'package:neopolis/injection_container.dart';
import 'package:neopolis/Features/Users/Presentation/Pages/usersPage.dart';

class UsersProvider extends StatelessWidget {
  final Profile profile;
final String route;
final int index;
  const UsersProvider({Key key, @required this.profile,     @required this.route,  @required this.index
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        body: BlocProvider(
          builder: (_) => sl<UsersBloc>(),
          child: UsersPage(
            profile: profile,
            route:route,
            index: index,
          ),
        ),
      ),
    );
  }
}
