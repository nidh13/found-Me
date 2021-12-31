import 'package:flutter/material.dart';
import 'package:neopolis/Features/Help/Presentation/Pages/helpProvider.dart';
import 'package:neopolis/Features/Home/Presentation/Pages/homeProvider.dart';
import 'package:neopolis/Features/Messages/Presentation/Pages/messagesProvider.dart';
import 'package:neopolis/Features/Notifications/Presentation/Pages/notificationsProvider.dart';
import 'package:neopolis/Features/Profile/Presentation/Pages/profileProvider.dart';
import 'package:neopolis/Features/Reminders/Presentation/Pages/reminderProvider.dart';
import 'package:neopolis/Features/Signin/Presentation/Pages/signinProvider.dart';
import 'package:neopolis/Features/Tags/Presentation/Pages/tagsProvider.dart';
import 'package:neopolis/Features/Users/Presentation/Pages/UsersProvider.dart';
import 'package:neopolis/Features/Pets/Presentation/Pages/petsProvider.dart';
import 'package:easy_localization/easy_localization.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/signinProvider':
        return MaterialPageRoute(
          builder: (_) => SigninProvider(
            fromLogout: settings.arguments,
          ),
        );

      case '/homeProvider':
        return MaterialPageRoute(
          builder: (_) => HomeProvider(
            profile: settings.arguments,
          ),
        );

      case '/profileProvider':
        return MaterialPageRoute(
          builder: (_) => ProfileProvider(
            profile: settings.arguments,
          ),
        );

      case '/usersProvider':
        final map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => UsersProvider(
              profile: map['profile'],
              route: map['route'],
              index: map['index']),
        );

      case '/tagsProvider':
        return MaterialPageRoute(
          builder: (_) => TagsProvider(
            profile: settings.arguments,
            viewTag: "",
          ),
        );

      case '/helpProvider':
        return MaterialPageRoute(
          builder: (_) => HelpProvider(
            profile: settings.arguments,
          ),
        );

      case '/petsProvider':
        final map = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => PetsProvider(
            profile: map['profile'],
            index: map['index'],
            route: map['route'],
          ),
        );

      case '/messagesProvider':
        return MaterialPageRoute(
          builder: (_) => MessagesProvider(
            profile: settings.arguments,
          ),
        );

      case '/remindersProvider':
        final map = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => RemindersProvider(
            profile: map['profile'],
            reminder: map['reminders'],
          ),
        );

      case '/notificationsProvider':
        return MaterialPageRoute(
          builder: (_) => NotificationsProvider(
            profile: settings.arguments,
          ),
        );

/*
      case '/profileProvider':
        if (settings.arguments is Map) {
          
          final map = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => ProfileProvider(
              profile: map['profile'],
              state: map['state'],
            ),
          );
        }
*/

        return errorRoute();
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'label_error'.tr(),
                    style: TextStyle(
                      fontSize: 80.0,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    'label_errormsg'.tr(),
                    style: TextStyle(fontSize: 50.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
