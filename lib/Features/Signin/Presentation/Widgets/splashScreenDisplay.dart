import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Signin/Presentation/bloc/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenDisplay extends StatefulWidget {
  const SplashScreenDisplay({
    Key key,
  }) : super(key: key);

  @override
  _SplashScreenDisplayState createState() => _SplashScreenDisplayState();
}

class _SplashScreenDisplayState extends State<SplashScreenDisplay> {
  Future<bool> stayConnected;

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 1000), () {
      stayLoggedIn();
    });
  }

  stayLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("stayConnected") == true) {
      BlocProvider.of<LoginBloc>(context).dispatch(
        SigninEvent(
          email: prefs.getString("email"),
          password: prefs.getString("password"),
          type: prefs.getString("type"),
          isConnected: true,
        ),
      );
    } else {
      Timer(Duration(milliseconds: 1000), () {
        BlocProvider.of<LoginBloc>(context).dispatch(GoToSigninEvent());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    double screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "Assets/Images/logo.png",
              height: screenHeight * 250,
              width: screenWidth * 250,
            ),
            SizedBox(height: screenWidth * 50),
            Text(
              "V 0.4.5",
              textScaleFactor: 1.0,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xff231F20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
