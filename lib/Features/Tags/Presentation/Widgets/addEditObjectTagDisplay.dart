import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
/* import 'package:flutter_form_builder/flutter_form_builder.dart'; */
import 'package:image_picker/image_picker.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popup_menu.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/expandable_other_list.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/popupDeleteTag.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/animationEditTag.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/emergencyContactTag.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/alertDialogUpdate.dart';

class AddEditObjectTagDisplay extends StatefulWidget {
  final Profile profile;
  final String type;
  final int indexu;
  final int index;
  String loading;
  AddEditObjectTagDisplay(
      {Key key,
      @required this.profile,
      @required this.type,
      @required this.indexu,
      @required this.index,
      this.loading})
      : super(key: key);

  @override
  _AddEditObjectTagDisplayState createState() =>
      _AddEditObjectTagDisplayState();
}

class _AddEditObjectTagDisplayState extends State<AddEditObjectTagDisplay> {
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();

  bool AdvancedSettings = false;
  bool PosterFound = false;
  bool emergencyContacts = false;

  bool other = false;
  bool thankyou = false;
  bool _switchIncludemail = false;
  bool _switchIncludepic = false;
  bool _switchIncludename = false;
  File imageFile;

  bool alarm = true;
  int nombrebolckOther = 0;
  int nbblock = 5;
  TextEditingController physicianContactController =
      new TextEditingController();

  bool lostPoster = false;
  //also contacts
  bool alsoContact = true;
  bool PetName = false;
  bool ViewExport = false;
  TextEditingController contact1controller = new TextEditingController();
  var namedata;
  FocusNode _thankYouFocus = FocusNode();
  bool ObjectInfo = false;
  bool _visiOther = true;
//Allow in app chat
  bool _switchAllow = true;

//Include my first name

  int nombrebolckAlsoContact;
  //Include my phone number
  bool _switchIncludePhone = true;
  Map<dynamic, dynamic> some = {};
  bool _visibile = true;
  bool _visi = true;

  //Include my real address
  bool realAddress = false;

  //Include my temporary Address
  bool tempAddress = false;
  bool DescriptionObject = false;

  bool vaccines = false;
  TextEditingController vaccinesController = new TextEditingController();
  FocusNode vaccinesFocus = FocusNode();

  //ThankYou
  TextEditingController thankYouController = new TextEditingController();
  FocusNode thankFocus = FocusNode();

  //Reward
  bool rewards = false;
  bool _switchReward = true;
  TextEditingController rewardController = new TextEditingController();
  FocusNode rewardFocus = FocusNode();
  var rewardData;
  bool _switchAllowMobile;

  List rewardList = [
    '10',
    '20',
    '30',
    '40',
  ];
  List<bool> addBlockEmergTag = [];
  List<bool> addBlockOtherTag = [];
  List<Map<String, dynamic>> idMembers = [];
  bool member;
  String thisMember;
  owner() {
    idMembers.add({
      'firstName': widget.profile.userGeneralInfo.firstName,
      'idMember': widget.profile.userGeneralInfo.idMember,
    });
    widget.type == 'object'
        ? widget.profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
            .tags[index].emergencyContactUser
            .forEach((element) {
            addBlockEmergTag.add(false);
          })
        : widget.profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
            .tags[index].emergencyContactUser
            .forEach((element) {
            addBlockEmergTag.add(false);
          });
    widget.profile.userGeneralInfo.roleLabel == 'Administrator'
        ? widget.profile.userGeneralInfo.subUsers.forEach((element) {
            idMembers.add({
              'firstName': element.userGeneralInfo.firstName,
              'idMember': element.userGeneralInfo.idMember,
            });
          })
        : null;

    widget.profile.userGeneralInfo.roleLabel == 'Administrator'
        ? member = false
        : member = true;
  }

  var ObjectData;
//miscelaneous
  bool miscellaneous = false;
  TextEditingController miscellaneousController = new TextEditingController();

//PetRecoard
  bool _viewRecord = false;
  bool _emailRecord = false;
  bool _printRecord = false;

//Found Poster
  bool _emailPoster = true;
  bool _printPoster = false;

  var screenWidth, screenHeight;
  double _petItemWidth = 0.0;
  int _petIndicatorIndex = 0;

  ScrollController _petScrollController = new ScrollController();

  void scrollListenerWithItemHeight() {
    double itemHeight =
        _petItemWidth; // including padding above and below the list item
    double scrollOffset = _petScrollController.offset;
    int firstVisibleItemIndex =
        scrollOffset < itemHeight ? 0 : ((scrollOffset) / itemHeight).toInt();
    _petIndicatorIndex = firstVisibleItemIndex;
    setState(() {});
  }

