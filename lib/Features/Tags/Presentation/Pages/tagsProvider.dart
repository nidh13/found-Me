import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/Pages/tagsPage.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:neopolis/injection_container.dart';

class TagsProvider extends StatelessWidget {
  final Profile profile;
  final String viewTag;
  const TagsProvider({Key key, @required this.profile, @required this.viewTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        body: BlocProvider(
          builder: (_) => sl<TagsBloc>(),
          child: TagsPage(
            profile: profile,
            viewTag: viewTag,
          ),
        ),
      ),
    );
  }
}
