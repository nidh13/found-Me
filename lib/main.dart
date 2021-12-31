import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:neopolis/Core/Routes/routes.dart';
import 'package:neopolis/injection_container.dart' as sl;
import 'package:easy_localization/easy_localization.dart';

void main() {
  sl.init();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('ar', 'TN'),
      ],
      path: 'Assets/Languages',
      useOnlyLangCode: true,
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    initializeDateFormatting();

    return MaterialApp(
      title: 'FOUND ME ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SourceSansPro',
        primaryColor: Color.fromRGBO(236, 28, 64, 1.0),
      ),
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      initialRoute: '/signinProvider',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
