import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Core/Utils/text.dart';

class PetsPopup extends ModalRoute<void> {
  final Profile profile;

  PetsPopup(this.profile);

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  double screenWidth;
  double screenHeight;

  List nameList = ['Df', 'Vb'];
  var nameData;

  final ScrollController nameScroll = ScrollController();
  List<String> name = ["g", "f", "h", "e", "t"];
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context, profile),
      ),
    );
  }

  List<UserEmergencyContact> listEmergency = [];

  List<UserEmergencyContact> listEmergencyContact() {
    profile.userGeneralInfo.userEmergencyContact.forEach((element) {
      listEmergency.add(element);
    });
  }

  Widget _buildOverlayContent(BuildContext context, Profile profile) {
    listEmergencyContact();
    return OrientationBuilder(
      builder: (context, orientation) {
        if (Orientation.portrait == orientation) {
          screenWidth = MediaQuery.of(context).size.width;
          screenHeight = MediaQuery.of(context).size.height;
        } else {
          screenWidth = MediaQuery.of(context).size.height;
          screenHeight = MediaQuery.of(context).size.width;
        }

        return Container(
            height: screenHeight * 1.0,
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  width: screenWidth * 0.85,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 17, bottom: 17, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              value: "homescree_subtitle_pet".tr(),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.pinkColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: screenHeight * 0.5,
                              child: GridView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 12.0,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: MediaQuery.of(context)
                                                .size
                                                .width /
                                            (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.35)),
                                itemCount:
                                    profile.userGeneralInfo.petsInfos.length +
                                        1,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      if (index == 0)
                                        GestureDetector(
                                          onTap: () {
                                            PetsInfos petInfo = PetsInfos(
                                                petTag: List<PetTag>(),
                                                preferencePet: PreferenceUser(
                                                  allowLiveChat: Allow(
                                                      accesLabelTxt: profile
                                                          .userGeneralInfo
                                                          .preferenceUser
                                                          .allowLiveChat
                                                          .accesLabelTxt,
                                                      value: '1'),
                                                  allowShareEmails: Allow(
                                                      accesLabelTxt: profile
                                                          .userGeneralInfo
                                                          .preferenceUser
                                                          .allowShareEmails
                                                          .accesLabelTxt,
                                                      value: '1'),
                                                  allowShareName: Allow(
                                                      accesLabelTxt: profile
                                                          .userGeneralInfo
                                                          .preferenceUser
                                                          .allowShareName
                                                          .accesLabelTxt,
                                                      value: '1'),
                                                  allowSharePhone: Allow(
                                                      accesLabelTxt: profile
                                                          .userGeneralInfo
                                                          .preferenceUser
                                                          .allowSharePhone
                                                          .accesLabelTxt,
                                                      value: '1'),
                                                  allowSharePicture: Allow(
                                                      accesLabelTxt: profile
                                                          .userGeneralInfo
                                                          .preferenceUser
                                                          .allowSharePicture
                                                          .accesLabelTxt,
                                                      value: '1'),
                                                  includeMail1: Allow(
                                                      accesLabelTxt: profile
                                                          .userGeneralInfo
                                                          .preferenceUser
                                                          .includeMail1
                                                          .accesLabelTxt,
                                                      value: '1'),
                                                  includeMail2: Allow(
                                                      accesLabelTxt: profile
                                                          .userGeneralInfo
                                                          .preferenceUser
                                                          .includeMail2
                                                          .accesLabelTxt,
                                                      value: profile
                                                          .userGeneralInfo
                                                          .preferenceUser
                                                          .includeMail2
                                                          .value),
                                                  includeMobile: Allow(
                                                      accesLabelTxt: profile
                                                          .userGeneralInfo
                                                          .preferenceUser
                                                          .includeMobile
                                                          .accesLabelTxt,
                                                      value: '1'),
                                                ),
                                                emergencyContact: listEmergency,
                                                generalInfo: GeneralInfo(
                                                    delete: 0,
                                                    active: 1,
                                                    birthInfo: BirthDateInfo(
                                                        day: '01',
                                                        month: '01',
                                                        year: 2020),
                                                    picturePet:
                                                        'https://s3.amazonaws.com/vetterpc-images/pet_placeholderimage.jpg',
                                                    idPet: null,
                                                    idPicture: null,
                                                    dateBirth:
                                                        "Fri, 29 Jan 2018 00:00:00 GMT",
                                                    heightweight:
                                                        Heightweight(),
                                                    microscopic: Microscopic()),
                                                otherInfo: List<OtherInfo>(),
                                                vaccins: List<Vaccins>());
                                            profile.userGeneralInfo.petsInfos
                                                .add(petInfo);
                                            profile.userGeneralInfo.update =
                                                true;
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                              '/petsProvider',
                                              arguments: {
                                                'profile': profile,
                                                'index': profile.userGeneralInfo
                                                        .petsInfos.length -
                                                    1,
                                                'route': 'GoToAddEditPetProfile'
                                              },
                                            );
                                            // Navigator.of(context)
                                            //     .push(Scan4Dialog(profile));
                                          },
                                          child: Container(
                                            height: 150,
                                            width: screenWidth * 0.231,
                                            decoration: BoxDecoration(
                                                color: ColorConstant.lightGrey,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                boxShadow: [
                                                  new BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(1.0, 4.0),
                                                    //  spreadRadius: 7.0,
                                                    blurRadius: 5.0,
                                                  ),
                                                ]),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 30, 8, 5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Image.asset(
                                                      "Assets/Images/add.png",
                                                      height: 39,
                                                      color: ColorConstant
                                                          .pinkColor,
                                                      width: 39),
                                                  MyText(
                                                      value:
                                                          'homescree_btn_addnew'
                                                              .tr(),
                                                      fontSize: 10,
                                                      color: ColorConstant
                                                          .pinkColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (index != 0)
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                '/petsProvider',
                                                arguments: {
                                                  'profile': profile,
                                                  'index': index - 1,
                                                  'route': 'GoToViewPetProfile'
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: screenWidth * 0.25,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  color:
                                                      ColorConstant.lightGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    new BoxShadow(
                                                      color: Colors.black26,
                                                      offset: Offset(1.0, 4.0),
                                                      //  spreadRadius: 7.0,
                                                      blurRadius: 5.0,
                                                    ),
                                                  ]),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height:
                                                          (screenWidth * 19.2) /
                                                              100,
                                                      width:
                                                          (screenWidth * 19.2) /
                                                              100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 3.0),
                                                          boxShadow: [
                                                            new BoxShadow(
                                                              color:
                                                                  Colors.black,
                                                              blurRadius: 2.0,
                                                              spreadRadius:
                                                                  0.01,
                                                            ),
                                                          ],
                                                          image: DecorationImage(
                                                              image: NetworkImage(profile
                                                                  .userGeneralInfo
                                                                  .petsInfos[
                                                                      index - 1]
                                                                  .generalInfo
                                                                  .picturePet),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child:
                                                        viewFisrtNameLastNameMember(
                                                      profile
                                                          .userGeneralInfo
                                                          .petsInfos[index - 1]
                                                          .generalInfo
                                                          .name,
                                                      '',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("Assets/Images/close.png"))),
                    ),
                  ),
                )
              ],
            )));
      },
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  viewFisrtNameLastNameMember(String first, String last) {
    if (first != null && last == null) {
      return MyText(
        value: first,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      );
    }
    if (first == null && last != null) {
      return MyText(
        value: last,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      );
    }
    if (first == null && last == null) {
      return MyText(
        value: ' ',
        maxLines: 1,
        //  textScaleFactor: 1.0,
        overflow: TextOverflow.ellipsis,

        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      );
    }
    if (first != null && last != null) {
      return MyText(
        value: first + ' ' + last,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      );
    }
  }
}
