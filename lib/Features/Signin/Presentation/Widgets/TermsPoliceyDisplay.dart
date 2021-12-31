import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Signin/Presentation/bloc/login_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class TermsOfUseDisplay extends StatefulWidget {
  const TermsOfUseDisplay({Key key}) : super(key: key);

  @override
  _TermsOfUseDisplayState createState() => _TermsOfUseDisplayState();
}

class _TermsOfUseDisplayState extends State<TermsOfUseDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    dispatchGoToSignup();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 28.5, 0.0, 0.0),
                    child: ImageIcon(
                      AssetImage(
                        "Assets/Images/arrowBack.png",
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 90.0, 0.0, 0.0),
                  child: Text(
                    "registration_href_termsofuse".tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: "SourceSansPro",
                      color: Color(0xffEC1C40),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 160.0, 16.0, 0.0),
                  child: Text(
                    'Oporteat pericula vim at, sea ea epicuri tincidunt. Malis iracundia pri eu, prima movet definitionem sea ne. Id quo vero accommodare, sed cu velit summo. Et usu semper invenire reprehendunt, lucilius deserunt definiebas ex sit, dolor equidem consulatu pro et. Nulla quando voluptua est ea, enim debitis sententiae usu ei, usu graecis epicuri te. Usu eu rebum tamquam, decore impetus adipisci sed ut.\n',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "SFProText",
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void dispatchGoToSignup() {
    BlocProvider.of<LoginBloc>(context).dispatch(GoToSignupEvent());
  }
}

class PrivacyPolicyDisplay extends StatefulWidget {
  const PrivacyPolicyDisplay({Key key}) : super(key: key);

  @override
  _PrivacyPolicyDisplayState createState() => _PrivacyPolicyDisplayState();
}

class _PrivacyPolicyDisplayState extends State<PrivacyPolicyDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    dispatchGoToSignup();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 28.5, 0.0, 0.0),
                    child: ImageIcon(
                      AssetImage(
                        "Assets/Images/arrowBack.png",
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 109.0, 0.0, 0.0),
                  child: Text(
                    "registration_href_privacypolicy".tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: "SourceSansPro",
                      color: Color(0xffEC1C40),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 160.0, 16.0, 0.0),
                  child: Text(
                    'Oporteat pericula vim at, sea ea epicuri tincidunt. Malis iracundia pri eu, prima movet definitionem sea ne. Id quo vero accommodare, sed cu velit summo. Et usu semper invenire reprehendunt, lucilius deserunt definiebas ex sit, dolor equidem consulatu pro et. Nulla quando voluptua est ea, enim debitis sententiae usu ei, usu graecis epicuri te. Usu eu rebum tamquam, decore impetus adipisci sed ut.\n',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "SFProText",
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void dispatchGoToSignup() {
    BlocProvider.of<LoginBloc>(context).dispatch(GoToSignupEvent());
  }
}
