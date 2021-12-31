import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/loadingWidget.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Notifications/Presentation/Widgets/notificationsDisplay.dart';
import 'package:neopolis/Features/Notifications/Presentation/bloc/notifications_bloc.dart';




class NotificationsPage extends StatelessWidget {
  final Profile profile;

  const NotificationsPage({Key key, @required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, Notificationstate>(
      builder: (context, state) {

  if (state is  EmptyNotificationsState) {
          return NotificationsDisplay(
            profile: profile,
          );
        }
        if (state is GoToNotoficationState) {
          return NotificationsDisplay(
            profile: profile,  
          );
        }
/* 
        if (state is LoadingHelpState) {
          return LoadingWidget();
        }

        if (state is GoToHelpState) {
          Navigator.of(context).pushReplacementNamed(
            '/helpProvider',
          );
        } */

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
