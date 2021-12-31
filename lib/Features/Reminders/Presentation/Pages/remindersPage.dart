import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/loadingWidget.dart';
import 'package:neopolis/Features/Reminders/Presentation/Widgets/listingTagDisplay.dart';
import 'package:neopolis/Features/Reminders/Presentation/bloc/reminders_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

class RemindersPage extends StatelessWidget {
  final Profile profile;
  final Reminders reminder;
  const RemindersPage({
    Key key,
    @required this.profile,
    @required this.reminder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
      builder: (context, state) {
        if (state is EmptyReminderState) {
          if (profile.parameters.location == 'DeleteReminder') {
            BlocProvider.of<RemindersBloc>(context)
                .dispatch(DeleteReminderEvent(
              profile: profile,
              reminders: reminder,
            ));
          } else {
            BlocProvider.of<RemindersBloc>(context)
                .dispatch(GoToViewReminderListEvent(
              profile: profile,
            ));
          }
        }

        // if (state is InitialState) {
        //   BlocProvider.of<UsersBloc>(context).dispatch(
        //     GoToAddNewUserEvent(
        //       profile: profile,
        //     ),
        //   );
        // }

        if (state is GoToHomeScreenState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/homeProvider',
              arguments: profile,
            );
          });
        }

        if (state is GoToViewReminderListState) {
          return ListingReminders(
            profile: profile,
          );
        }

        if (state is LoadingReminderState) {
          return LoadingWidget();
        }

        return LoadingWidget();
      },
    );
  }
}