  List<Widget> listALsoContact = [];
  int index;
  int indexu;
  String type;
  void initState() {
    if (widget.profile.userGeneralInfo.message != null &&
        widget.profile.userGeneralInfo.message != 'null' &&
        widget.profile.userGeneralInfo.message != 'Success' &&
        widget.profile.userGeneralInfo.message != '') {
      Future.delayed(Duration.zero, () {
        showOverlay(context, "problem_infos".tr(),
            widget.profile.userGeneralInfo.message);
        widget.profile.userGeneralInfo.message = '';
      });
    }
    if (widget.profile.userGeneralInfo.update == null) {
      widget.profile.userGeneralInfo.update = false;
    }
    index = widget.index;
    indexu = widget.indexu;
    type = widget.type;
    type == 'object'
        ? nombrebolckAlsoContact = widget
            .profile
            .userGeneralInfo
            .tagsList
            .objectTag[widget.indexu]
            .tags[widget.index]
            .emergencyContactUser
            .length
        : nombrebolckAlsoContact = widget
            .profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .emergencyContactUser
            .length;

    type == 'object'
        ? widget.profile.userGeneralInfo.tagsList.objectTag[widget.indexu].tags[widget.index].tagInfo.tagCustumMessage ==
                null
            ? widget
                .profile
                .userGeneralInfo
                .tagsList
                .objectTag[widget.indexu]
                .tags[widget.index]
                .tagInfo
                .tagCustumMessage = widget.profile.userGeneralInfo.custumMessage
            : widget.profile.userGeneralInfo.tagsList.objectTag[widget.indexu].tags[widget.index].tagInfo.tagCustumMessage = widget
                .profile
                .userGeneralInfo
                .tagsList
                .objectTag[widget.indexu]
                .tags[widget.index]
                .tagInfo
                .tagCustumMessage
        : widget.profile.userGeneralInfo.tagsList.medicalTag[widget.indexu].tags[widget.index].tagInfo.tagCustumMessage ==
                null
            ? widget
                .profile
                .userGeneralInfo
                .tagsList
                .medicalTag[widget.indexu]
                .tags[widget.index]
                .tagInfo
                .tagCustumMessage = widget.profile.userGeneralInfo.custumMessage
            : widget
                .profile
                .userGeneralInfo
                .tagsList
                .medicalTag[widget.indexu]
                .tags[widget.index]
                .tagInfo
                .tagCustumMessage = widget.profile.userGeneralInfo.tagsList.medicalTag[widget.indexu].tags[widget.index].tagInfo.tagCustumMessage;
    owner();
    _petScrollController.addListener(scrollListenerWithItemHeight);

    widget.type == 'object'
        ? widget.profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
            .tags[widget.index].otherInfo
            .forEach((element) {
            addBlockOtherTag.add(false);
          })
        : widget.type == 'medical'
            ? widget.profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                .tags[widget.index].otherInfo
                .forEach((element) {
                addBlockOtherTag.add(false);
              })
            : widget.profile.userGeneralInfo.tagsList.petTag[widget.indexu]
                .tags[widget.index].otherInfo
                .forEach((element) {
                addBlockOtherTag.add(false);
              });
    super.initState();
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    if (item.type == "camera") {
      print("camera");
    } else if (item.type == "gallery") {
      print("gallary");
    } else
      print("file");
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void maxColumn() {
    PopupMenu menu = PopupMenu(
        backgroundColor: Colors.white,
        lineColor: ColorConstant.darkGray,
        maxColumn: 3,
        items: [
          MenuItem(
            type: "camera",
            image: Image.asset(
              "Assets/Images/camera-red.png",
              height: 14,
              width: 16.8,
            ),
          ),
          MenuItem(
              type: "gallery",
              image: Image.asset(
                "Assets/Images/gallery-red.png",
                height: 14,
                width: 18.68,
              )),
          MenuItem(
              type: "file",
              image: Image.asset(
                "Assets/Images/attachment-red.png",
                height: 14,
                width: 12.25,
              )),
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey);
  }

  bool isMember = false;
  emergencyContactOwner(String idMember, Profile profile) {
    if (widget.type == 'object') {
      if (idMember == profile.userGeneralInfo.idMember) {
        setState(() {
          profile.userGeneralInfo.tagsList.objectTag[widget.indexu].tags[index]
                  .emergencyContactUser =
              profile.userGeneralInfo.userEmergencyContact;
          widget.profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
              .tags[index].emergencyContactUser
              .forEach((element) {
            addBlockEmergTag.add(false);
          });
        });
        nombrebolckAlsoContact = widget
            .profile
            .userGeneralInfo
            .tagsList
            .objectTag[widget.indexu]
            .tags[widget.index]
            .emergencyContactUser
            .length;
      } else {
        profile.userGeneralInfo.subUsers.forEach((element) {
          if (element.userGeneralInfo.idMember == idMember) {
            profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                    .tags[index].emergencyContactUser =
                element.userGeneralInfo.userEmergencyContact;
          }
        });
        widget.profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
            .tags[index].emergencyContactUser
            .forEach((element) {
          addBlockEmergTag.add(false);
        });
      }
    } else if (widget.type == 'medical') {
      if (idMember == profile.userGeneralInfo.idMember) {
        setState(() {
          profile.userGeneralInfo.tagsList.medicalTag[widget.indexu].tags[index]
                  .emergencyContactUser =
              profile.userGeneralInfo.userEmergencyContact;
          widget.profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
              .tags[index].emergencyContactUser
              .forEach((element) {
            addBlockEmergTag.add(false);
          });
        });
        nombrebolckAlsoContact = widget
            .profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .emergencyContactUser
            .length;
      } else {
        profile.userGeneralInfo.subUsers.forEach((element) {
          if (element.userGeneralInfo.idMember == idMember) {
            profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                    .tags[index].emergencyContactUser =
                element.userGeneralInfo.userEmergencyContact;
          }
        });
        widget.profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
            .tags[index].emergencyContactUser
            .forEach((element) {
          addBlockEmergTag.add(false);
        });
        nombrebolckAlsoContact = widget
            .profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .emergencyContactUser
            .length;
      }
    }
  }

  alsoContactOwner(String idMember, Profile profile) {
    if (widget.type == 'object') {
      if (idMember == profile.userGeneralInfo.idMember) {
        setState(() {
          profile
              .userGeneralInfo
              .tagsList
              .objectTag[widget.indexu]
              .tags[widget.index]
              .tagUserInfo
              .firstName = profile.userGeneralInfo.firstName;
          profile
              .userGeneralInfo
              .tagsList
              .objectTag[widget.indexu]
              .tags[widget.index]
              .tagUserInfo
              .lastName = profile.userGeneralInfo.lastName;
          profile
              .userGeneralInfo
              .tagsList
              .objectTag[widget.indexu]
              .tags[widget.index]
              .tagUserInfo
              .mail = profile.userGeneralInfo.mail;
          profile
              .userGeneralInfo
              .tagsList
              .objectTag[widget.indexu]
              .tags[widget.index]
              .tagUserInfo
              .mail2 = profile.userGeneralInfo.mail2;
          profile
              .userGeneralInfo
              .tagsList
              .objectTag[widget.indexu]
              .tags[widget.index]
              .tagUserInfo
              .mobile = profile.userGeneralInfo.mobile;
          profile
              .userGeneralInfo
              .tagsList
              .objectTag[widget.indexu]
              .tags[widget.index]
              .tagUserInfo
              .codePhone = profile.userGeneralInfo.codePhone;
          profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                  .tags[widget.index].preferenceUser.allowLiveChat.value =
              profile.userGeneralInfo.preferenceUser.allowLiveChat.value;
          profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                  .tags[widget.index].preferenceUser.allowShareEmails.value =
              profile.userGeneralInfo.preferenceUser.allowShareEmails.value;
          profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                  .tags[widget.index].preferenceUser.allowSharePhone.value =
              profile.userGeneralInfo.preferenceUser.allowSharePhone.value;
          profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                  .tags[widget.index].preferenceUser.allowSharePicture.value =
              profile.userGeneralInfo.preferenceUser.allowSharePicture.value;
          profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                  .tags[widget.index].preferenceUser.includeMobile.value =
              profile.userGeneralInfo.preferenceUser.includeMobile.value;
          profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                  .tags[widget.index].preferenceUser.allowShareName.value =
              profile.userGeneralInfo.preferenceUser.allowShareName.value;
          profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                  .tags[widget.index].preferenceUser.includeMail1.value =
              profile.userGeneralInfo.preferenceUser.includeMail1.value;
          profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                  .tags[widget.index].preferenceUser.includeMail2.value =
              profile.userGeneralInfo.preferenceUser.includeMail2.value;
          isMember = false;
        });
        if (profile.userGeneralInfo.role == 3) {
          isMember = true;
        }
      } else {
        profile.userGeneralInfo.subUsers.forEach((element) {
          if (element.userGeneralInfo.idMember == idMember) {
            isMember = false;
            if (element.userGeneralInfo.role == 3) {
              isMember = true;
            }
            if (element.userGeneralInfo.role == 4) {
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .firstName = profile.userGeneralInfo.firstName;
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .lastName = profile.userGeneralInfo.lastName;
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mail = profile.userGeneralInfo.mail;
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mail2 = profile.userGeneralInfo.mail2;
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mobile = profile.userGeneralInfo.mobile;
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .codePhone = profile.userGeneralInfo.codePhone;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowLiveChat.value =
                  profile.userGeneralInfo.preferenceUser.allowLiveChat.value;
              profile
                      .userGeneralInfo
                      .tagsList
                      .objectTag[widget.indexu]
                      .tags[widget.index]
                      .preferenceUser
                      .allowShareEmails
                      .value =
                  profile.userGeneralInfo.preferenceUser.allowShareEmails.value;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowSharePhone.value =
                  profile.userGeneralInfo.preferenceUser.allowSharePhone.value;
              profile
                      .userGeneralInfo
                      .tagsList
                      .objectTag[widget.indexu]
                      .tags[widget.index]
                      .preferenceUser
                      .allowSharePicture
                      .value =
                  profile
                      .userGeneralInfo.preferenceUser.allowSharePicture.value;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMobile.value =
                  profile.userGeneralInfo.preferenceUser.includeMobile.value;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowShareName.value =
                  profile.userGeneralInfo.preferenceUser.allowShareName.value;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMail1.value =
                  profile.userGeneralInfo.preferenceUser.includeMail1.value;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMail2.value =
                  profile.userGeneralInfo.preferenceUser.includeMail2.value;
            } else {
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .firstName = element.userGeneralInfo.firstName;
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .lastName = element.userGeneralInfo.lastName;
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mail = element.userGeneralInfo.mail;
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mail2 = element.userGeneralInfo.mail2;
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mobile = element.userGeneralInfo.mobile;
              profile
                  .userGeneralInfo
                  .tagsList
                  .objectTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .codePhone = element.userGeneralInfo.codePhone;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowLiveChat.value =
                  element.userGeneralInfo.preferenceUser.allowLiveChat.value;
              profile
                      .userGeneralInfo
                      .tagsList
                      .objectTag[widget.indexu]
                      .tags[widget.index]
                      .preferenceUser
                      .allowShareEmails
                      .value =
                  element.userGeneralInfo.preferenceUser.allowShareEmails.value;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowSharePhone.value =
                  element.userGeneralInfo.preferenceUser.allowSharePhone.value;
              profile
                      .userGeneralInfo
                      .tagsList
                      .objectTag[widget.indexu]
                      .tags[widget.index]
                      .preferenceUser
                      .allowSharePicture
                      .value =
                  element
                      .userGeneralInfo.preferenceUser.allowSharePicture.value;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMobile.value =
                  element.userGeneralInfo.preferenceUser.includeMobile.value;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowShareName.value =
                  element.userGeneralInfo.preferenceUser.allowShareName.value;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMail1.value =
                  element.userGeneralInfo.preferenceUser.includeMail1.value;
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMail2.value =
                  element.userGeneralInfo.preferenceUser.includeMail2.value;
            }

            //  profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
            //     .tags[widget.index].preferenceUser.allowShareEmails.value =
            // element.userGeneralInfo.preferenceUser.allowShareEmails.value;
          }
        });
      }
    } else if (widget.type == 'medical') {
      if (idMember == profile.userGeneralInfo.idMember) {
        isMember = false;
        if (profile.userGeneralInfo.role == 3) {
          isMember = true;
        }
        profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .tagUserInfo
            .firstName = profile.userGeneralInfo.firstName;
        profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .tagUserInfo
            .lastName = profile.userGeneralInfo.lastName;
        profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
            .tags[widget.index].tagUserInfo.mail = profile.userGeneralInfo.mail;
        profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .tagUserInfo
            .mail2 = profile.userGeneralInfo.mail2;
        profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .tagUserInfo
            .mobile = profile.userGeneralInfo.mobile;
        profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .tagUserInfo
            .codePhone = profile.userGeneralInfo.codePhone;
        profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .preferenceUser
            .allowLiveChat
            .value = profile.userGeneralInfo.preferenceUser.allowLiveChat.value;
        profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                .tags[widget.index].preferenceUser.allowShareEmails.value =
            profile.userGeneralInfo.preferenceUser.allowShareEmails.value;
        profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                .tags[widget.index].preferenceUser.allowSharePhone.value =
            profile.userGeneralInfo.preferenceUser.allowSharePhone.value;
        profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                .tags[widget.index].preferenceUser.allowSharePicture.value =
            profile.userGeneralInfo.preferenceUser.allowSharePicture.value;
        profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .preferenceUser
            .includeMobile
            .value = profile.userGeneralInfo.preferenceUser.includeMobile.value;
        profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                .tags[widget.index].preferenceUser.allowShareName.value =
            profile.userGeneralInfo.preferenceUser.allowShareName.value;
        profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .preferenceUser
            .includeMail1
            .value = profile.userGeneralInfo.preferenceUser.includeMail1.value;
        profile
            .userGeneralInfo
            .tagsList
            .medicalTag[widget.indexu]
            .tags[widget.index]
            .preferenceUser
            .includeMail2
            .value = profile.userGeneralInfo.preferenceUser.includeMail2.value;
      } else {
        profile.userGeneralInfo.subUsers.forEach((element) {
          if (element.userGeneralInfo.idMember == idMember) {
            isMember = false;

            if (element.userGeneralInfo.role == 3) {
              isMember = true;
            }
            if (element.userGeneralInfo.role == 4) {
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .firstName = profile.userGeneralInfo.firstName;
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .firstName = profile.userGeneralInfo.lastName;
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mail = profile.userGeneralInfo.mail;
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mail2 = profile.userGeneralInfo.mail2;
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mobile = profile.userGeneralInfo.mobile;
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .codePhone = profile.userGeneralInfo.codePhone;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowLiveChat.value =
                  profile.userGeneralInfo.preferenceUser.allowLiveChat.value;
              profile
                      .userGeneralInfo
                      .tagsList
                      .medicalTag[widget.indexu]
                      .tags[widget.index]
                      .preferenceUser
                      .allowShareEmails
                      .value =
                  profile.userGeneralInfo.preferenceUser.allowShareEmails.value;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowSharePhone.value =
                  profile.userGeneralInfo.preferenceUser.allowSharePhone.value;
              profile
                      .userGeneralInfo
                      .tagsList
                      .medicalTag[widget.indexu]
                      .tags[widget.index]
                      .preferenceUser
                      .allowSharePicture
                      .value =
                  profile
                      .userGeneralInfo.preferenceUser.allowSharePicture.value;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMobile.value =
                  profile.userGeneralInfo.preferenceUser.includeMobile.value;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowShareName.value =
                  profile.userGeneralInfo.preferenceUser.allowShareName.value;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMail1.value =
                  profile.userGeneralInfo.preferenceUser.includeMail1.value;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMail2.value =
                  profile.userGeneralInfo.preferenceUser.includeMail2.value;
              //  profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
              //     .tags[widget.index].preferenceUser.allowShareEmails.value =
              // element.userGeneralInfo.preferenceUser.allowShareEmails.value;
            } else {
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .firstName = element.userGeneralInfo.firstName;
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .lastName = element.userGeneralInfo.lastName;
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mail = element.userGeneralInfo.mail;
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mail2 = element.userGeneralInfo.mail2;
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .mobile = element.userGeneralInfo.mobile;
              profile
                  .userGeneralInfo
                  .tagsList
                  .medicalTag[widget.indexu]
                  .tags[widget.index]
                  .tagUserInfo
                  .codePhone = element.userGeneralInfo.codePhone;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowLiveChat.value =
                  element.userGeneralInfo.preferenceUser.allowLiveChat.value;
              profile
                      .userGeneralInfo
                      .tagsList
                      .medicalTag[widget.indexu]
                      .tags[widget.index]
                      .preferenceUser
                      .allowShareEmails
                      .value =
                  element.userGeneralInfo.preferenceUser.allowShareEmails.value;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowSharePhone.value =
                  element.userGeneralInfo.preferenceUser.allowSharePhone.value;
              profile
                      .userGeneralInfo
                      .tagsList
                      .medicalTag[widget.indexu]
                      .tags[widget.index]
                      .preferenceUser
                      .allowSharePicture
                      .value =
                  element
                      .userGeneralInfo.preferenceUser.allowSharePicture.value;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMobile.value =
                  element.userGeneralInfo.preferenceUser.includeMobile.value;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.allowShareName.value =
                  element.userGeneralInfo.preferenceUser.allowShareName.value;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMail1.value =
                  element.userGeneralInfo.preferenceUser.includeMail1.value;
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].preferenceUser.includeMail2.value =
                  element.userGeneralInfo.preferenceUser.includeMail2.value;
              //  profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
              //     .tags[widget.index].preferenceUser.allowShareEmails.value =
              // element.userGeneralInfo.preferenceUser.allowShareEmails.value;
            }
          }
        });
      }
    }
  }

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

    // print(profile.userGeneralInfo.tagsList.objectTag[widget.indexu].firstName);

    // if (index == null) {
    //   // This is the Object Tag ->
    //   profile.userGeneralInfo.userTags.objectTag.last;
    // } else {
    //   // This is the Object Tag ->
    //   profile.userGeneralInfo.userTags.objectTag[index];
    // }

    // // This is how to test if it's an add or an edit
    // index == null
    //     ? profile.userGeneralInfo.userTags.objectTag.last
    //     : profile.userGeneralInfo.userTags.objectTag[index];

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
        extendBody: true,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          controller: _scrollController,

          // physics: NeverScrollableScrollPhysics(),

          headerSliverBuilder: (context, value) {
            return [
              SliverPersistentHeader(
                key: GlobalKey(),
                pinned: true,
                floating: true,
                delegate: CustomSliverDelegate(
                    loading: widget.loading,
                    hideTitleWhenExpanded: true,
                    expandedHeight: 165,
                    profile: profile,
                    indexu: widget.indexu,
                    index: widget.index,
                    type: widget.type,
                    idMembers: idMembers),
              ),
            ];
          },
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(26, 0, 26, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 12,
                          ),

                          SizedBox(
                            height: 16,
                          ),
                          _DescriptionObject(profile, index, indexu),

                          SizedBox(
                            height: 16,
                          ),
                          _ObjectInfo(profile, index),
                          //_alsoContact(),
                          // _petLost(),

                          SizedBox(height: 16),
                          _AdvancedSettings(profile, index),
                          // _ViewExport(),
                          //_petRecord(),
                          SizedBox(height: 17),
                          _PosterFound(profile, index),
                          SizedBox(height: 39),
                          _duplicateTag(profile, indexu, index, widget.type),
                          SizedBox(height: 17),
                          // _Activatenew(),
                          // SizedBox(height: 17),
                          _switchqrbutton(profile, indexu, index, widget.type),
                          SizedBox(height: 17),
                          _deleteButton(profile, indexu, index, widget.type),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 12.0, left: 12, right: 12),
                child: _editTag(profile, index),
              ),
            ],
          ),
        ),
      );
    });
  }

  _DescriptionObject(Profile profile, int index, int indexu) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              border: DescriptionObject ||
                      _descriptionStatus(profile, index, indexu, widget.type)
                  ? Border.all(style: BorderStyle.none)
                  : Border.all(
                      color: ColorConstant.borderBlockVide,
                      style: BorderStyle.solid),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,

                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: DescriptionObject ||
                      _descriptionStatus(profile, index, indexu, widget.type)
                  ? ColorConstant.pinkColor
                  : ColorConstant.colorBlockVide,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _scrollController.jumpTo(0);
                  DescriptionObject = !DescriptionObject;
                  ObjectInfo = false;
                  AdvancedSettings = false;
                  PosterFound = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: SvgPicture.asset(
                        'Assets/Images/iconTag.svg',
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                                value:
                                    'listingtags_filter_label_description'.tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: ColorConstant.whiteTextColor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    DescriptionObject
                        ? Image.asset(
                            "Assets/Images/arrowup_white.png",
                            height: 8,
                            width: 13.18,
                          )
                        : Container(),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        DescriptionObject
            ? Container(
                padding: EdgeInsets.only(left: 0, top: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 12),
                        _Description(profile, index, indexu),
                        SizedBox(height: 12),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _includePhone(Profile profile, int index) {
    return Column(
      children: <Widget>[
        Container(
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 11, right: 21),
                          child: MyText(
                              value: "pets_label_sharephone".tr().tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: _switchIncludePhone
                                  ? ColorConstant.textColor
                                  : ColorConstant.darkGray),
                        ),
                        // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                      ),
                      Image.asset(
                        "Assets/Images/info.png",
                        height: 14,
                        width: 14,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),
                widget.type == 'object'
                    ? CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile
                                    .userGeneralInfo
                                    .tagsList
                                    .objectTag[widget.indexu]
                                    .tags[widget.index]
                                    .preferenceUser
                                    .allowSharePhone
                                    .value ==
                                '1'
                            ? true
                            : false,
                        onChanged: (value) {
                          setState(() {
                            profile.userGeneralInfo.update = true;

                            if (value == true) {
                              profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowSharePhone
                                  .value = '1';
                            } else {
                              profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowSharePhone
                                  .value = '0';
                            }
                          });
                        },
                      )
                    : widget.type == 'medical'
                        ? CustomSwitch(
                            activeColor: Color(0xff34C759),
                            value: profile
                                        .userGeneralInfo
                                        .tagsList
                                        .medicalTag[widget.indexu]
                                        .tags[widget.index]
                                        .preferenceUser
                                        .allowSharePhone
                                        .value ==
                                    '1'
                                ? true
                                : false,
                            onChanged: (value) {
                              setState(() {
                                profile.userGeneralInfo.update = true;

                                if (value == true) {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .medicalTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowSharePhone
                                      .value = '1';
                                } else {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .medicalTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowSharePhone
                                      .value = '0';
                                }
                              });
                            },
                          )
                        : CustomSwitch(
                            activeColor: Color(0xff34C759),
                            value: profile
                                        .userGeneralInfo
                                        .tagsList
                                        .petTag[widget.indexu]
                                        .tags[widget.index]
                                        .preferenceUser
                                        .allowSharePhone
                                        .value ==
                                    '1'
                                ? true
                                : false,
                            onChanged: (value) {
                              setState(() {
                                profile.userGeneralInfo.update = true;

                                if (value == true) {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .petTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowSharePhone
                                      .value = '1';
                                } else {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .petTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowSharePhone
                                      .value = '0';
                                }
                              });
                            },
                          ),
                SizedBox(
                  width: 14,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _includePicture(Profile profile, int index) {
    return Column(
      children: <Widget>[
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: _switchIncludepic
                  ? ColorConstant.boxColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: Container(
            height: 49,
            decoration: BoxDecoration(
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 11, right: 21),
                          child: MyText(
                              value: "pets_label_includepicture".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant.textColor),
                          // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                        ),
                      ),
                      Image.asset(
                        "Assets/Images/info.png",
                        height: 14,
                        width: 14,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),
                widget.type == 'object'
                    ? CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile
                                    .userGeneralInfo
                                    .tagsList
                                    .objectTag[widget.indexu]
                                    .tags[widget.index]
                                    .preferenceUser
                                    .allowSharePicture
                                    .value ==
                                '1'
                            ? true
                            : false,
                        onChanged: (value) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            if (value == true) {
                              profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowSharePicture
                                  .value = '1';
                            } else {
                              profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowSharePicture
                                  .value = '0';
                            }
                          });
                        },
                      )
                    : widget.type == 'medical'
                        ? CustomSwitch(
                            activeColor: Color(0xff34C759),
                            value: profile
                                        .userGeneralInfo
                                        .tagsList
                                        .medicalTag[widget.indexu]
                                        .tags[widget.index]
                                        .preferenceUser
                                        .allowSharePicture
                                        .value ==
                                    '1'
                                ? true
                                : false,
                            onChanged: (value) {
                              profile.userGeneralInfo.update = true;

                              setState(() {
                                if (value == true) {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .medicalTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowSharePicture
                                      .value = '1';
                                } else {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .medicalTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowSharePicture
                                      .value = '0';
                                }
                              });
                            },
                          )
                        : CustomSwitch(
                            activeColor: Color(0xff34C759),
                            value: profile
                                        .userGeneralInfo
                                        .tagsList
                                        .petTag[widget.indexu]
                                        .tags[widget.index]
                                        .preferenceUser
                                        .allowSharePicture
                                        .value ==
                                    '1'
                                ? true
                                : false,
                            onChanged: (value) {
                              profile.userGeneralInfo.update = true;

                              setState(() {
                                if (value == true) {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .petTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowSharePicture
                                      .value = '1';
                                } else {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .petTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowSharePicture
                                      .value = '0';
                                }
                              });
                            },
                          ),
                SizedBox(
                  width: 14,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _includeName(Profile profile, int index) {
    return Column(
      children: <Widget>[
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: _switchIncludename
                  ? ColorConstant.boxColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 11, right: 21),
                          child: MyText(
                              value: "pets_label_includename".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant.textColor),
                        ),
                        // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                      ),
                      Image.asset(
                        "Assets/Images/info.png",
                        height: 14,
                        width: 14,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),
                widget.type == 'object'
                    ? CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile
                                    .userGeneralInfo
                                    .tagsList
                                    .objectTag[widget.indexu]
                                    .tags[widget.index]
                                    .preferenceUser
                                    .allowShareName
                                    .value ==
                                '1'
                            ? true
                            : false,
                        onChanged: (value) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            if (value == true) {
                              profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowShareName
                                  .value = '1';
                            } else {
                              profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowShareName
                                  .value = '0';
                            }
                          });
                        },
                      )
                    : widget.type == 'medical'
                        ? CustomSwitch(
                            activeColor: Color(0xff34C759),
                            value: profile
                                        .userGeneralInfo
                                        .tagsList
                                        .medicalTag[widget.indexu]
                                        .tags[widget.index]
                                        .preferenceUser
                                        .allowShareName
                                        .value ==
                                    '1'
                                ? true
                                : false,
                            onChanged: (value) {
                              profile.userGeneralInfo.update = true;

                              setState(() {
                                if (value == true) {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .medicalTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowShareName
                                      .value = '1';
                                } else {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .medicalTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowShareName
                                      .value = '0';
                                }
                              });
                            },
                          )
                        : CustomSwitch(
                            activeColor: Color(0xff34C759),
                            value: profile
                                        .userGeneralInfo
                                        .tagsList
                                        .petTag[widget.indexu]
                                        .tags[widget.index]
                                        .preferenceUser
                                        .allowShareName
                                        .value ==
                                    '1'
                                ? true
                                : false,
                            onChanged: (value) {
                              profile.userGeneralInfo.update = true;

                              setState(() {
                                if (value == true) {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .petTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowShareName
                                      .value = '1';
                                } else {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .petTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowShareName
                                      .value = '0';
                                }
                              });
                            },
                          ),
                SizedBox(
                  width: 14,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _includeEmail(Profile profile, int index) {
    return Column(
      children: <Widget>[
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: _switchIncludemail
                  ? ColorConstant.boxColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 11, right: 21),
                          child: MyText(
                              value: "pets_label_shareemail".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant.textColor),
                        ),
                        // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                      ),
                      Image.asset(
                        "Assets/Images/info.png",
                        height: 14,
                        width: 14,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),
                widget.type == 'object'
                    ? CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile
                                    .userGeneralInfo
                                    .tagsList
                                    .objectTag[widget.indexu]
                                    .tags[widget.index]
                                    .preferenceUser
                                    .allowShareEmails
                                    .value ==
                                "1"
                            ? true
                            : false,
                        onChanged: (value) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            if (value == true) {
                              profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowShareEmails
                                  .value = "1";
                            } else {
                              profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowShareEmails
                                  .value = "0";
                            }
                          });
                        },
                      )
                    : widget.type == 'medical'
                        ? CustomSwitch(
                            activeColor: Color(0xff34C759),
                            value: profile
                                        .userGeneralInfo
                                        .tagsList
                                        .medicalTag[widget.indexu]
                                        .tags[widget.index]
                                        .preferenceUser
                                        .allowShareEmails
                                        .value ==
                                    "1"
                                ? true
                                : false,
                            onChanged: (value) {
                              profile.userGeneralInfo.update = true;

                              setState(() {
                                if (value == true) {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .medicalTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowShareEmails
                                      .value = "1";
                                } else {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .medicalTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowShareEmails
                                      .value = "0";
                                }
                              });
                            },
                          )
                        : CustomSwitch(
                            activeColor: Color(0xff34C759),
                            value: profile
                                        .userGeneralInfo
                                        .tagsList
                                        .petTag[widget.indexu]
                                        .tags[widget.index]
                                        .preferenceUser
                                        .allowShareEmails
                                        .value ==
                                    "1"
                                ? true
                                : false,
                            onChanged: (value) {
                              profile.userGeneralInfo.update = true;

                              setState(() {
                                if (value == true) {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .petTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowShareEmails
                                      .value = "1";
                                } else {
                                  profile
                                      .userGeneralInfo
                                      .tagsList
                                      .petTag[widget.indexu]
                                      .tags[widget.index]
                                      .preferenceUser
                                      .allowShareEmails
                                      .value = "0";
                                }
                              });
                            },
                          ),
                SizedBox(
                  width: 14,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  alsoContacts() {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: ColorConstant.pinkColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(alsoContact ? 0 : 5.0),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: InkWell(
              child: Container(
            height: 49,
            decoration: BoxDecoration(
                border: Border.all(width: 0, color: ColorConstant.boxColor),
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(alsoContact ? 0 : 5.0))),
            child: Padding(
              padding: EdgeInsets.only(top: 17, bottom: 17),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 11, right: 21),
                    child: MyText(
                        value: 'editprofil_general_subtitle_contact'.tr() + ':',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: ColorConstant.textColor),

                    // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          "Assets/Images/info.png",
                          height: 14,
                          width: 14,
                        )),
                  ),
                  //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),

                  SizedBox(
                    width: 22.2,
                  )
                ],
              ),
            ),
          )),
        ),
        alsoContact
            ? Container(
                padding: EdgeInsets.only(left: 10, top: 0),
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1.0, 3.0),
                        //  spreadRadius: 7.0,
                        blurRadius: 3.0,
                      ),
                    ],
                    color: ColorConstant.pinkColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: <Widget>[
                            Visibility(
                              visible: _visi,
                              child: Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ButtonTheme(
                                      height: 36.0,
                                      minWidth: 133.5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: RaisedButton(
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.white,
                                        color: Colors.white,
                                        textColor: Color(0xffEC1C40),
                                        child: MyText(
                                          value: 'editprofil_general_btn_addnew'
                                              .tr(),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        onPressed: nombrebolckAlsoContact < 5
                                            ? () {
                                                setState(() {
                                                  nombrebolckAlsoContact++;
                                                });
                                                print(nombrebolckAlsoContact);
                                              }
                                            : null,
                                      )),
                                  /* child: MyButton(
                                                        title: 'addnew',
                                                        height: 36.0,
                                                        titleSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        titleColor: Color(0xffEC1C40),
                                                        miniWidth: 133.5,
                                                        btnBgColor: Colors.white,
                                                        onPressed: () => {},
                                                      ),*/
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Visibility(
                                visible: _visi,
                                child: Expanded(
                                    flex: 5,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: MyButton(
                                        title: 'editprofil_general_btn_delete'
                                            .tr(),
                                        height: 36.0,
                                        titleSize: 14,
                                        fontWeight: FontWeight.w500,
                                        titleColor: Color(0xffEC1C40),
                                        miniWidth: 133.5,
                                        btnBgColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            _visi = false;
                                            _visibile = _visi;
                                          });
                                        },
                                      ),
                                    ))),
                            Visibility(
                              visible: !_visi,
                              child: Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ButtonTheme(
                                      height: 36.0,
                                      minWidth: 280.5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: RaisedButton(
                                          disabledColor: Colors.grey,
                                          disabledTextColor: Colors.white,
                                          color: Colors.white,
                                          textColor: Color(0xffEC1C40),
                                          child: MyText(
                                            value: 'editprofil_general_btn_done'
                                                .tr(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _visi = !_visi;
                                              _visibile = !_visibile;
                                            });
                                          })),
                                  /* child: MyButton(
                                                        title: 'addnew',
                                                        height: 36.0,
                                                        titleSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        titleColor: Color(0xffEC1C40),
                                                        miniWidth: 133.5,
                                                        btnBgColor: Colors.white,
                                                        onPressed: () => {},
                                                      ),*/
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _Description(Profile profile, int index, int indexu) {
    String member;
    /*    index == null
        ? member = ''
        : member = widget.profile.userGeneralInfo.userTags
            .objectTag[widget.index].tagInfo.idMember
            .toString(); */

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 0),
          decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: ColorConstant.pinkColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0, color: ColorConstant.boxColor),
                color: ColorConstant.boxColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.only(left: 10.5, right: 20.5, bottom: 23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 14.5,
                  ),
                  MyText(
                      value: "listingtags_filter_label_description".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: ColorConstant.textColor),
                  SizedBox(
                    height: 14.5,
                  ),
                  MyTextField(
                    initialValue: widget.type == 'object'
                        ? profile
                                .userGeneralInfo
                                .tagsList
                                .objectTag[widget.indexu]
                                .tags[widget.index]
                                .tagInfo
                                .tagLabel ??
                            " "
                        : widget.type == 'medical'
                            ? profile
                                    .userGeneralInfo
                                    .tagsList
                                    .medicalTag[widget.indexu]
                                    .tags[widget.index]
                                    .tagInfo
                                    .tagLabel ??
                                " "
                            : profile
                                .userGeneralInfo
                                .tagsList
                                .petTag[widget.indexu]
                                .tags[widget.index]
                                .tagInfo
                                .tagLabel,
                    maxline: 1,
                    inputType: TextInputType.number,
                    //                                  textAlign: TextAlign.start,
                    editTextBgColor: ColorConstant.textfieldColor,
                    hintTextColor: Colors.white54,
                    title: '',
                    onChanged: (value) {
                      profile.userGeneralInfo.update = true;

                      setState(() {
                        if (widget.type == 'object') {
                          profile
                              .userGeneralInfo
                              .tagsList
                              .objectTag[widget.indexu]
                              .tags[widget.index]
                              .tagInfo
                              .tagLabel = value;
                        } else if (widget.type == 'medical') {
                          profile
                              .userGeneralInfo
                              .tagsList
                              .medicalTag[widget.indexu]
                              .tags[widget.index]
                              .tagInfo
                              .tagLabel = value;
                        } else {
                          profile
                              .userGeneralInfo
                              .tagsList
                              .objectTag[widget.indexu]
                              .tags[widget.index]
                              .tagInfo
                              .tagLabel = value;
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 14.5,
                  ),
                  MyText(
                      value: "reminders_label_owneris".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: ColorConstant.textColor),
                  SizedBox(
                    height: 14.5,
                  ),
                  Container(
                    height: 24,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: idMembers
                            .map(
                              (e) => DropdownMenuItem(
                                child: MyText(
                                    value: e['firstName'] != null
                                        ? e['firstName']
                                        : " ",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.textColor),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (newVal) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            if (widget.type == 'object') {
                              profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[indexu]
                                  .tags[widget.index]
                                  .tagInfo
                                  .idMember = newVal['idMember'];
                            } else if (widget.type == 'medical') {
                              profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[indexu]
                                  .tags[widget.index]
                                  .tagInfo
                                  .idMember = newVal['idMember'];
                            } else {
                              profile
                                  .userGeneralInfo
                                  .tagsList
                                  .petTag[indexu]
                                  .tags[widget.index]
                                  .tagInfo
                                  .idMember = newVal['idMember'];
                            }
                          });
                          emergencyContactOwner(newVal['idMember'], profile);

                          alsoContactOwner(newVal['idMember'], profile);
                        },
                        isExpanded: true,
                        hint: MyText(
                            value: widget.type == 'object'
                                ? idMembers.firstWhere((element) =>
                                    element['idMember'] ==
                                    profile
                                        .userGeneralInfo
                                        .tagsList
                                        .objectTag[indexu]
                                        .tags[widget.index]
                                        .tagInfo
                                        .idMember)['firstName']
                                : widget.type == 'medical'
                                    ? idMembers.firstWhere((element) =>
                                        element['idMember'] ==
                                        profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[indexu]
                                            .tags[widget.index]
                                            .tagInfo
                                            .idMember)['firstName']
                                    : idMembers.firstWhere((element) =>
                                        element['idMember'] ==
                                        profile
                                            .userGeneralInfo
                                            .tagsList
                                            .petTag[indexu]
                                            .tags[widget.index]
                                            .tagInfo
                                            .idMember)['firstName'],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.textColor),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: ColorConstant.textfieldColor,
                      borderRadius: BorderRadius.circular(8),
                      // border: Border.all(style: BorderStyle.solid, width: 0.70),
                    ),
                  ),
                  SizedBox(
                    height: 14.5,
                  ),
                  MyText(
                      value: "objecttag_btn_category".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: ColorConstant.textColor),
                  SizedBox(
                    height: 14.5,
                  ),
                  Container(
                    height: 24,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          items: profile.parameters.tagTypesList
                              .map(
                                (e) => DropdownMenuItem(
                                  child: MyText(
                                      value: e['type_label'],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.textColor),
                                  value: e,
                                ),
                              )
                              .toList(),
                          onChanged: (newVal) {
                            profile.userGeneralInfo.update = true;
                            setState(() {
                              if (widget.type == 'object') {
                                profile
                                    .userGeneralInfo
                                    .tagsList
                                    .objectTag[indexu]
                                    .tags[widget.index]
                                    .tagInfo
                                    .idType = newVal['id'];
                              } else if (widget.type == 'medical') {
                                profile
                                    .userGeneralInfo
                                    .tagsList
                                    .medicalTag[indexu]
                                    .tags[widget.index]
                                    .tagInfo
                                    .idType = newVal['id'];
                              } else {
                                profile
                                    .userGeneralInfo
                                    .tagsList
                                    .petTag[indexu]
                                    .tags[widget.index]
                                    .tagInfo
                                    .idType = newVal['id'];
                              }
                            });
                          },
                          isExpanded: true,
                          value: ObjectData,
                          hint: MyText(
                              value: widget.type == 'object'
                                  ? profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[widget.indexu]
                                              .tags[widget.index]
                                              .tagInfo
                                              .idType !=
                                          null
                                      ? profile.parameters.tagTypesList[profile.userGeneralInfo.tagsList.objectTag[indexu].tags[widget.index].tagInfo.idType - 2]
                                          ['type_label']
                                      : ''
                                  : widget.type == 'medical'
                                      ? profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .medicalTag[widget.indexu]
                                                  .tags[widget.index]
                                                  .tagInfo
                                                  .idType !=
                                              null
                                          ? profile.parameters.tagTypesList[
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[indexu]
                                                      .tags[widget.index]
                                                      .tagInfo
                                                      .idType -
                                                  2]['type_label']
                                          : ''
                                      : profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .petTag[widget.indexu]
                                                  .tags[widget.index]
                                                  .tagInfo
                                                  .idType !=
                                              null
                                          ? profile.parameters.tagTypesList[profile.userGeneralInfo.tagsList.petTag[indexu].tags[widget.index].tagInfo.idType - 2]['type_label']
                                          : '',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ColorConstant.textColor)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: ColorConstant.textfieldColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _other(Profile profile, int index) {
    return Column(
      children: <Widget>[
        Container(
          height: 49.5,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: other ||
                      _otherStatus(profile, index, widget.indexu, widget.type)
                  ? ColorConstant.pinkColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(other ? 0 : 5.0),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  other = !other;
                  thankyou = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(other ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 14, right: 13),
                        child: Image.asset(
                          "Assets/Images/threedotB.png",
                          height: 6,
                          width: 24,
                          color: other ||
                                  _otherStatus(profile, index, widget.indexu,
                                      widget.type)
                              ? ColorConstant.pinkColor
                              : ColorConstant.darkGray,
                        ) /**/
                        // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                        ),
                    MyText(
                        value: "editprofil_medical_label_other".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: other ||
                                _otherStatus(
                                    profile, index, widget.indexu, widget.type)
                            ? ColorConstant.textColor
                            : ColorConstant.darkGray),
                    SizedBox(
                      width: 17,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          "Assets/Images/info.png",
                          height: 14,
                          width: 14,
                        ),
                      ),
                    ),
                    other
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
                            color: ColorConstant.pinkColor,
                            height: 8,
                            width: 13.18,
                          )
                        : Container(),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        other
            ? Container(
                padding: EdgeInsets.only(left: 10, top: 0),
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1.0, 3.0),
                        //  spreadRadius: 7.0,
                        blurRadius: 3.0,
                      ),
                    ],
                    color: ColorConstant.pinkColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8))),
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.40,
                          color: ColorConstant.dividerColor,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: profile
                              .userGeneralInfo
                              .tagsList
                              .objectTag[widget.indexu]
                              .tags[widget.index]
                              .otherInfo
                              .length,
                          padding: EdgeInsets.zero,
                          separatorBuilder:
                              (BuildContext context, int indexi) => Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.30)),
                          itemBuilder: (BuildContext context, int index1) {
                            return Stack(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5.0, top: 10),
                                    child: Visibility(
                                      visible: !_visiOther,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.red,
                                          child: InkWell(
                                              splashColor: Colors.red,
                                              child: SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: Center(
                                                      child: FaIcon(
                                                    FontAwesomeIcons.minus,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ))),
                                              onTap: () {
                                                setState(() {
                                                  profile.userGeneralInfo
                                                      .update = true;
                                                  profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .otherInfo
                                                      .removeAt(index);

                                                  nombrebolckOther = profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .otherInfo
                                                      .length;
                                                  if (profile
                                                          .userGeneralInfo
                                                          .tagsList
                                                          .objectTag[
                                                              widget.indexu]
                                                          .tags[widget.index]
                                                          .otherInfo
                                                          .length ==
                                                      0) {
                                                    _visiOther = true;
                                                  }
                                                });
                                              }),
                                        ),
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: new ExpandableOtherTag(
                                        key: Key(profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1]
                                            .label),
                                        profile: profile,
                                        type: widget.type,
                                        indexu: widget.indexu,
                                        indexTag: widget.index,
                                        updated: profile.userGeneralInfo.update,
                                        index: index1,
                                        addBlockOtherTag: addBlockOtherTag,
                                        other: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1],
                                        title: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1]
                                            .label,
                                        desc: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1]
                                            .description,
                                        attachments: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1]
                                            .documents,
                                        reminders: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1]
                                            .reminders,
                                        switchValue: profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .objectTag[widget.indexu]
                                                    .tags[widget.index]
                                                    .otherInfo[index1]
                                                    .active ==
                                                1
                                            ? true
                                            : false,
                                        visibilite: _visiOther,
                                        indexx: index1,
                                        location: 'otherMedicalRecordInfo')),
                              ],
                            );
                          },
                        ),
                        Container(
                          height: 0.40,
                          color: ColorConstant.dividerColor.withOpacity(.30),
                        ),
                        SizedBox(
                          height: 21.5,
                        ),
                        profile
                                    .userGeneralInfo
                                    .tagsList
                                    .objectTag[widget.indexu]
                                    .tags[widget.index]
                                    .otherInfo
                                    .length ==
                                0
                            ? MyButton(
                                title: "editprofil_medical_btn_newother".tr(),
                                height: 36.0,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.pinkColor,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckOther < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckOther++;
                                          profile.userGeneralInfo.update = true;

                                          addBlockOtherTag.add(true);
                                          OtherInfo otherTAgInfo = OtherInfo(
                                              active: 1,
                                              description: "",
                                              label: '',
                                              documents: [],
                                              reminders: []);

                                          profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[widget.indexu]
                                              .tags[widget.index]
                                              .otherInfo
                                              .add(otherTAgInfo);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                      visible: _visiOther,
                                      child: Expanded(
                                        flex: 5,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: MyButton(
                                            title: "+ " +
                                                "objecttag_btn_addnew".tr(),
                                            height: 36.0,
                                            titleSize: 14,
                                            fontWeight: FontWeight.w500,
                                            titleColor: ColorConstant.pinkColor,
                                            miniWidth: 133.5,
                                            btnBgColor: Colors.white,
                                            onPressed: nombrebolckOther <
                                                    nbblock
                                                ? () {
                                                    setState(() {
                                                      profile.userGeneralInfo
                                                          .update = true;

                                                      nombrebolckOther++;
                                                      for (int i = 0;
                                                          i <
                                                              addBlockOtherTag
                                                                  .length;
                                                          i++) {
                                                        if (addBlockOtherTag[
                                                                i] ==
                                                            true) {
                                                          addBlockOtherTag[i] =
                                                              false;
                                                        }
                                                      }

                                                      addBlockOtherTag
                                                          .add(true);
                                                      OtherInfo otherTAgInfo =
                                                          OtherInfo(
                                                              active: 1,
                                                              description: "",
                                                              label: '',
                                                              documents: [],
                                                              reminders: []);

                                                      index == null
                                                          ? profile
                                                              .userGeneralInfo
                                                              .userTags
                                                              .objectTag[
                                                                  widget.index]
                                                              .otherInfo
                                                              .add(otherTAgInfo)
                                                          : profile
                                                              .userGeneralInfo
                                                              .userTags
                                                              .objectTag[index]
                                                              .otherInfo
                                                              .add(
                                                                  otherTAgInfo);
                                                    });
                                                  }
                                                : null,
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                    visible: _visiOther,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTheme(
                                            height: 36.0,
                                            minWidth: 133.5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: RaisedButton(
                                              disabledColor: Colors.grey,
                                              disabledTextColor: Colors.white,
                                              color: Colors.white,
                                              textColor:
                                                  ColorConstant.pinkColor,
                                              child: MyText(
                                                value:
                                                    'objecttag_btn_delete'.tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _visiOther = false;
                                                  _visibile = _visiOther;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !_visiOther,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTheme(
                                            height: 36.0,
                                            minWidth: 280.5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: RaisedButton(
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.white,
                                                color: Colors.white,
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiOther = !_visiOther;
                                                  });
                                                })),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _otherMedical(Profile profile, int index) {
    return Column(
      children: <Widget>[
        Container(
          height: 49.5,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: other ||
                      _otherStatus(profile, index, widget.indexu, widget.type)
                  ? ColorConstant.pinkColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(other ? 0 : 5.0),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  other = !other;
                  thankyou = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(other ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 14, right: 13),
                        child: Image.asset(
                          "Assets/Images/threedotB.png",
                          height: 6,
                          width: 24,
                          color: other ||
                                  _otherStatus(profile, index, widget.indexu,
                                      widget.type)
                              ? ColorConstant.pinkColor
                              : ColorConstant.darkGray,
                        ) /**/
                        // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                        ),
                    MyText(
                        value: "editprofil_medical_label_other".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: other ||
                                _otherStatus(
                                    profile, index, widget.indexu, widget.type)
                            ? ColorConstant.textColor
                            : ColorConstant.darkGray),
                    SizedBox(
                      width: 17,
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            "Assets/Images/info.png",
                            height: 14,
                            width: 14,
                          )),
                    ),
                    other
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
                            color: ColorConstant.pinkColor,
                            height: 8,
                            width: 13.18,
                          )
                        : Container(),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        other
            ? Container(
                padding: EdgeInsets.only(left: 10, top: 0),
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1.0, 3.0),
                        //  spreadRadius: 7.0,
                        blurRadius: 3.0,
                      ),
                    ],
                    color: ColorConstant.pinkColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8))),
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.40,
                          color: ColorConstant.dividerColor,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: profile
                              .userGeneralInfo
                              .tagsList
                              .medicalTag[widget.indexu]
                              .tags[widget.index]
                              .otherInfo
                              .length,
                          padding: EdgeInsets.zero,
                          separatorBuilder:
                              (BuildContext context, int indexi) => Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.30)),
                          itemBuilder: (BuildContext context, int index1) {
                            return Stack(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5.0, top: 10),
                                    child: Visibility(
                                      visible: !_visiOther,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.red,
                                          child: InkWell(
                                              splashColor: Colors.red,
                                              child: SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: Center(
                                                      child: FaIcon(
                                                    FontAwesomeIcons.minus,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ))),
                                              onTap: () {
                                                setState(() {
                                                  profile.userGeneralInfo
                                                      .update = true;
                                                  profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .otherInfo
                                                      .removeAt(index);

                                                  nombrebolckOther = profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .otherInfo
                                                      .length;
                                                  if (profile
                                                          .userGeneralInfo
                                                          .tagsList
                                                          .medicalTag[
                                                              widget.indexu]
                                                          .tags[widget.index]
                                                          .otherInfo
                                                          .length ==
                                                      0) {
                                                    _visiOther = true;
                                                  }
                                                });
                                              }),
                                        ),
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: new ExpandableOtherTag(
                                        key: Key(profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1]
                                            .label),
                                        profile: profile,
                                        type: widget.type,
                                        indexu: widget.indexu,
                                        indexTag: widget.index,
                                        updated: profile.userGeneralInfo.update,
                                        index: index1,
                                        addBlockOtherTag: addBlockOtherTag,
                                        other: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1],
                                        title: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1]
                                            .label,
                                        desc: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1]
                                            .description,
                                        attachments: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1]
                                            .documents,
                                        reminders: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .otherInfo[index1]
                                            .reminders,
                                        switchValue: profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .medicalTag[widget.indexu]
                                                    .tags[widget.index]
                                                    .otherInfo[index1]
                                                    .active ==
                                                1
                                            ? true
                                            : false,
                                        visibilite: _visiOther,
                                        indexx: index1,
                                        location: 'MedicalRecordInfo')),
                              ],
                            );
                          },
                        ),
                        Container(
                          height: 0.40,
                          color: ColorConstant.dividerColor.withOpacity(.30),
                        ),
                        SizedBox(
                          height: 21.5,
                        ),
                        profile
                                    .userGeneralInfo
                                    .tagsList
                                    .medicalTag[widget.indexu]
                                    .tags[widget.index]
                                    .otherInfo
                                    .length ==
                                0
                            ? MyButton(
                                title: "editprofil_medical_btn_newother".tr(),
                                height: 36.0,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.pinkColor,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckOther < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckOther++;
                                          profile.userGeneralInfo.update = true;

                                          addBlockOtherTag.add(true);
                                          OtherInfo otherTAgInfo = OtherInfo(
                                              active: 1,
                                              description: "",
                                              label: '',
                                              documents: [],
                                              reminders: []);

                                          profile
                                              .userGeneralInfo
                                              .tagsList
                                              .medicalTag[widget.indexu]
                                              .tags[widget.index]
                                              .otherInfo
                                              .add(otherTAgInfo);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                      visible: _visiOther,
                                      child: Expanded(
                                        flex: 5,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: MyButton(
                                            title: "+ " +
                                                "objecttag_btn_addnew".tr(),
                                            height: 36.0,
                                            titleSize: 14,
                                            fontWeight: FontWeight.w500,
                                            titleColor: ColorConstant.pinkColor,
                                            miniWidth: 133.5,
                                            btnBgColor: Colors.white,
                                            onPressed: nombrebolckOther <
                                                    nbblock
                                                ? () {
                                                    setState(() {
                                                      profile.userGeneralInfo
                                                          .update = true;

                                                      nombrebolckOther++;
                                                      for (int i = 0;
                                                          i <
                                                              addBlockOtherTag
                                                                  .length;
                                                          i++) {
                                                        if (addBlockOtherTag[
                                                                i] ==
                                                            true) {
                                                          addBlockOtherTag[i] =
                                                              false;
                                                        }
                                                      }

                                                      addBlockOtherTag
                                                          .add(true);
                                                      OtherInfo otherTAgInfo =
                                                          OtherInfo(
                                                              active: 1,
                                                              description: "",
                                                              label: '',
                                                              documents: [],
                                                              reminders: []);

                                                      index == null
                                                          ? profile
                                                              .userGeneralInfo
                                                              .userTags
                                                              .medicalTag[
                                                                  widget.index]
                                                              .otherInfo
                                                              .add(otherTAgInfo)
                                                          : profile
                                                              .userGeneralInfo
                                                              .userTags
                                                              .medicalTag[index]
                                                              .otherInfo
                                                              .add(
                                                                  otherTAgInfo);
                                                    });
                                                  }
                                                : null,
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                    visible: _visiOther,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTheme(
                                            height: 36.0,
                                            minWidth: 133.5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: RaisedButton(
                                              disabledColor: Colors.grey,
                                              disabledTextColor: Colors.white,
                                              color: Colors.white,
                                              textColor:
                                                  ColorConstant.pinkColor,
                                              child: MyText(
                                                value:
                                                    'objecttag_btn_delete'.tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _visiOther = false;
                                                  _visibile = _visiOther;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !_visiOther,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTheme(
                                            height: 36.0,
                                            minWidth: 280.5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: RaisedButton(
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.white,
                                                color: Colors.white,
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiOther = !_visiOther;
                                                  });
                                                })),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _ObjectInfo(Profile profile, int index) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,

                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: ColorConstant.pinkColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: InkWell(
              onTap: () {
                setState(() {
                  ObjectInfo = !ObjectInfo;

                  _scrollController.jumpTo(65);

                  DescriptionObject = false;
                  AdvancedSettings = false;
                  PosterFound = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: SvgPicture.asset(
                        'Assets/Images/contactInfo.svg',
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                                value: 'pets_label_contactinfo'.tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: ColorConstant.whiteTextColor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    ObjectInfo
                        ? Image.asset(
                            "Assets/Images/arrowup_white.png",
                            height: 8,
                            width: 13.18,
                          )
                        : Container(),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        ObjectInfo
            ? Container(
                padding: EdgeInsets.only(left: 0, top: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 12),
                        _alsoContact(profile, index),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _alsoContact(Profile profile, int index) {
    return Column(
      children: <Widget>[
        alsoContact
            ? Column(children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 0),
                  decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black26,
                          offset: Offset(1.0, 3.0),
                          //  spreadRadius: 7.0,
                          blurRadius: 3.0,
                        ),
                      ],
                      color: ColorConstant.pinkColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0, color: ColorConstant.boxColor),
                        color: ColorConstant.boxColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        )),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 11, right: 20.5, bottom: 23),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 14.5,
                          ),
                          Center(
                            child: Row(children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: widget.type == "object"
                                    ? MyText(
                                        value: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo
                                            .firstName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorConstant.textColor)
                                    : widget.type == "medical"
                                        ? MyText(
                                            value: profile
                                                .userGeneralInfo
                                                .tagsList
                                                .medicalTag[widget.indexu]
                                                .tags[widget.index]
                                                .tagUserInfo
                                                .firstName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor)
                                        : MyText(
                                            value: " ",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                flex: 2,
                                child: widget.type == "object"
                                    ? MyText(
                                        value: profile
                                                .userGeneralInfo
                                                .tagsList
                                                .objectTag[widget.indexu]
                                                .tags[widget.index]
                                                .tagUserInfo
                                                .lastName ??
                                            ' ',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorConstant.textColor)
                                    : widget.type == "medical"
                                        ? MyText(
                                            value: profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .medicalTag[widget.indexu]
                                                    .tags[widget.index]
                                                    .tagUserInfo
                                                    .lastName ??
                                                '',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor)
                                        : MyText(
                                            value: " ",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor),
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          MyText(
                              value: "objecttag_label_authorize".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant.textColor),
                          SizedBox(
                            height: 11,
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          MyText(
                              value: "pets_label_emailme".tr(),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: ColorConstant.textColor),
                          Column(
                            children: [
                              SizedBox(
                                height: 8.0 ?? 12.5,
                              ),
                              widget.type == 'object'
                                  ? Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 8,
                                          child: MyText(
                                              value: profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .tagUserInfo
                                                      .mail ??
                                                  ' ',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: ColorConstant.textColor),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: CustomSwitch(
                                              activeColor: Color(0xff34C759),
                                              value: profile
                                                          .userGeneralInfo
                                                          .tagsList
                                                          .objectTag[
                                                              widget.indexu]
                                                          .tags[widget.index]
                                                          .preferenceUser
                                                          .includeMail1
                                                          .value ==
                                                      "1"
                                                  ? true
                                                  : false,
                                              onChanged: (value) {
                                                profile.userGeneralInfo.update =
                                                    true;
                                                setState(() {
                                                  if (value == true) {
                                                    profile
                                                        .userGeneralInfo
                                                        .tagsList
                                                        .objectTag[
                                                            widget.indexu]
                                                        .tags[widget.index]
                                                        .preferenceUser
                                                        .includeMail1
                                                        .value = "1";
                                                  } else {
                                                    profile
                                                        .userGeneralInfo
                                                        .tagsList
                                                        .objectTag[
                                                            widget.indexu]
                                                        .tags[widget.index]
                                                        .preferenceUser
                                                        .includeMail1
                                                        .value = "0";
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : widget.type == 'medical'
                                      ? Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 8,
                                                child: MyText(
                                                    value: profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .medicalTag[
                                                                widget.indexu]
                                                            .tags[widget.index]
                                                            .tagUserInfo
                                                            .mail ??
                                                        ' ',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: ColorConstant
                                                        .textColor)),
                                            Expanded(
                                              flex: 4,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: CustomSwitch(
                                                  activeColor:
                                                      Color(0xff34C759),
                                                  value: profile
                                                              .userGeneralInfo
                                                              .tagsList
                                                              .medicalTag[
                                                                  widget.indexu]
                                                              .tags[
                                                                  widget.index]
                                                              .preferenceUser
                                                              .includeMail1
                                                              .value ==
                                                          "1"
                                                      ? true
                                                      : false,
                                                  onChanged: (value) {
                                                    profile.userGeneralInfo
                                                        .update = true;

                                                    setState(() {
                                                      if (value == true) {
                                                        profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .medicalTag[
                                                                widget.indexu]
                                                            .tags[widget.index]
                                                            .preferenceUser
                                                            .includeMail1
                                                            .value = "1";
                                                      } else {
                                                        profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .medicalTag[
                                                                widget.indexu]
                                                            .tags[widget.index]
                                                            .preferenceUser
                                                            .includeMail1
                                                            .value = "0";
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 8,
                                                child: MyText(
                                                    value: profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .petTag[
                                                                widget.indexu]
                                                            .tags[widget.index]
                                                            .tagUserInfo
                                                            .mail ??
                                                        ' ',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: ColorConstant
                                                        .textColor)),
                                            Expanded(
                                              flex: 4,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: CustomSwitch(
                                                  activeColor:
                                                      Color(0xff34C759),
                                                  value: profile
                                                              .userGeneralInfo
                                                              .tagsList
                                                              .petTag[
                                                                  widget.indexu]
                                                              .tags[
                                                                  widget.index]
                                                              .preferenceUser
                                                              .includeMail1
                                                              .value ==
                                                          1
                                                      ? true
                                                      : false,
                                                  onChanged: (value) {
                                                    profile.userGeneralInfo
                                                        .update = true;

                                                    setState(() {
                                                      if (value == true) {
                                                        profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .petTag[
                                                                widget.indexu]
                                                            .tags[widget.index]
                                                            .preferenceUser
                                                            .includeMail1
                                                            .value = '1';
                                                      } else {
                                                        profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .petTag[
                                                                widget.indexu]
                                                            .tags[widget.index]
                                                            .preferenceUser
                                                            .includeMail1
                                                            .value = '0';
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              SizedBox(
                                height: 0.0 ?? 12.5,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 8.0 ?? 12.5,
                              ),
                              widget.type == 'object'
                                  ? profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .objectTag[widget.indexu]
                                                  .tags[widget.index]
                                                  .tagUserInfo
                                                  .mail2 !=
                                              null &&
                                          profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .objectTag[widget.indexu]
                                                  .tags[widget.index]
                                                  .tagUserInfo
                                                  .mail2 !=
                                              ''
                                      ? Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 6,
                                                child: MyText(
                                                    value: profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .objectTag[
                                                                widget.indexu]
                                                            .tags[widget.index]
                                                            .tagUserInfo
                                                            .mail2 ??
                                                        ' ',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: ColorConstant
                                                        .textColor)),
                                            Expanded(
                                              flex: 4,
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: CustomSwitch(
                                                    activeColor:
                                                        Color(0xff34C759),
                                                    value: profile
                                                                .userGeneralInfo
                                                                .tagsList
                                                                .objectTag[
                                                                    widget
                                                                        .indexu]
                                                                .tags[widget
                                                                    .index]
                                                                .preferenceUser
                                                                .includeMail1
                                                                .value ==
                                                            1
                                                        ? true
                                                        : false,
                                                    onChanged: (value) {
                                                      profile.userGeneralInfo
                                                          .update = true;

                                                      setState(() {
                                                        if (value == true) {
                                                          profile
                                                              .userGeneralInfo
                                                              .tagsList
                                                              .objectTag[
                                                                  widget.indexu]
                                                              .tags[
                                                                  widget.index]
                                                              .preferenceUser
                                                              .includeMail2
                                                              .value = '1';
                                                        } else {
                                                          profile
                                                              .userGeneralInfo
                                                              .tagsList
                                                              .objectTag[
                                                                  widget.indexu]
                                                              .tags[
                                                                  widget.index]
                                                              .preferenceUser
                                                              .includeMail2
                                                              .value = '0';
                                                        }
                                                      });
                                                    },
                                                  )),
                                            ),
                                          ],
                                        )
                                      : Container()
                                  : widget.type == 'medical'
                                      ? profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .tagUserInfo
                                                      .mail2 !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .tagUserInfo
                                                      .mail2 !=
                                                  ''
                                          ? Row(
                                              children: <Widget>[
                                                Expanded(
                                                    flex: 6,
                                                    child: MyText(
                                                        value: profile
                                                                .userGeneralInfo
                                                                .tagsList
                                                                .medicalTag[
                                                                    widget
                                                                        .indexu]
                                                                .tags[widget
                                                                    .index]
                                                                .tagUserInfo
                                                                .mail2 ??
                                                            ' ',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color: ColorConstant
                                                            .textColor)),
                                                Expanded(
                                                  flex: 4,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: CustomSwitch(
                                                        activeColor:
                                                            Color(0xff34C759),
                                                        value: profile
                                                                    .userGeneralInfo
                                                                    .tagsList
                                                                    .medicalTag[
                                                                        widget
                                                                            .indexu]
                                                                    .tags[widget
                                                                        .index]
                                                                    .preferenceUser
                                                                    .includeMail1
                                                                    .value ==
                                                                '1'
                                                            ? true
                                                            : false,
                                                        onChanged: (value) {
                                                          profile
                                                              .userGeneralInfo
                                                              .update = true;

                                                          setState(() {
                                                            if (value == true) {
                                                              profile
                                                                  .userGeneralInfo
                                                                  .tagsList
                                                                  .medicalTag[
                                                                      widget
                                                                          .indexu]
                                                                  .tags[widget
                                                                      .index]
                                                                  .preferenceUser
                                                                  .includeMail2
                                                                  .value = '1';
                                                            } else {
                                                              profile
                                                                  .userGeneralInfo
                                                                  .tagsList
                                                                  .medicalTag[
                                                                      widget
                                                                          .indexu]
                                                                  .tags[widget
                                                                      .index]
                                                                  .preferenceUser
                                                                  .includeMail2
                                                                  .value = '0';
                                                            }
                                                          });
                                                        },
                                                      )),
                                                ),
                                              ],
                                            )
                                          : Container()
                                      : Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 6,
                                                child: MyText(
                                                    value: profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .petTag[
                                                                widget.indexu]
                                                            .tags[widget.index]
                                                            .tagUserInfo
                                                            .mail2 ??
                                                        ' ',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: ColorConstant
                                                        .textColor)),
                                            Expanded(
                                              flex: 4,
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: CustomSwitch(
                                                    activeColor:
                                                        Color(0xff34C759),
                                                    value: profile
                                                                .userGeneralInfo
                                                                .tagsList
                                                                .petTag[widget
                                                                    .indexu]
                                                                .tags[widget
                                                                    .index]
                                                                .preferenceUser
                                                                .includeMail1
                                                                .value ==
                                                            '1'
                                                        ? true
                                                        : false,
                                                    onChanged: (value) {
                                                      profile.userGeneralInfo
                                                          .update = true;

                                                      setState(() {
                                                        if (value == true) {
                                                          profile
                                                              .userGeneralInfo
                                                              .tagsList
                                                              .petTag[
                                                                  widget.indexu]
                                                              .tags[
                                                                  widget.index]
                                                              .preferenceUser
                                                              .includeMail2
                                                              .value = '1';
                                                        } else {
                                                          profile
                                                              .userGeneralInfo
                                                              .tagsList
                                                              .petTag[
                                                                  widget.indexu]
                                                              .tags[
                                                                  widget.index]
                                                              .preferenceUser
                                                              .includeMail2
                                                              .value = '0';
                                                        }
                                                      });
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                              SizedBox(
                                height: 0.0 ?? 12.5,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 0.40,
                            color: ColorConstant.dividerColor,
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: MyText(
                                    value: "pets_label_livechatme".tr(),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: ColorConstant.textColor),
                              ),
                              Expanded(
                                flex: 3,
                                child: Image.asset(
                                  "Assets/Images/info.png",
                                  height: 14,
                                  width: 14,
                                ),
                              ),
                              widget.type == 'object'
                                  ? CustomSwitch(
                                      activeColor: Color(0xff34C759),
                                      value: profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .objectTag[widget.indexu]
                                                  .tags[widget.index]
                                                  .preferenceUser
                                                  .allowLiveChat
                                                  .value ==
                                              1
                                          ? true
                                          : false,
                                      onChanged: (value) {
                                        profile.userGeneralInfo.update = true;

                                        setState(() {
                                          if (value == true) {
                                            profile
                                                .userGeneralInfo
                                                .tagsList
                                                .objectTag[widget.indexu]
                                                .tags[widget.index]
                                                .preferenceUser
                                                .allowLiveChat
                                                .value = '1';
                                          } else {
                                            profile
                                                .userGeneralInfo
                                                .tagsList
                                                .objectTag[widget.indexu]
                                                .tags[widget.index]
                                                .preferenceUser
                                                .allowLiveChat
                                                .value = '0';
                                          }
                                        });
                                      },
                                    )
                                  : widget.type == 'medical'
                                      ? CustomSwitch(
                                          activeColor: Color(0xff34C759),
                                          value: profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .preferenceUser
                                                      .allowLiveChat
                                                      .value ==
                                                  '1'
                                              ? true
                                              : false,
                                          onChanged: (value) {
                                            profile.userGeneralInfo.update =
                                                true;

                                            setState(() {
                                              if (value == true) {
                                                profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .medicalTag[widget.indexu]
                                                    .tags[widget.index]
                                                    .preferenceUser
                                                    .allowLiveChat
                                                    .value = '1';
                                              } else {
                                                profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .medicalTag[widget.indexu]
                                                    .tags[widget.index]
                                                    .preferenceUser
                                                    .allowLiveChat
                                                    .value = '0';
                                              }
                                            });
                                          },
                                        )
                                      : CustomSwitch(
                                          activeColor: Color(0xff34C759),
                                          value: profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .petTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .preferenceUser
                                                      .allowLiveChat
                                                      .value ==
                                                  '1'
                                              ? true
                                              : false,
                                          onChanged: (value) {
                                            profile.userGeneralInfo.update =
                                                true;

                                            setState(() {
                                              if (value == true) {
                                                profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .petTag[widget.indexu]
                                                    .tags[widget.index]
                                                    .preferenceUser
                                                    .allowLiveChat
                                                    .value = '1';
                                              } else {
                                                profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .petTag[widget.indexu]
                                                    .tags[widget.index]
                                                    .preferenceUser
                                                    .allowLiveChat
                                                    .value = '0';
                                              }
                                            });
                                          },
                                        ),
                            ],
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Container(
                            height: 0.40,
                            color: ColorConstant.dividerColor,
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          widget.type == 'object'
                              ? profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[widget.indexu]
                                              .tags[widget.index]
                                              .tagUserInfo
                                              .mobile ==
                                          null ||
                                      profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[widget.indexu]
                                              .tags[widget.index]
                                              .tagUserInfo
                                              .mobile ==
                                          ''
                                  ? Container()
                                  : Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 6,
                                          child: MyText(
                                              value:
                                                  "pets_label_mobilecellnumber"
                                                      .tr(),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: ColorConstant.textColor),
                                        ),
                                        Image.asset(
                                          "Assets/Images/info.png",
                                          height: 14,
                                          width: 14,
                                        ),
                                        SizedBox(
                                          width: 52,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: MyText(
                                              value: "pets_label_textme".tr(),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: ColorConstant.textColor),
                                        )
                                      ],
                                    )
                              : profile
                                              .userGeneralInfo
                                              .tagsList
                                              .medicalTag[widget.indexu]
                                              .tags[widget.index]
                                              .tagUserInfo
                                              .mobile ==
                                          null ||
                                      profile
                                              .userGeneralInfo
                                              .tagsList
                                              .medicalTag[widget.indexu]
                                              .tags[widget.index]
                                              .tagUserInfo
                                              .mobile ==
                                          ''
                                  ? Container()
                                  : Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 6,
                                          child: MyText(
                                              value:
                                                  "pets_label_mobilecellnumber"
                                                      .tr(),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: ColorConstant.textColor),
                                        ),
                                        Image.asset(
                                          "Assets/Images/info.png",
                                          height: 14,
                                          width: 14,
                                        ),
                                        SizedBox(
                                          width: 52,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: MyText(
                                              value: "pets_label_textme".tr(),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: ColorConstant.textColor),
                                        )
                                      ],
                                    ),
                          widget.type == 'object'
                              ? profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[widget.indexu]
                                              .tags[widget.index]
                                              .tagUserInfo
                                              .mobile ==
                                          null ||
                                      profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[widget.indexu]
                                              .tags[widget.index]
                                              .tagUserInfo
                                              .mobile ==
                                          ''
                                  ? Container()
                                  : Row(children: <Widget>[
                                      Expanded(
                                          flex: 2,
                                          child: MyText(
                                              value: profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .tagUserInfo
                                                      .codePhone ??
                                                  ' ',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: ColorConstant.textColor)),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: MyText(
                                              value: profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .tagUserInfo
                                                      .mobile ??
                                                  '',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: ColorConstant.textColor)),
                                      SizedBox(
                                        width: 46,
                                      ),
                                      CustomSwitch(
                                        activeColor: Color(0xff34C759),
                                        value: profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .objectTag[widget.indexu]
                                                    .tags[widget.index]
                                                    .preferenceUser
                                                    .includeMobile
                                                    .value ==
                                                "1"
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          profile.userGeneralInfo.update = true;

                                          setState(() {
                                            if (value == true) {
                                              profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .objectTag[widget.indexu]
                                                  .tags[widget.index]
                                                  .preferenceUser
                                                  .includeMobile
                                                  .value = '1';
                                            } else {
                                              profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .objectTag[widget.indexu]
                                                  .tags[widget.index]
                                                  .preferenceUser
                                                  .includeMobile
                                                  .value = '0';
                                            }
                                          });
                                        },
                                      )
                                    ])
                              : widget.type == 'medical'
                                  ? profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .medicalTag[widget.indexu]
                                                  .tags[widget.index]
                                                  .tagUserInfo
                                                  .mobile ==
                                              null ||
                                          profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .medicalTag[widget.indexu]
                                                  .tags[widget.index]
                                                  .tagUserInfo
                                                  .mobile ==
                                              ''
                                      ? Container()
                                      : Row(children: <Widget>[
                                          Expanded(
                                              flex: 2,
                                              child: MyText(
                                                  value: profile
                                                          .userGeneralInfo
                                                          .tagsList
                                                          .medicalTag[
                                                              widget.indexu]
                                                          .tags[widget.index]
                                                          .tagUserInfo
                                                          .codePhone ??
                                                      ' ',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color:
                                                      ColorConstant.textColor)),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: MyText(
                                                  value: profile
                                                          .userGeneralInfo
                                                          .tagsList
                                                          .medicalTag[
                                                              widget.indexu]
                                                          .tags[widget.index]
                                                          .tagUserInfo
                                                          .mobile ??
                                                      '',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color:
                                                      ColorConstant.textColor)),
                                          SizedBox(
                                            width: 46,
                                          ),
                                          CustomSwitch(
                                            activeColor: Color(0xff34C759),
                                            value: profile
                                                        .userGeneralInfo
                                                        .tagsList
                                                        .medicalTag[
                                                            widget.indexu]
                                                        .tags[widget.index]
                                                        .preferenceUser
                                                        .includeMobile
                                                        .value ==
                                                    "1"
                                                ? true
                                                : false,
                                            onChanged: (value) {
                                              profile.userGeneralInfo.update =
                                                  true;

                                              setState(() {
                                                if (value == true) {
                                                  profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .preferenceUser
                                                      .includeMobile
                                                      .value = '1';
                                                } else {
                                                  profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .preferenceUser
                                                      .includeMobile
                                                      .value = '0';
                                                }
                                              });
                                            },
                                          )
                                        ])
                                  : Row(children: <Widget>[
                                      Expanded(
                                          flex: 2,
                                          child: MyText(
                                              value: profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .petTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .tagUserInfo
                                                      .codePhone ??
                                                  ' ',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: ColorConstant.textColor)),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: MyText(
                                            value: profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .petTag[widget.indexu]
                                                    .tags[widget.index]
                                                    .tagUserInfo
                                                    .mobile ??
                                                '',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor),
                                      ),
                                      SizedBox(
                                        width: 46,
                                      ),
                                      CustomSwitch(
                                        activeColor: Color(0xff34C759),
                                        value: profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .petTag[widget.indexu]
                                                    .tags[widget.index]
                                                    .preferenceUser
                                                    .includeMobile
                                                    .value ==
                                                "1"
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          profile.userGeneralInfo.update = true;

                                          setState(() {
                                            if (value == true) {
                                              profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .petTag[widget.indexu]
                                                  .tags[widget.index]
                                                  .preferenceUser
                                                  .includeMobile
                                                  .value = '1';
                                            } else {
                                              profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .petTag[widget.indexu]
                                                  .tags[widget.index]
                                                  .preferenceUser
                                                  .includeMobile
                                                  .value = '0';
                                            }
                                          });
                                        },
                                      )
                                    ]),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                isMember == true || member == true
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 10, top: 0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.black26,
                                offset: Offset(1.0, 3.0),
                                //  spreadRadius: 7.0,
                                blurRadius: 3.0,
                              ),
                            ],
                            color: ColorConstant.pinkColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0, color: ColorConstant.boxColor),
                              color: ColorConstant.boxColor,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                              )),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 11, right: 20.5, bottom: 23),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 14.5,
                                ),
                                MyText(
                                    value: "pets_label_confidentiality".tr(),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: ColorConstant.textColor),
                                SizedBox(
                                  height: 14.5,
                                ),
                                Container(
                                  height: 0.40,
                                  color: ColorConstant.dividerColor,
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                _includeEmail(profile, index),
                                SizedBox(
                                  height: 11,
                                ),
                                Container(
                                  height: 0.40,
                                  color: ColorConstant.dividerColor,
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                _includePhone(profile, index),
                                SizedBox(
                                  height: 11,
                                ),
                                Container(
                                  height: 0.40,
                                  color: ColorConstant.dividerColor,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                _includeName(profile, index),
                                SizedBox(
                                  height: 11,
                                ),
                                Container(
                                  height: 0.40,
                                  color: ColorConstant.dividerColor,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                _includePicture(profile, index),
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 0),
                  decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black26,
                          offset: Offset(1.0, 3.0),
                          //  spreadRadius: 7.0,
                          blurRadius: 3.0,
                        ),
                      ],
                      color: ColorConstant.pinkColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0, color: ColorConstant.boxColor),
                        color: ColorConstant.boxColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        )),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 11, right: 20.5, bottom: 23),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 14.5,
                          ),
                          MyText(
                              value: "pets_label_contact".tr(),
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: ColorConstant.textColor),
                          SizedBox(
                            height: 14.5,
                          ),
                          Container(
                            height: 0.40,
                            color: ColorConstant.dividerColor,
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          _emergencyContacts(profile),
                        ],
                      ),
                    ),
                  ),
                ),
              ])
            : Container(),
      ],
    );
  }

  _emergencyContacts(Profile profile) {
    int indexTag = widget.index;

    return Column(
      children: <Widget>[
        Container(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor.withOpacity(.30)),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.type == 'object'
                      ? profile
                          .userGeneralInfo
                          .tagsList
                          .objectTag[widget.indexu]
                          .tags[indexTag]
                          .emergencyContactUser
                          .length
                      : profile
                          .userGeneralInfo
                          .tagsList
                          .medicalTag[widget.indexu]
                          .tags[indexTag]
                          .emergencyContactUser
                          .length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(children: [
                      ExpandableEmergencyTag(
                          key: Key(profile
                              .userGeneralInfo
                              .tagsList
                              .objectTag[widget.indexu]
                              .tags[indexTag]
                              .emergencyContactUser[index]
                              .firstName),
                          addBlockEmergency: addBlockEmergTag,
                          userEmergencyContact: widget.type == 'object'
                              ? profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[indexTag]
                                  .emergencyContactUser[index]
                              : profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[indexTag]
                                  .emergencyContactUser[index],
                          index: index,
                          dropdownValue: widget.type == 'object'
                              ? profile
                                          .userGeneralInfo
                                          .tagsList
                                          .objectTag[widget.indexu]
                                          .tags[indexTag]
                                          .emergencyContactUser[index]
                                          .active ==
                                      1
                                  ? true
                                  : false
                              : profile
                                          .userGeneralInfo
                                          .tagsList
                                          .medicalTag[widget.indexu]
                                          .tags[indexTag]
                                          .emergencyContactUser[index]
                                          .active ==
                                      1
                                  ? true
                                  : false,
                          visibile: _visibile),
                      SizedBox(
                        width: 12,
                      ),
                    ]);
                  },
                ),
                Container(
                    height: 0.45,
                    color: ColorConstant.dividerColor.withOpacity(.30)),
                SizedBox(
                  height: 16.5,
                ),
                Row(
                  children: <Widget>[
                    Visibility(
                      visible: true,
                      child: Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ButtonTheme(
                              height: 36.0,
                              minWidth: 280.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: RaisedButton(
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.white,
                                color: Colors.white,
                                textColor: ColorConstant.pinkColor,
                                child: MyText(
                                  value: 'editprofil_general_btn_addnew'.tr(),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.pinkColor,
                                ),
                                onPressed: nombrebolckAlsoContact < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckAlsoContact++;
                                          profile.userGeneralInfo.update = true;

                                          for (int i = 0;
                                              i < addBlockEmergTag.length;
                                              i++) {
                                            if (addBlockEmergTag[i] == true) {
                                              addBlockEmergTag[i] = false;
                                            }
                                          }

                                          addBlockEmergTag.add(true);
                                          UserEmergencyContact alsoContTag =
                                              UserEmergencyContact(
                                            active: 1,
                                            allowChat: 0,
                                            allowMail1: 0,
                                            allowMail2: 0,
                                            allowMobile: 0,
                                            codePhone: '',
                                            codePhoneCountry: '',
                                            firstName: '',
                                            lastName: '',
                                            mail: '',
                                            mail2: '',
                                            mobile: '',
                                            tel: '',
                                          );

                                          widget.type == 'object'
                                              ? profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .objectTag[widget.indexu]
                                                  .tags[indexTag]
                                                  .emergencyContactUser
                                                  .add(alsoContTag)
                                              : profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .medicalTag[widget.indexu]
                                                  .tags[indexTag]
                                                  .emergencyContactUser
                                                  .add(alsoContTag);
                                        });
                                      }
                                    : null,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _thankyou(Profile profile, int index) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: thankyou ||
                      _thnkyouMsgStatus(
                          profile, index, widget.indexu, widget.type)
                  ? ColorConstant.pinkColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(thankyou ? 0 : 5.0),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: InkWell(
              onTap: () {
                setState(() {
                  thankyou = !thankyou;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(thankyou ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 12.5),
                    ),
                    MyText(
                        value: 'editprofil_special_bloctitle_thankyoumsg'.tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: thankyou ||
                                _thnkyouMsgStatus(
                                    profile, index, widget.indexu, widget.type)
                            ? ColorConstant.textColor
                            : ColorConstant.darkGray),
                    SizedBox(
                      width: 17,
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            "Assets/Images/info.png",
                            height: 14,
                            width: 14,
                          )),
                    ),
                    thankyou
                        ? Image.asset(
                            "Assets/Images/arrowup_bleu.png",
                            height: 8,
                            width: 13.18,
                          )
                        : Container(),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        thankyou
            ? Container(
                padding: EdgeInsets.only(left: 10, top: 0),
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1.0, 3.0),
                        //  spreadRadius: 7.0,
                        blurRadius: 3.0,
                      ),
                    ],
                    color: ColorConstant.pinkColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 12.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        MyText(
                            value:
                                'editprofil_general_blocinfo_someonefinds'.tr(),
                            fontSize: 12,
                            color: ColorConstant.darkGray,
                            fontWeight: FontWeight.w400),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 96,
                          padding: EdgeInsets.fromLTRB(10, 0, 11, 0),
                          decoration: BoxDecoration(
                            color: ColorConstant.textfieldColor,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: widget.type == 'object'
                              ? MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                    textScaleFactor: MediaQuery.of(context)
                                        .textScaleFactor
                                        .clamp(1.0, 1.0),
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                    initialValue: profile
                                        .userGeneralInfo
                                        .tagsList
                                        .objectTag[widget.indexu]
                                        .tags[widget.index]
                                        .tagInfo
                                        .tagCustumMessage,
                                    maxLines: 2,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    focusNode: _thankYouFocus,
                                    maxLength: 90,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontSize: 1.0, color: Colors.black),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      profile.userGeneralInfo.update = true;
                                      profile
                                          .userGeneralInfo
                                          .tagsList
                                          .objectTag[widget.indexu]
                                          .tags[widget.index]
                                          .tagInfo
                                          .tagCustumMessage = value;
                                    },
                                  ))
                              : widget.type == 'medical'
                                  ? MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        textScaleFactor: MediaQuery.of(context)
                                            .textScaleFactor
                                            .clamp(1.0, 1.0),
                                      ),
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                        ),
                                        initialValue: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagInfo
                                            .tagCustumMessage,
                                        maxLines: 2,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        focusNode: _thankYouFocus,
                                        maxLength: 90,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize: 1.0,
                                              color: Colors.black),
                                          border: InputBorder.none,
                                        ),
                                        /* buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) => null, */
                                        onChanged: (value) {
                                          profile.userGeneralInfo.update = true;
                                          profile
                                              .userGeneralInfo
                                              .tagsList
                                              .medicalTag[widget.indexu]
                                              .tags[widget.index]
                                              .tagInfo
                                              .tagCustumMessage = value;
                                        },
                                      ))
                                  : MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        textScaleFactor: MediaQuery.of(context)
                                            .textScaleFactor
                                            .clamp(1.0, 1.0),
                                      ),
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                        ),
                                        initialValue: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .petTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagInfo
                                            .tagCustumMessage,
                                        maxLines: 2,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        focusNode: _thankYouFocus,
                                        maxLength: 90,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize: 1.0,
                                              color: Colors.black),
                                          border: InputBorder.none,
                                        ),
                                        /* buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) => null, */
                                        onChanged: (value) {
                                          profile.userGeneralInfo.update = true;
                                          profile
                                              .userGeneralInfo
                                              .tagsList
                                              .petTag[widget.indexu]
                                              .tags[widget.index]
                                              .tagInfo
                                              .tagCustumMessage = value;
                                        },
                                      )),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _viwExport(Profile profile, int index) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 0),
      decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black26,
              offset: Offset(1.0, 3.0),
              //  spreadRadius: 7.0,
              blurRadius: 3.0,
            ),
          ],
          color: ColorConstant.pinkColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(8),
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8))),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0, color: ColorConstant.boxColor),
            color: ColorConstant.boxColor,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(8))),
        child: Padding(
          padding: EdgeInsets.only(left: 10.5, right: 20.5, bottom: 12.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 13,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 11, 0),
                child: Column(
                  children: [
                    Container(
                      child: MyText(
                          value: 'pets_label_viewexport'.tr(),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorConstant.textColor),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Container(
                height: 0.45,
                color: ColorConstant.dividerColor,
              ),
              Container(
                child: _petRecord(profile, index),
              )
            ],
          ),
        ),
      ),
    );
  }

  _PosterFound(Profile profile, int index) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,

                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: ColorConstant.pinkColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: InkWell(
              onTap: () {
                setState(() {
                  PosterFound = !PosterFound;
                  _scrollController.jumpTo(170);

                  DescriptionObject = false;
                  ObjectInfo = false;
                  AdvancedSettings = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: SvgPicture.asset(
                        'Assets/Images/lostFound.svg',
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                                value:
                                    /*         index == null
                                  ? idMembers.firstWhere((element) =>
                                          element['idMember'] ==
                                          profile
                                              .userGeneralInfo
                                              .userTags
                                              .objectTag
                                              .last
                                              .tagInfo
                                              .idMember)['firstName'] +
                                      '’s lost & found poster'
                                  : idMembers.firstWhere((element) =>
                                          element['idMember'] ==
                                          profile
                                              .userGeneralInfo
                                              .userTags
                                              .objectTag[index]
                                              .tagInfo
                                              .idMember)['firstName'] + */
                                    'objecttag_bloctitle_lostfoundposter'.tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: ColorConstant.whiteTextColor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    PosterFound
                        ? Image.asset(
                            "Assets/Images/arrowup_white.png",
                            height: 8,
                            width: 13.18,
                          )
                        : Container(),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        PosterFound
            ? Container(
                padding: EdgeInsets.only(left: 0, top: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 12),
                        _posterRecord(),
                        SizedBox(height: 12),

                        SizedBox(height: 12),
                        //_otherinfo(),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _rewards() {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: ColorConstant.pinkColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(rewards ? 0 : 5.0),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: InkWell(
              onTap: () {
                setState(() {
                  rewards = !rewards;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(rewards ? 0 : 5.0))),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 13.3, right: 23.3),
                        child: Image.asset(
                          "Assets/Images/rewards.png",
                          height: 28.67,
                          width: 25.32,
                        ),
                      ),
                      MyText(
                          value: "objecttag_bloctitle_reward".tr(),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorConstant.textColor),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              "Assets/Images/info.png",
                              height: 14,
                              width: 14,
                            )),
                      ),
                      rewards
                          ? Image.asset(
                              "Assets/Images/arrowup_bleu.png",
                              height: 8,
                              width: 13.18,
                            )
                          : Container(),
                      SizedBox(
                        width: 22.2,
                      )
                    ],
                  ),
                ),
              )),
        ),
        rewards
            ? Container(
                padding: EdgeInsets.only(left: 10, top: 0),
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1.0, 3.0),
                        //  spreadRadius: 7.0,
                        blurRadius: 3.0,
                      ),
                    ],
                    color: ColorConstant.pinkColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0, color: ColorConstant.boxColor),
                        color: ColorConstant.boxColor,
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(8))),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 10.5, right: 20.5, bottom: 16),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 0.40,
                                color: ColorConstant.dividerColor,
                              ),
                              SizedBox(
                                height: 12.5,
                              ),
                              Container(
                                height: 24,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: rewardList
                                        .map((value) => DropdownMenuItem(
                                              child: MyText(
                                                  value: value,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ColorConstant.textColor),
                                              value: value,
                                            ))
                                        .toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        rewardData = newVal;
                                      });
                                    },
                                    isExpanded: true,
                                    value: rewardData,
                                    hint: MyText(
                                        value: 'objecttag_label_currency'.tr(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.darkGray),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: ColorConstant.textfieldColor,
                                  borderRadius: BorderRadius.circular(8),
                                  // border: Border.all(style: BorderStyle.solid, width: 0.70),
                                ),
                              ),
                              SizedBox(height: 9.3),
                              Row(children: <Widget>[
                                Expanded(
                                  child: MyTextField(
                                    inputType: TextInputType.text,
                                    focusNode: rewardFocus,
                                    editTextBgColor:
                                        ColorConstant.textfieldColor,
                                    hintTextColor: Colors.white54,
                                    title: '',
                                    textController: rewardController,
                                  ),
                                ),
                                SizedBox(width: 8.6),
                                CustomSwitch(
                                  activeColor: Color(0xff34C759),
                                  value: _switchReward,
                                  onChanged: (value) {
                                    setState(() {
                                      _switchReward = value;
                                    });
                                  },
                                ),
                              ]),
                              // color: ColorConstant.pinkColor,
                            ]))))
            : Container(),
      ],
    );
  }

  _petRecord(Profile profile, int index) {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _viewRecord = !_viewRecord;
                  });
                },
                child: Column(
                  children: [
                    InkWell(
                        child: Container(
                            height: 36,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                                color: _viewRecord
                                    ? ColorConstant.pinkColor
                                    : ColorConstant.whiteTextColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Center(
                              child: Image.asset(
                                "Assets/Images/view-red.png",
                                color: ColorConstant.pinkColor,
                                height: 21,
                                width: 24.85,
                              ),
                            )),
                        onTap: () {
                          if (profile.userGeneralInfo.update == false) {
                            BlocProvider.of<TagsBloc>(context).dispatch(
                              GoToViewObjectTagEvent(
                                  profile: profile,
                                  type: type,
                                  indexu: indexu,
                                  index: index),
                            );
                          } else {
                            showOverlayUpdate(
                                context,
                                "messages_label_confirmationleave".tr(),
                                "messages_label_confirmationdesc".tr(),
                                profile,
                                type,
                                indexu,
                                index);
                          }
                        }),
                    SizedBox(
                      height: 6,
                    ),
                    MyText(
                        value: "objecttag_label_viewpet".tr(),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.textColor),
                  ],
                ),
              ),
            ),
            SizedBox(width: 13),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _printRecord = !_printRecord;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 0),
                            ),
                          ],
                          color: _printRecord
                              ? ColorConstant.pinkColor
                              : ColorConstant.whiteTextColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Image.asset(
                          "Assets/Images/print-red.png",
                          color: _printRecord
                              ? Colors.white
                              : ColorConstant.pinkColor,
                          height: 21,
                          width: 24.85,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    MyText(
                        value: "objecttag_btn_print".tr(),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.textColor)
                  ],
                ),
              ),
            ),
            SizedBox(width: 13),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _emailRecord = !_emailRecord;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                          color: _emailRecord
                              ? ColorConstant.pinkColor
                              : ColorConstant.whiteTextColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Image.asset(
                          "Assets/Images/email-red.png",
                          color: _emailRecord
                              ? Colors.white
                              : ColorConstant.pinkColor,
                          height: 21,
                          width: 24.85,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    MyText(
                        value: "objecttag_btn_email".tr(),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.textColor)
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  _posterRecord() {
    return Column(children: <Widget>[
      Container(
          padding: EdgeInsets.only(left: 10, top: 0),
          decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: ColorConstant.pinkColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(8))),
              child: Padding(
                  padding: EdgeInsets.only(
                      left: 30.5, right: 40.5, bottom: 23, top: 23),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _printRecord = !_printRecord;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 36,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                          color: _printRecord
                                              ? ColorConstant.pinkColor
                                              : ColorConstant.whiteTextColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Center(
                                        child: Image.asset(
                                          "Assets/Images/print-red.png",
                                          color: _printRecord
                                              ? Colors.white
                                              : ColorConstant.pinkColor,
                                          height: 21,
                                          width: 24.85,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    MyText(
                                        value: "objecttag_btn_print".tr(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.textColor)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 13),
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _emailRecord = !_emailRecord;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 36,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                          color: _emailRecord
                                              ? ColorConstant.pinkColor
                                              : ColorConstant.whiteTextColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Center(
                                        child: Image.asset(
                                          "Assets/Images/email-red.png",
                                          color: _emailRecord
                                              ? Colors.white
                                              : ColorConstant.pinkColor,
                                          height: 21,
                                          width: 24.85,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    MyText(
                                        value: "objecttag_btn_email".tr(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.textColor)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ]))))
    ]);
  }

  _AdvancedSettings(Profile profile, int index) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              border: AdvancedSettings ||
                      _advancedSettingsStatus(
                          profile, index, widget.indexu, widget.type)
                  ? Border.all(style: BorderStyle.none)
                  : Border.all(
                      color: ColorConstant.borderBlockVide,
                      style: BorderStyle.solid),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,

                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: AdvancedSettings ||
                      _advancedSettingsStatus(
                          profile, index, widget.indexu, widget.type)
                  ? ColorConstant.pinkColor
                  : ColorConstant.colorBlockVide,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: InkWell(
              onTap: () {
                setState(() {
                  AdvancedSettings = !AdvancedSettings;
                  _scrollController.jumpTo(120);

                  DescriptionObject = false;
                  ObjectInfo = false;
                  PosterFound = false;
                  thankyou = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: SvgPicture.asset(
                        'Assets/Images/advancedS.svg',
                        color: AdvancedSettings ||
                                _advancedSettingsStatus(
                                    profile, index, widget.indexu, widget.type)
                            ? null
                            : ColorConstant.textBlockVide,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                              value: 'pets_label_settings'.tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AdvancedSettings ||
                                      _advancedSettingsStatus(profile, index,
                                          widget.indexu, widget.type)
                                  ? ColorConstant.whiteTextColor
                                  : ColorConstant.textBlockVide,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    AdvancedSettings
                        ? Image.asset(
                            "Assets/Images/arrowup_white.png",
                            height: 8,
                            width: 13.18,
                          )
                        : Container(),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        AdvancedSettings
            ? Container(
                padding: EdgeInsets.only(left: 0, top: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 12),
                        _thankyou(profile, index),
                        SizedBox(height: 12),
                        Visibility(visible: false, child: _rewards()),
                        SizedBox(height: 12),
                        widget.type == 'object'
                            ? _other(profile, index)
                            : _otherMedical(profile, index),
                        SizedBox(height: 12),
                        _viwExport(profile, index),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  String message;
  bool checkerFirstName = true;
  bool checkerEmail1 = true;
  bool checkerEmail2 = true;
  bool checkerTel = true;
  bool validateDescription = true;
  bool validateCategorie = true;
  bool validateOwner = true;
  int i;
  int j;
  int k;
  int l;
  int m;
  int n;
  int o;
  int indexx;

  static showOverlay(
      BuildContext context, String headerMessage, String message) {
    Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  _duplicateTag(Profile profile, int indexu, int index, String type) {
    return MyButton(
        title: type == 'object'
            ? "objecttag_btn_activatenewobj".tr()
            : "objecttag_btn_activatenewobjtext".tr(),
        height: 46.0,
        titleSize: 14,
        cornerRadius: 8,
        fontWeight: FontWeight.w600,
        titleColor: Color(0xffEC1C40),
        btnBgColor: ColorConstant.boxColor,
        onPressed: () {
          if (type == 'object') {
            profile.userGeneralInfo.duplicate = 'yes';
            profile.parameters.typecheck = "object";
            profile.parameters.indexu = indexu;
            profile.parameters.indext = index;
          } else if (type == 'medical') {
            profile.userGeneralInfo.duplicate = 'yes';
            profile.parameters.typecheck = "medical";
            profile.parameters.indexu = indexu;
            profile.parameters.indext = index;
          }

          profile.parameters.location = "Add Tag";

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/tagsProvider',
              arguments: profile,
            );
          });
        });
  }

  _editTag(Profile profile, int index) {
    return MyButton(
      title: "objecttag_btn_savetag".tr(),
      height: 46.0,
      titleSize: 14,
      cornerRadius: 8,
      fontWeight: FontWeight.w600,
      titleColor: Color(0xffEC1C40),
      btnBgColor: ColorConstant.boxColor,
      onPressed: () {
        message = '';
        checkerFirstName = true;
        checkerEmail1 = true;
        checkerEmail2 = true;
        checkerTel = true;
        validateDescription = true;
        validateCategorie = true;
        validateOwner = true;
        i = 0;
        j = 0;
        k = 0;
        l = 0;
        m = 0;
        n = 0;
        o = 0;
        if (widget.type == 'object') {
          if (profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
              .tags[widget.index].emergencyContactUser.isNotEmpty) {
            if (profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                        .firstName ==
                    '' &&
                profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                        .tags[widget.index].emergencyContactUser.last.mail ==
                    '' &&
                profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                        .tags[widget.index].emergencyContactUser.last.mail2 ==
                    '' &&
                profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                        .tags[widget.index].emergencyContactUser.last.mobile ==
                    '') {
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                  .tags[widget.index].emergencyContactUser
                  .removeLast();
            }
          }

          if (profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
              .tags[widget.index].otherInfo.isNotEmpty) {
            if (profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                        .tags[widget.index].otherInfo.last.label ==
                    '' &&
                profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                        .tags[widget.index].otherInfo.last.description ==
                    '' &&
                profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                        .tags[widget.index].otherInfo.last.documents.length ==
                    0) {
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                  .tags[widget.index].otherInfo
                  .removeLast();
            } else if (profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                    .tags[widget.index].otherInfo.last.label ==
                '') {
              checkerFirstName = false;
              message = 'pets_label_lastotherinfo'.tr();
            }
          }

          if (profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
              .tags[widget.index].emergencyContactUser.isNotEmpty) {
            profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                .tags[widget.index].emergencyContactUser
                .forEach((element) {
              i++;

              if (element.firstName.isNotEmpty) {
                if (regExpName.hasMatch(element.firstName) != true) {
                  checkerFirstName = false;
                  message = "pets_label_namealsocontact".tr() + ' $i';
                }
              }
              if (regExpEmail.hasMatch(element.mail) != true) {
                checkerEmail1 = false;
                message = "pets_label_primarymailalsocontact".tr() +
                    ' ${element.firstName}';
              }

              if (element.mail2.isNotEmpty) {
                if (regExpEmail.hasMatch(element.mail2) != true) {
                  checkerEmail2 = false;
                  message = "pets_label_secondarymailalsocontact".tr() +
                      ' ${element.firstName}';
                }
              }
              if (element.mobile.isNotEmpty) {
                if (regExpNumber.hasMatch(element.mobile) != true) {
                  checkerTel = false;
                  message = 'pets_label_phonealsocontact'.tr() +
                      ' ${element.firstName}';
                }
              }
            });
          }

          if (profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].tagInfo.tagLabel ==
                  null ||
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].tagInfo.tagLabel ==
                  '') {
            validateDescription = false;
            message = 'pets_label_descriptionrequired'.tr();
          }

          if (profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].tagInfo.idMember ==
                  null ||
              profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                      .tags[widget.index].tagInfo.idMember ==
                  '') {
            validateOwner = false;
            message = 'pets_label_ownerobjectrequired'.tr();
          }

          if (profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
                  .tags[widget.index].tagInfo.idType ==
              null) {
            validateCategorie = false;
            message = 'pets_label_categoryrequired'.tr();
          }
        } else if (widget.type == 'medical') {
          if (profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
              .tags[widget.index].emergencyContactUser.isNotEmpty) {
            if (profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                        .firstName ==
                    '' &&
                profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                        .tags[widget.index].emergencyContactUser.last.mail ==
                    '' &&
                profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                        .tags[widget.index].emergencyContactUser.last.mail2 ==
                    '' &&
                profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                        .tags[widget.index].emergencyContactUser.last.mobile ==
                    '') {
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                  .tags[widget.index].emergencyContactUser
                  .removeLast();
            }
          }

          if (profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
              .tags[widget.index].otherInfo.isNotEmpty) {
            if (profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                        .tags[widget.index].otherInfo.last.label ==
                    '' &&
                profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                        .tags[widget.index].otherInfo.last.description ==
                    '' &&
                profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                        .tags[widget.index].otherInfo.last.documents.length ==
                    0) {
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                  .tags[widget.index].otherInfo
                  .removeLast();
            } else if (profile
                    .userGeneralInfo
                    .tagsList
                    .medicalTag[widget.indexu]
                    .tags[widget.index]
                    .otherInfo
                    .last
                    .label ==
                '') {
              checkerFirstName = false;
              message = 'pets_label_labelrequired';
            }
          }

          if (profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
              .tags[widget.index].emergencyContactUser.isNotEmpty) {
            profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                .tags[widget.index].emergencyContactUser
                .forEach((element) {
              i++;

              if (element.firstName.isNotEmpty) {
                if (regExpName.hasMatch(element.firstName) != true) {
                  checkerFirstName = false;
                  print(element.firstName);
                  message = 'pets_label_namealsocontact'.tr() + ' $i';
                }
              }
              if (regExpEmail.hasMatch(element.mail) != true) {
                checkerEmail1 = false;
                message = 'pets_label_primarymailalsocontact'.tr() +
                    ' ${element.firstName}';
              }

              if (element.mail2.isNotEmpty) {
                if (regExpEmail.hasMatch(element.mail2) != true) {
                  checkerEmail2 = false;
                  message = 'pets_label_secondarymailalsocontact'.tr() +
                      ' ${element.firstName}';
                }
              }
              if (element.mobile.isNotEmpty) {
                if (regExpNumber.hasMatch(element.mobile) != true) {
                  checkerTel = false;
                  message = 'pets_label_phonealsocontact'.tr() +
                      ' ${element.firstName}';
                }
              }
            });
          }

          if (profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].tagInfo.tagLabel ==
                  null ||
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].tagInfo.tagLabel ==
                  '') {
            validateDescription = false;
            message = 'pets_label_descriptionrequired'.tr();
          }

          if (profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].tagInfo.idMember ==
                  null ||
              profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                      .tags[widget.index].tagInfo.idMember ==
                  '') {
            validateOwner = false;
            message = 'pets_label_ownerobjectrequired'.tr();
          }

          if (profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
                  .tags[widget.index].tagInfo.idType ==
              null) {
            validateCategorie = false;
            message = 'pets_label_categoryrequired'.tr();
          }
        }
        if (checkerFirstName == false ||
            checkerEmail1 == false ||
            checkerEmail2 == false ||
            validateCategorie == false ||
            validateOwner == false ||
            checkerTel == false) {
          showOverlay(context, "problem_infos".tr(), message);
        } else {
          profile.userGeneralInfo.update = false;
          dispatchAddEditObjectTag(
              profile, widget.type, widget.index, widget.indexu);
        }
      },
    );
  }

  // _Activatenew() {
  //   return MyButton(
  //     title: "ACTIVATE A NEW OBJECT \n USING THESE PRESETS ",
  //     height: 46.0,
  //     titleSize: 14,
  //     cornerRadius: 8,
  //     fontWeight: FontWeight.w600,
  //     titleColor: Color(0xffEC1C40),
  //     btnBgColor: ColorConstant.boxColor,
  //     onPressed: () => {},
  //   );
  // }

  _switchqrbutton(Profile profile, int indexu, int index, String type) {
    return MyButton(
      title: "objecttag_btn_switchqr".tr(),
      height: 46.0,
      titleSize: 14,
      cornerRadius: 8,
      fontWeight: FontWeight.w600,
      titleColor: Color(0xffEC1C40),
      btnBgColor: ColorConstant.boxColor,
      onPressed: () {
        dispatchgettoSwitchObjectTag(profile, indexu, index, type);
      },
    );
  }

  dispatchgettoSwitchObjectTag(
      Profile profile, int indexu, int index, String type) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoTogetSwitchObjectTagEvent(
        profile: profile,
        type: type,
        indexu: indexu,
        index: index,
      ),
    );
  }

  static showOverlayDetete(BuildContext context, Profile profile, int indexu,
      int index, String type) async {
    await Navigator.of(context)
        .push(TutorialOverlay(profile, indexu, index, type, context));
  }

  _deleteButton(Profile profile, int indexu, int index, String type) {
    if (index != null) {
      /*  profile.userGeneralInfo.userTags.objectTag[index].tagInfo.value = 0; 
       profile.userGeneralInfo.userTags.objectTag[index].tagInfo.archive= 1; */

      return MyButton(
        title: "objecttag_btn_deletetag".tr(),
        height: 46.0,
        titleSize: 14,
        cornerRadius: 8,
        fontWeight: FontWeight.w600,
        titleColor: Color(0xffEC1C40),
        btnBgColor: ColorConstant.boxColor,
        onPressed: () {
          Future.delayed(Duration.zero,
              () => showOverlayDetete(context, profile, indexu, index, type));
          // }
          // Navigator.of(context).push(TutorialOverlay(profile, index, context));
        },
      );
    } else {
      return MyButton(
        title: "objecttag_btn_deletetag".tr(),
        height: 46.0,
        titleSize: 14,
        cornerRadius: 8,
        fontWeight: FontWeight.w600,
        titleColor: Color(0xffEC1C40),
        btnBgColor: ColorConstant.boxColor,
        onPressed: () {},
      );
    }
  }

  void dispatchUploadFile(Profile profile, String type, int indexu, int index) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      UploadFileEvent(
        profile: profile,
        type: type,
        indexu: indexu,
        index: index,
      ),
    );
  }

  void dispatchGoToHome(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/homeProvider',
      arguments: profile,
    );
  }
