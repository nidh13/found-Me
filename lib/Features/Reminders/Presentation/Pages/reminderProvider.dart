import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Reminders/Presentation/bloc/reminders_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/injection_container.dart';
import 'package:neopolis/Features/Reminders/Presentation/Pages/remindersPage.dart';

class RemindersProvider extends StatelessWidget {
  final Profile profile;
  final Reminders reminder;
  const RemindersProvider({
    Key key,
    @required this.profile,
    this.reminder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        body: BlocProvider(
          builder: (_) => sl<RemindersBloc>(),
          child: RemindersPage(
            profile: profile,
            reminder: reminder,
          ),
        ),
      ),
    );
  }
}
