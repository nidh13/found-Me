import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/loadingWidget.dart';
import 'package:neopolis/Features/Messages/Presentation/Widgets/MessagesComponents/chat.dart';
import 'package:neopolis/Features/Messages/Presentation/Widgets/messagesDisplay.dart';
import 'package:neopolis/Features/Messages/Presentation/bloc/messages_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

class MessagesPage extends StatelessWidget {
  final Profile profile;

  const MessagesPage({Key key, @required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesBloc, MessagesState>(
      builder: (context, state) {
        if (state is EmptyMessagesState) {
          BlocProvider.of<MessagesBloc>(context).dispatch(
            GoToMessagesEvent(
              profile: profile,
            ),
          );
        }

        if (state is GoToSpecificMessageState) {
          return Chat(
            profile: state.profile,
          );
        }

        if (state is GoToMessagesState) {
          return MessagesDisplay(
            profile: state.profile,
          );
        }

        if (state is LoadingSendMessagesState) {
          return Chat(
            profile: state.profile,
          );
        }

        if (state is SendMessageState) {
          return Chat(
            profile: state.profile,
          );
        }

        if (state is GoToHomeState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/homeProvider',
              arguments: state.profile,
            );
          });
        }

        return LoadingWidget();
      },
    );
  }
}
