import 'package:flutter/material.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({
    Key key,
  }) : super(key: key);

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
