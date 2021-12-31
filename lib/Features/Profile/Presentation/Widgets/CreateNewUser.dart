import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/back_appbar.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateNewUserDisplay extends StatefulWidget {
  final Profile profile;

  CreateNewUserDisplay({Key key, @required this.profile}) : super(key: key);

  @override
  _CreateNewUserDisplayState createState() => _CreateNewUserDisplayState();
}

class _CreateNewUserDisplayState extends State<CreateNewUserDisplay> {
  GlobalKey btnKey = GlobalKey();
  var screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    Profile profile;

    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: (screenHeight * 21.5) / 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFFEC1C40), Color(0xffF26728)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(23.0),
                            bottomLeft: Radius.circular(23.0)),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2.0,
                            spreadRadius: 0.01,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        backAppBar(
                            onPressed: () {
                              dispatchGoToHome(profile);
                            },
                            profile: profile,
                            title: "editprofil_label_newaccount".tr(),
                            backgroundColor: Colors.transparent,
                            context: context),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  'editprofil_label_createnewaccount'.tr(),
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 16.0, color: Color.fromRGBO(153, 153, 153, 1)),
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(245, 245, 245, 1),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5.0,
                          spreadRadius: 0.01,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: screenHeight * 0.066,
                              width: screenWidth * 0.14,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(236, 28, 64, 1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10)),
                              ),
                            ),
                            Container(
                              color: Color.fromRGBO(238, 238, 238, 1),
                              child: Text.rich(
                                TextSpan(),
                                textScaleFactor: 1.0,
                              ),
                            )
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ));
    });
  }

  void dispatchGoToHome(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/homeProvider',
      arguments: profile,
    );
  }
}
