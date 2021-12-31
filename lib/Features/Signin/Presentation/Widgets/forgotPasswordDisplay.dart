import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Features/Signin/Presentation/bloc/login_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordDisplay extends StatefulWidget {
  @override
  _ForgotPasswordDisplayState createState() => _ForgotPasswordDisplayState();
}

class _ForgotPasswordDisplayState extends State<ForgotPasswordDisplay> {
  TextEditingController forgetemailcontroller = new TextEditingController();

  String forgetmailInputValue,
      forgetmailTitleValue,
      resetpassValue,
      forgetinfoValue,
      email;
  bool checkerEmail = true;
  bool checkerPassword = true;
  String checkerEmailMessage = "registration_info_email".tr();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;

    return new  WillPopScope(
   
      onWillPop: () async {
        
             
               return true; // return true if the route to be popped

      },
      child:Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .5,
                        color: Color.fromRGBO(236, 28, 64, 1),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * .5 / 7),
                          child: Image.asset(
                            'Assets/Images/resetpassword.png',
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(left:30.0, top:50),
                    child: InkWell(
                      onTap: (){
                        BlocProvider.of<LoginBloc>(context).dispatch(GoToSigninEvent());
                      },
                      child:    CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.transparent,
                                    child: SvgPicture.asset(
                                      'Assets/Images/arrowBack.svg',
                                    ))),
                  ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      //margin: EdgeInsets.only(top:50),
                      padding: EdgeInsets.fromLTRB(16.0, 15, 0.0, 0.0),
                      child: Text("forgetpwd_title".tr(),
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 28,
                            color: Color.fromRGBO(236, 28, 64, 1),
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      //margin: EdgeInsets.only(top:50),
                      padding: EdgeInsets.fromLTRB(16.0, 17, 50, 0.0),
                      child: Text(
                        "forgetpwd_info".tr(),
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(153, 153, 153, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 30, 50, 0.0),
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: forgetemailcontroller,
                      onChanged: (value) {
                        email = value;
                        setState(() {
                          checkerEmail = regExpEmail.hasMatch(email);
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "forgetpwd_btn_email".tr(),
                          contentPadding: const EdgeInsets.only(left: 11),
                          hintStyle: TextStyle(
                            fontSize: 18.0,
                            color: Color.fromRGBO(236, 28, 64, 0.5),
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                  checkerEmail
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Center(
                            child: Text(
                              checkerEmailMessage,
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: screenHeight * 50.5,
                  ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ButtonTheme(
                height:64.0,
                minWidth: MediaQuery.of(context).size.width ?? double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: RaisedButton(
                  color: Color(0xffEC1C40),
                  child: Text(
                      "forgetpwd_title".tr(),
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:  18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SFProText',
                      ),
                  ),
                  onPressed: () {
                      if (checkerEmail && email != null)
                            dispatchForgotPassword(
                                forgetemailcontroller.text.trim());
                      }
                  
                ),
              ),
                    ),
                
                   
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void dispatchForgotPassword(String email) {
    BlocProvider.of<LoginBloc>(context)
        .dispatch(ForgotPasswordEvent(email: email));
  }
}
