import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Messages/Presentation/Pages/messagesPage.dart';
import 'package:neopolis/Features/Messages/Presentation/bloc/messages_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/injection_container.dart';

class MessagesProvider extends StatelessWidget {
  final Profile profile;
  const MessagesProvider({Key key, @required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        body: BlocProvider(
          builder: (_) => sl<MessagesBloc>(),
          child: MessagesPage(
            profile: profile,
          ),
        ),
      ),
    );
  }
}
