import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Presentation/bloc/users_bloc.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';

class AddNewUserDisplay extends StatefulWidget {
  final Profile profile;

  AddNewUserDisplay({Key key, @required this.profile}) : super(key: key);

  @override
  _AddNewUserDisplayState createState() => _AddNewUserDisplayState();
}

class _AddNewUserDisplayState extends State<AddNewUserDisplay> {
  GlobalKey btnKey = GlobalKey();
  var screenWidth, screenHeight;
  bool maxNombreAdmin = false;
  List<UserEmergencyContact> emergencyContact = [];
  nombreUserAdmin() {
    widget.profile.userGeneralInfo.subUsers.forEach((element) {
      if (element.userGeneralInfo.role == 2) {
        maxNombreAdmin = true;
      }
    });
    widget.profile.userGeneralInfo.userEmergencyContact.forEach((element) {
      emergencyContact.add(element);
    });
  }

  @override
  void initState() {
    nombreUserAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

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
          appBar: PreferredSize(
              child: Container(
                height: (screenHeight * 20.5) / 100,
                decoration: BoxDecoration(
                  color: ColorConstant.pinkColor,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          dispatchGoToHome(profile);
                        },
                        child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                              'Assets/Images/arrowBack.svg',
                            ))),
                    MyText(
                        value: "editprofil_label_newuser".tr(),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    IconButton(
                      icon: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.transparent,
                          child: SvgPicture.asset(
                            'Assets/Images/FAQ.svg',
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HelpDisplay(profile: profile)));
                      },
                    )
                  ],
                ),
              ),
              preferredSize: Size.fromHeight((screenHeight * 21.5) / 100)),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        children: <Widget>[],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  //check me
                  MyText(
                      value: "editprofil_label_createnewaccount".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: Color.fromRGBO(153, 153, 153,
                          1)) /*Text(
                    "editprofil_label_createnewaccount".tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontFamily: "SFProText",
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: Color.fromRGBO(153, 153, 153, 1)),
                  )*/
                  ,
                  SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: maxNombreAdmin == false
                        ? () {
                            setState(() {
                              Profile addSubUser = Profile(
                                  userGeneralInfo: UserGeneralInfo(
                                    address: Address(),
                                    active: 1,
                                    idSubUser: null,
                                    birthInfo: BirthDateInfo(),
                                    birthDate: "Fri, 29 Jan 1993 00:00:00 GMT",
                                    userTags: UserTags(
                                        medicalTag: List<MedicalTag>(),
                                        objectTag: List<ObjectTag>()),
                                    preferenceUser: PreferenceUser(
                                        allowLiveChat: Allow(
                                            accesLabelTxt: profile
                                                .userGeneralInfo
                                                .preferenceUser
                                                .allowLiveChat
                                                .accesLabelTxt,
                                            value: '0'),
                                        allowShareEmails: Allow(
                                            accesLabelTxt: profile
                                                .userGeneralInfo
                                                .preferenceUser
                                                .allowShareEmails
                                                .accesLabelTxt,
                                            value: '0'),
                                        allowShareName: Allow(
                                            accesLabelTxt: profile
                                                .userGeneralInfo
                                                .preferenceUser
                                                .allowShareName
                                                .accesLabelTxt,
                                            value: '0'),
                                        allowSharePhone: Allow(
                                            accesLabelTxt: profile
                                                .userGeneralInfo
                                                .preferenceUser
                                                .allowSharePhone
                                                .accesLabelTxt,
                                            value: '0'),
                                        allowSharePicture:
                                            Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.allowSharePicture.accesLabelTxt, value: '0'),
                                        includeMail1: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.includeMail1.accesLabelTxt, value: '0'),
                                        includeMail2: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.includeMail2.accesLabelTxt, value: '0'),
                                        includeMobile: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.includeMobile.accesLabelTxt, value: '0'),
                                        shareChildName: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.shareChildName.accesLabelTxt, value: '0'),
                                        shareChildPicture: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.shareChildPicture.accesLabelTxt, value: '0')),
                                    userEmergencyContact:
                                        List<UserEmergencyContact>(),
                                    subUsers: List<Profile>(),
                                  ),
                                  medicalRecord: MedicalRecord(
                                      organDonar: OrganDonor(
                                          documents: List<Documents>()),
                                      heightweight: Heightweight(),
                                      resuscitate: Resuscitate(
                                          documents: List<Documents>()),
                                      insuranceInfo: List<InsuranceInfo>(),
                                      miscilanious: List<Miscilanious>(),
                                      otherMedicalRecordInfo:
                                          List<OtherMedicalRecordInfo>(),
                                      userEmergencyContact:
                                          List<UserEmergencyContact>(),
                                      bloodInfo:
                                          BloodInfo(diabates: List<Diabates>()),
                                      physicianContact:
                                          List<PhysicianContact>(),
                                      medicalDiseaces: MedicalDiseaces(
                                          allergies: Allergies(
                                            blocks: List<Blocks>(),
                                          ),
                                          cancer:
                                              Cancer(blocks: List<Blocks>()),
                                          cardiac:
                                              Allergies(blocks: List<Blocks>()),
                                          implants:
                                              Allergies(blocks: List<Blocks>()),
                                          infectionDisaces:
                                              Allergies(blocks: List<Blocks>()),
                                          medication:
                                              Allergies(blocks: List<Blocks>()),
                                          plumonary:
                                              Allergies(blocks: List<Blocks>()),
                                          psychiatric:
                                              Allergies(blocks: List<Blocks>()),
                                          renalKenedy:
                                              Allergies(blocks: List<Blocks>()),
                                          neuroligic: Allergies(
                                              blocks: List<Blocks>()))),
                                  parameters: Parameters());
                              profile.userGeneralInfo.subUsers.add(addSubUser);
                              profile.userGeneralInfo.subUsers.last
                                  .userGeneralInfo.role = 2;
                              profile.userGeneralInfo.update = true;

                              profile.parameters.newUser = true;
                              profile.userGeneralInfo.subUsers.last
                                      .userGeneralInfo.roleLabel =
                                  profile.parameters.roleUser[1]['role_label'];
                            });
                            BlocProvider.of<UsersBloc>(context).dispatch(
                              GoToAddPictureToNewUserEvent(
                                profile: profile,
                              ),
                            );
                          }
                        : null,
                    child: Container(
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: screenHeight * 0.066,
                                  width: screenWidth * 0.14,
                                  decoration: BoxDecoration(
                                    color: maxNombreAdmin == false
                                        ? ColorConstant.pinkColor
                                        : ColorConstant.greyColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10)),
                                  ),
                                  child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        'Assets/Images/IconAddUser.svg',
                                      )),
                                ),
                                Material(
                                  elevation: 2,
                                  child: Container(
                                    height: screenHeight * 0.066,
                                    width: screenWidth * 0.66,
                                    color: Color.fromRGBO(238, 238, 238, 1),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text.rich(
                                          TextSpan(
                                            text:
                                                "editprofil_label_createadministrator"
                                                    .tr(),
                                            children: [
                                              TextSpan(
                                                text: '(2 ' +
                                                    'editprofil_label_max'
                                                        .tr() +
                                                    ')',
                                                style: TextStyle(
                                                  fontFamily: "SFProText",
                                              fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color:
                                                      ColorConstant.pinkColor,
                                                ),
                                              ),
                                            ],
                                            style: TextStyle(
                                              fontFamily: "SFProText",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: ColorConstant.textColor,
                                            ),
                                          ),
                                          textScaleFactor: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            Container(
                              width: screenWidth * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, top: 20, right: 10),
                                child: Column(
                                  children: [
                                      MyText(
                                      value:
                                          "editprofil_label_createaccountmsg0".tr(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.textColor,
                                    ),
                                    SizedBox(height:12),
                                    MyText(
                                      value:
                                          "editprofil_label_createaccountmsg1".tr(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.textColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Profile addSubUser = Profile(
                            userGeneralInfo: UserGeneralInfo(
                              address: Address(),
                              active: 1,
                              idSubUser: null,
                              birthInfo: BirthDateInfo(),
                              birthDate: "Fri, 29 Jan 1993 00:00:00 GMT",
                              userTags: UserTags(
                                  medicalTag: List<MedicalTag>(),
                                  objectTag: List<ObjectTag>()),
                              preferenceUser: PreferenceUser(
                                  allowLiveChat: Allow(
                                      accesLabelTxt: profile
                                          .userGeneralInfo
                                          .preferenceUser
                                          .allowLiveChat
                                          .accesLabelTxt,
                                      value: '0'),
                                  allowShareEmails: Allow(
                                      accesLabelTxt: profile
                                          .userGeneralInfo
                                          .preferenceUser
                                          .allowShareEmails
                                          .accesLabelTxt,
                                      value: '0'),
                                  allowShareName: Allow(
                                      accesLabelTxt: profile
                                          .userGeneralInfo
                                          .preferenceUser
                                          .allowShareName
                                          .accesLabelTxt,
                                      value: '0'),
                                  allowSharePhone: Allow(
                                      accesLabelTxt: profile
                                          .userGeneralInfo
                                          .preferenceUser
                                          .allowSharePhone
                                          .accesLabelTxt,
                                      value: '0'),
                                  allowSharePicture: Allow(
                                      accesLabelTxt: profile.userGeneralInfo.preferenceUser.allowSharePicture.accesLabelTxt,
                                      value: '0'),
                                  includeMail1: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.includeMail1.accesLabelTxt, value: '0'),
                                  includeMail2: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.includeMail2.accesLabelTxt, value: '0'),
                                  includeMobile: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.includeMobile.accesLabelTxt, value: '0'),
                                  shareChildName: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.shareChildName.accesLabelTxt, value: '0'),
                                  shareChildPicture: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.shareChildPicture.accesLabelTxt, value: '0')),
                              userEmergencyContact:
                                  List<UserEmergencyContact>(),
                              subUsers: List<Profile>(),
                            ),
                            medicalRecord: MedicalRecord(
                                organDonar:
                                    OrganDonor(documents: List<Documents>()),
                                resuscitate:
                                    Resuscitate(documents: List<Documents>()),
                                heightweight: Heightweight(),
                                insuranceInfo: List<InsuranceInfo>(),
                                miscilanious: List<Miscilanious>(),
                                otherMedicalRecordInfo:
                                    List<OtherMedicalRecordInfo>(),
                                userEmergencyContact:
                                    List<UserEmergencyContact>(),
                                bloodInfo:
                                    BloodInfo(diabates: List<Diabates>()),
                                physicianContact: List<PhysicianContact>(),
                                medicalDiseaces: MedicalDiseaces(
                                    allergies: Allergies(
                                      blocks: List<Blocks>(),
                                    ),
                                    cancer: Cancer(blocks: List<Blocks>()),
                                    cardiac: Allergies(blocks: List<Blocks>()),
                                    implants: Allergies(blocks: List<Blocks>()),
                                    infectionDisaces:
                                        Allergies(blocks: List<Blocks>()),
                                    medication:
                                        Allergies(blocks: List<Blocks>()),
                                    plumonary:
                                        Allergies(blocks: List<Blocks>()),
                                    psychiatric:
                                        Allergies(blocks: List<Blocks>()),
                                    renalKenedy:
                                        Allergies(blocks: List<Blocks>()),
                                    neuroligic:
                                        Allergies(blocks: List<Blocks>()))),
                            parameters: Parameters());
                        profile.userGeneralInfo.subUsers.add(addSubUser);
                        profile.userGeneralInfo.update = true;

                        profile.parameters.newUser = true;

                        profile.userGeneralInfo.subUsers.last.userGeneralInfo
                            .role = 3;
                        profile.userGeneralInfo.subUsers.last.userGeneralInfo
                                .roleLabel =
                            profile.parameters.roleUser[2]['role_label'];
                      });
                      BlocProvider.of<UsersBloc>(context).dispatch(
                        GoToAddPictureToNewUserEvent(
                          profile: profile,
                        ),
                      );
                    },
                    child: Container(
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: screenHeight * 0.066,
                                  width: screenWidth * 0.14,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.pinkColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10)),
                                  ),
                                  child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        'Assets/Images/IconAddUser.svg',
                                      )),
                                ),
                                Material(
                                  elevation: 2,
                                  child: Container(
                                      height: screenHeight * 0.066,
                                      width: screenWidth * 0.66,
                                      color: Color.fromRGBO(238, 238, 238, 1),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: MyText(
                                              value:
                                                  "editprofil_label_createmember"
                                                      .tr(),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: ColorConstant.textColor,
                                            ),
                                          ))),
                                ),
                              ],
                            ),
                            Container(
                              width: screenWidth * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: MyText(
                                      value:
                                          "editprofil_label_createaccountmsg2"
                                              .tr(),
                                     fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.textColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Container(
                                      child: MyText(
                                        value: "• " +
                                            "editprofil_label_createaccountmsg3".tr(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstant.textColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: MyText(
                                      value: "• " +
                                          "editprofil_label_createaccountmsg4"
                                              .tr(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.textColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: MyText(
                                      value: "• " +
                                          "editprofil_label_createaccountmsg5"
                                              .tr(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.textColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: MyText(
                                      value: "• " +
                                          "editprofil_label_createaccountmsg6"
                                              .tr(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.textColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: MyText(
                                      value: "• " +
                                          "editprofil_label_createaccountmsg7"
                                              .tr(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.textColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Profile addSubUser = Profile(
                            userGeneralInfo: UserGeneralInfo(
                              address: Address(),
                              active: 1,
                              idSubUser: null,
                              birthInfo: BirthDateInfo(),
                              birthDate: "Fri, 29 Jan 1993 00:00:00 GMT",
                              userTags: UserTags(
                                  medicalTag: List<MedicalTag>(),
                                  objectTag: List<ObjectTag>()),
                              preferenceUser: PreferenceUser(
                                  allowLiveChat: Allow(
                                      accesLabelTxt: profile
                                          .userGeneralInfo
                                          .preferenceUser
                                          .allowLiveChat
                                          .accesLabelTxt,
                                      value: profile.userGeneralInfo
                                          .preferenceUser.allowLiveChat.value),
                                  allowShareEmails: Allow(
                                      accesLabelTxt: profile
                                          .userGeneralInfo
                                          .preferenceUser
                                          .allowShareEmails
                                          .accesLabelTxt,
                                      value: profile
                                          .userGeneralInfo
                                          .preferenceUser
                                          .allowShareEmails
                                          .value),
                                  allowShareName: Allow(
                                      accesLabelTxt:
                                          profile.userGeneralInfo.preferenceUser.allowShareName.accesLabelTxt,
                                      value: profile.userGeneralInfo.preferenceUser.allowShareName.value),
                                  allowSharePhone: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.allowSharePhone.accesLabelTxt, value: profile.userGeneralInfo.preferenceUser.allowSharePhone.value),
                                  allowSharePicture: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.allowSharePicture.accesLabelTxt, value: profile.userGeneralInfo.preferenceUser.allowSharePicture.value),
                                  includeMail1: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.includeMail1.accesLabelTxt, value: profile.userGeneralInfo.preferenceUser.includeMail1.value),
                                  includeMail2: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.includeMail2.accesLabelTxt, value: profile.userGeneralInfo.preferenceUser.includeMail2.value),
                                  includeMobile: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.includeMobile.accesLabelTxt, value: profile.userGeneralInfo.preferenceUser.includeMobile.value),
                                  shareChildName: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.shareChildName.accesLabelTxt, value: '0'),
                                  shareChildPicture: Allow(accesLabelTxt: profile.userGeneralInfo.preferenceUser.shareChildPicture.accesLabelTxt, value: '0')),
                              userEmergencyContact: emergencyContact,
                              subUsers: List<Profile>(),
                            ),
                            medicalRecord: MedicalRecord(
                                resuscitate:
                                    Resuscitate(documents: List<Documents>()),
                                organDonar:
                                    OrganDonor(documents: List<Documents>()),
                                heightweight: Heightweight(),
                                insuranceInfo: List<InsuranceInfo>(),
                                miscilanious: List<Miscilanious>(),
                                otherMedicalRecordInfo:
                                    List<OtherMedicalRecordInfo>(),
                                userEmergencyContact: emergencyContact,
                                bloodInfo:
                                    BloodInfo(diabates: List<Diabates>()),
                                physicianContact: List<PhysicianContact>(),
                                medicalDiseaces: MedicalDiseaces(
                                    allergies: Allergies(
                                      blocks: List<Blocks>(),
                                    ),
                                    cancer: Cancer(blocks: List<Blocks>()),
                                    cardiac: Allergies(blocks: List<Blocks>()),
                                    implants: Allergies(blocks: List<Blocks>()),
                                    infectionDisaces:
                                        Allergies(blocks: List<Blocks>()),
                                    medication:
                                        Allergies(blocks: List<Blocks>()),
                                    plumonary:
                                        Allergies(blocks: List<Blocks>()),
                                    psychiatric:
                                        Allergies(blocks: List<Blocks>()),
                                    renalKenedy:
                                        Allergies(blocks: List<Blocks>()),
                                    neuroligic:
                                        Allergies(blocks: List<Blocks>()))),
                            parameters: Parameters());

                        profile.userGeneralInfo.subUsers.add(addSubUser);
                        profile.userGeneralInfo.update = true;
                        profile.parameters.newUser = true;

                        profile.userGeneralInfo.subUsers.last.userGeneralInfo
                            .role = 4;
                        profile.userGeneralInfo.subUsers.last.userGeneralInfo
                                .roleLabel =
                            profile.parameters.roleUser[3]['role_label'];
                      });
                      BlocProvider.of<UsersBloc>(context).dispatch(
                        GoToAddPictureToNewUserEvent(
                          profile: profile,
                        ),
                      );
                    },
                    child: Container(
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: screenHeight * 0.066,
                                  width: screenWidth * 0.14,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.pinkColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10)),
                                  ),
                                  child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        'Assets/Images/IconAddUser.svg',
                                      )),
                                ),
                                Material(
                                  elevation: 2,
                                  child: Container(
                                      height: screenHeight * 0.066,
                                      width: screenWidth * 0.66,
                                      color: Color.fromRGBO(238, 238, 238, 1),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: MyText(
                                              value:
                                                  "editprofil_label_createchild"
                                                      .tr(),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: ColorConstant.textColor,
                                            ),
                                          ))),
                                ),
                              ],
                            ),
                            Container(
                              width: screenWidth * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: MyText(
                                        value:
                                            "editprofil_label_createaccountmsg8"
                                                .tr(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: ColorConstant.textColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        child: MyText(
                                          value: "• " +
                                              "editprofil_label_createaccountmsg9"
                                                  .tr(),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: ColorConstant.textColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: MyText(
                                        value: "• " +
                                            "editprofil_label_createaccountmsg10"
                                                .tr(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: ColorConstant.textColor,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: MyText(
                                        value:
                                            "editprofil_label_createaccountmsg11".tr(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: ColorConstant.textColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(height: 32)
                ],
              ),
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
