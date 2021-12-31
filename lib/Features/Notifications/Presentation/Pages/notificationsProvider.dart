import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/injection_container.dart';
import 'package:neopolis/Features/Notifications/Presentation/bloc/notifications_bloc.dart';
import 'package:neopolis/Features/Notifications/Presentation/Pages/notificationsPage.dart';
class  NotificationsProvider extends StatelessWidget {
  final Profile profile;
  const NotificationsProvider({Key key, @required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        body: BlocProvider(
          builder: (_) => sl<NotificationsBloc>(),
          child: NotificationsPage(
            profile: profile,
          ),
        ),
      ),
    );
  }
}