/* 
  void dispatchViewTag(Profile profile, int index) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoToViewObjectTagEvent(
        profile: profile,
        index: index,
      ),
    );
  } */

  void dispatchGoToSerialNumberToObjectTag(Profile profile) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoToSerialNumberToObjectTagEvent(
        profile: profile,
      ),
    );
  }

  dispatchAddEditObjectTag(profile, type, index, indexu) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      AddEditObjectTagEvent(
        profile: profile,
        type: widget.type,
        index: widget.index,
        indexu: widget.indexu,
      ),
    );
  }

  bool _descriptionStatus(
      Profile profile, int index, int indexu, String widget_type) {
    if (widget_type == 'object') {
      if ((profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
                      .tagInfo.tagDescription !=
                  null &&
              profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
                      .tagInfo.tagDescription !=
                  "") ||
          (profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
                  .tagInfo.idTagCategorie !=
              null) ||
          (profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
                  .tagInfo.idMember !=
              null)) {
        return true;
      }
    } else if (widget_type == 'medical') {
      if ((profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                      .tagInfo.tagDescription !=
                  null &&
              profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                      .tagInfo.tagDescription !=
                  "") ||
          (profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                  .tagInfo.idTagCategorie !=
              null) ||
          (profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                  .tagInfo.idMember !=
              null)) {
        return true;
      }
    } else if (widget_type == 'pet') {
      if ((profile.userGeneralInfo.tagsList.petTag[indexu].tags[index].tagInfo
                      .tagDescription !=
                  null &&
              profile.userGeneralInfo.tagsList.petTag[indexu].tags[index]
                      .tagInfo.tagDescription !=
                  "") ||
          (profile.userGeneralInfo.tagsList.petTag[indexu].tags[index].tagInfo
                  .idTagCategorie !=
              null) ||
          (profile.userGeneralInfo.tagsList.petTag[indexu].tags[index].tagInfo
                  .idMember !=
              null)) {
        return true;
      }
    }

    return false;
  }

  bool _thnkyouMsgStatus(
      Profile profile, int index, int indexu, String widget_type) {
    if (widget_type == 'object') {
      if (profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index].tagInfo
                  .tagCustumMessage !=
              null &&
          profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index].tagInfo
                  .tagCustumMessage !=
              "") {
        return true;
      }
    } else if (widget_type == 'medical') {
      if (profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                  .tagInfo.tagCustumMessage !=
              null &&
          profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                  .tagInfo.tagCustumMessage !=
              "") {
        return true;
      }
    } else if (widget_type == 'pet') {
      if (profile.userGeneralInfo.tagsList.petTag[indexu].tags[index].tagInfo
                  .tagCustumMessage !=
              null &&
          profile.userGeneralInfo.tagsList.petTag[indexu].tags[index].tagInfo
                  .tagCustumMessage !=
              "") {
        return true;
      }
    }

    return false;
  }

  bool _otherStatus(
      Profile profile, int index, int indexu, String widget_type) {
    if (widget_type == 'object') {
      bool ok = false;
      for (int i = 0;
          i <
              profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
                  .otherInfo.length;
          i++) {
        if ((profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
                        .otherInfo[i].label !=
                    "" &&
                profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
                        .otherInfo[i].label !=
                    null) ||
            (profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
                        .otherInfo[i].description !=
                    "" &&
                profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
                        .otherInfo[i].description !=
                    null)) {
          ok = true;
        }
      }
      if (profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
              .otherInfo.isNotEmpty &&
          ok) {
        return true;
      }
      return false;
    } else if (widget_type == 'medical') {
      bool ok = false;
      for (int i = 0;
          i <
              profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                  .otherInfo.length;
          i++) {
        if ((profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                        .otherInfo[i].label !=
                    "" &&
                profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                        .otherInfo[i].label !=
                    null) ||
            (profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                        .otherInfo[i].description !=
                    "" &&
                profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                        .otherInfo[i].description !=
                    null)) {
          ok = true;
        }
      }
      if (profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
              .otherInfo.isNotEmpty &&
          ok) {
        return true;
      }
      return false;
    } else if (widget_type == 'pet') {
      bool ok = false;
      for (int i = 0;
          i <
              profile.userGeneralInfo.tagsList.petTag[indexu].tags[index]
                  .otherInfo.length;
          i++) {
        if ((profile.userGeneralInfo.tagsList.petTag[indexu].tags[index]
                        .otherInfo[i].label !=
                    "" &&
                profile.userGeneralInfo.tagsList.petTag[indexu].tags[index]
                        .otherInfo[i].label !=
                    null) ||
            (profile.userGeneralInfo.tagsList.petTag[indexu].tags[index]
                        .otherInfo[i].description !=
                    "" &&
                profile.userGeneralInfo.tagsList.petTag[indexu].tags[index]
                        .otherInfo[i].description !=
                    null)) {
          ok = true;
        }
      }
      if (profile.userGeneralInfo.tagsList.petTag[indexu].tags[index].otherInfo
              .isNotEmpty &&
          ok) {
        return true;
      }
      return false;
    }
  }

  showOverlayUpdate(
    BuildContext context,
    String headerMessage,
    String message,
    Profile profile,
    String type,
    int indexu,
    int index,
  ) {
    Navigator.of(context).push(AlertDialogueUpdate(
        headerMessage, message, profile, type, indexu, index));
  }

  bool _advancedSettingsStatus(
      Profile profile, int index, int indexu, String widget_type) {
    if (_otherStatus(profile, index, indexu, widget_type) ||
        _thnkyouMsgStatus(profile, index, indexu, widget_type)) {
      return true;
    }
    return false;
  }
}
