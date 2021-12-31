import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/customSwitchDiseable.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/AlertDialogueUpdate.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/popupListPet.dart';
import 'package:neopolis/Core/Utils/text.dart';

import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popup_menu.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/blackpopup.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/expandableOtherList.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/expandableListView.dart';
import 'package:neopolis/Features/Pets/Presentation/bloc/pets_bloc.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/ExpandableEmergencyPet.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:neopolis/Core/Utils/date_hint.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/date_picker.dart';
import 'package:neopolis/Core/Utils/nullable_valid_date.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/animations.dart';
import 'package:neopolis/Core/Utils/validDate.dart';
import 'package:easy_localization/easy_localization.dart';

class EditPetProfileDisplay extends StatefulWidget {
  final Profile profile;
  final int index;
  final String loading;
  const EditPetProfileDisplay({Key key, @required this.profile, this.index, this.loading})
      : super(key: key);

  @override
  EditPetProfileDisplayState createState() => EditPetProfileDisplayState();
}

class EditPetProfileDisplayState extends State<EditPetProfileDisplay> {
  //DateOFBirth
  bool dob = false;

  String button;

  List<bool> addBlockEmergency = [];
  List<bool> addBlockVaccin = [];
  List<bool> addBlockOther = [];

  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  bool visiTag = false;
  bool tagInformation = false;
  var genderData;
  bool gender = false;
  bool AdvancedSettings = false;
  bool PosterFound = false;
  bool emergencyContacts = false;

  bool other = false;
  bool thankyou = false;
  bool _switchIncludemail = false;
  bool _switchIncludepic = false;
  bool _switchIncludename = false;
  File imageFile;
  bool _visiVaccin = true;
  bool alarm = true;
  int nombrebolckOther = 0;
  int nbblock = 5;

  TextEditingController physicianContactController =
      new TextEditingController();
  FocusNode distinctiveSignsFocus = FocusNode();
  FocusNode codeFocus = FocusNode();

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
  FocusNode feetFocus = FocusNode();
  FocusNode inchFocus = FocusNode();
  FocusNode cmFocus = FocusNode();
  FocusNode lbsFocus = FocusNode();
  FocusNode kgFocus = FocusNode();
  FocusNode microchipFocus = FocusNode();

  bool height = false;
//Include my first name

  int nombrebolckAlsoContact;
  //Include my phone number
  bool _switchIncludePhone = true;
  Map<dynamic, dynamic> some = {};
  bool _visibile = true;
  bool _visi = true;
  var breed;

  //Include my real address
  bool realAddress = false;
bool member;
  //Include my temporary Address
  bool tempAddress = false;
  bool DescriptionObject = false;
  bool _validateName = false;
  bool _validateOwner = false;
  bool _validateType = false;

  bool vaccines = false;
  TextEditingController vaccinesController = new TextEditingController();
  FocusNode vaccinesFocus = FocusNode();
  List<Map<String, dynamic>> idMembers = [];

  String thisMember;
  owner() {
    idMembers.add({
      'firstName': widget.profile.userGeneralInfo.firstName,
      'idMember': widget.profile.userGeneralInfo.idMember,
    });
widget.profile.userGeneralInfo.roleLabel=='Administrator'?
    widget.profile.userGeneralInfo.subUsers.forEach((element) {
      idMembers.add({
        'firstName': element.userGeneralInfo.firstName,
        'idMember': element.userGeneralInfo.idMember,
      });
    }):null;
  }

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
  bool distinctiveSigns = false;
  List<UserEmergencyContact> listEmergency;
  List rewardList = [
    '10',
    '20',
    '30',
    '40',
  ];

  bool breedPet = false;
  bool dietPet = false;

  bool microchipedPet = false;
  bool colorPet = false;
  var ObjectData;
//miscelaneous
  bool miscellaneous = false;
  TextEditingController miscellaneousController = new TextEditingController();

//PetRecoard
  bool _viewRecord = false;
  bool _emailRecord = false;
  bool _printRecord = false;
  int nombrebolckVaccines = 1;
//Found Poster
  bool vaccin = false;
  bool _viewPoster = false;
  bool _emailPoster = false;
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
    print(firstVisibleItemIndex);
  }

  static showOverlayListPet(BuildContext context, Profile profile) {
    Navigator.of(context).push(ChoosePet(profile));
  }

  void initState() {
    // if (widget.profile.userGeneralInfo.message != null &&
    //     widget.profile.userGeneralInfo.message != 'null' &&
    //     widget.profile.userGeneralInfo.message != 'Success') {
    //   message = widget.profile.userGeneralInfo.message;
    //   Future.delayed(
    //       Duration.zero, () => showOverlayListPet(context, widget.profile));
    // }
 widget.profile.userGeneralInfo.petsInfos[widget.index].generalInfo.thankYouMsg==null? widget.profile.userGeneralInfo.petsInfos[widget.index].generalInfo.thankYouMsg=widget.profile.userGeneralInfo.custumMessage: widget.profile.userGeneralInfo.petsInfos[widget.index].generalInfo.thankYouMsg= widget.profile.userGeneralInfo.petsInfos[widget.index].generalInfo.thankYouMsg;
    widget.profile.userGeneralInfo.roleLabel=='Administrator'?member=false:member=true;
    owner();
    listEmergency =
        widget.profile.userGeneralInfo.petsInfos[widget.index].emergencyContact;
    button =
        widget.profile.userGeneralInfo.petsInfos[widget.index].generalInfo.name;
    nombrebolckAlsoContact = widget.profile.userGeneralInfo
        .petsInfos[widget.index].emergencyContact.length;
    widget.profile.userGeneralInfo.petsInfos[widget.index].emergencyContact
        .forEach((element) {
      addBlockEmergency.add(false);
    });
    widget.profile.userGeneralInfo.petsInfos[widget.index].vaccins
        .forEach((element) {
      addBlockVaccin.add(false);
    });
    widget.profile.userGeneralInfo.petsInfos[widget.index].otherInfo
        .forEach((element) {
      addBlockOther.add(false);
    });
    if (widget.profile.userGeneralInfo.update == null) {
      widget.profile.userGeneralInfo.update = false;
    }

    super.initState();
  }

  bool iconAttachmentVaccine() {
    widget.profile.userGeneralInfo.petsInfos[widget.index].vaccins
        .forEach((element) {
      if (element.documents.length != 0) {
        attachmentPetVaccines = true;
      }
    });
    return attachmentPetVaccines;
  }

  bool iconReminderVaccine() {
    widget.profile.userGeneralInfo.petsInfos[widget.index].vaccins
        .forEach((element) {
      if (element.reminders.length != 0) {
        reminderPetVaccines = true;
      }
    });
    return reminderPetVaccines;
  }

  bool attachmentMedicalOther = false;
  bool reminderMedicalOther = false;
  bool reminderPetVaccines = false;
  bool attachmentPetVaccines = false;
  bool iconAttachmentOther(Profile profile) {
    profile.userGeneralInfo.petsInfos[widget.index].otherInfo
        .forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalOther = true;
      }
    });
    return attachmentMedicalOther;
  }

  bool iconReminderOther(Profile profile) {
    profile.userGeneralInfo.petsInfos[widget.index].otherInfo
        .forEach((element) {
      if (element.reminders != null) {
        if (element.reminders.length != 0) {
          reminderMedicalOther = true;
        }
      }
    });
    return reminderMedicalOther;
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

  PopupMenuP menup;
  GlobalKey btnKeyp1 = GlobalKey();

  void onClickMenuP(MenuItemProviderP item) {
    if (item.type == "camera") {
      print("camera");
    } else if (item.type == "gallery") {
      print("gallary");
    } else
      print("file");
  }

  void maxColumnP() {
    PopupMenuP menup = PopupMenuP(
        backgroundColor: Colors.white,
        lineColor: ColorConstant.darkGray,
        maxColumn: 3,
        titre: "editprofil_general_subtitle_includephone".tr(),
        content:
            "Dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?",
        onClickMenu: onClickMenuP,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menup.showP(widgetKey: btnKeyp1);
  }

  getNamePetAndOwner(String name, String owner, String petType) {
    if (name != null && owner != null && petType != null) {
      return AutoSizeText(
          name != ''
              ? name +
                  "reminders_label_is".tr() +
                  '\n' +
                  owner +
                  "reminders_label_s".tr() +
                  petType
              : '',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 24,
              color: ColorConstant.textColor,
              fontWeight: FontWeight.w600));
    }
    if (name != null && petType != null && owner == null) {
      return AutoSizeText(
        name != ''
            ? name + ' ' + "reminders_label_is".tr() + ' ' + petType
            : '',
        textScaleFactor: 1.0,
        style: TextStyle(
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    if (name != null && petType == null && owner == null) {
      return AutoSizeText(name,
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 24,
              color: ColorConstant.textColor,
              fontWeight: FontWeight.w600));
    }
    if (name == null && petType == null && owner == null) {
      return AutoSizeText('',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 24,
              color: ColorConstant.textColor,
              fontWeight: FontWeight.w600));
    }
    if (name != null && petType == null && owner != null) {
      return AutoSizeText(name,
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 24,
              color: ColorConstant.textColor,
              fontWeight: FontWeight.w600));
    }
    if (name == null && petType != null && owner != null) {
      return AutoSizeText('',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 24,
              color: ColorConstant.textColor,
              fontWeight: FontWeight.w600));
    }
    if (name == null && petType == null && owner != null) {
      return AutoSizeText('',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 24,
              color: ColorConstant.textColor,
              fontWeight: FontWeight.w600));
    }
    if (name == null && petType != null && owner == null) {
      return AutoSizeText('',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 24,
              color: ColorConstant.textColor,
              fontWeight: FontWeight.w600));
    }
  }

  static final now = DateTime.now();

  DropdownDatePicker dropdownDatePicker;
  emergencyContactOwner(String idMember, Profile profile) {
    if (idMember == profile.userGeneralInfo.idMember) {
      setState(() {
        profile.userGeneralInfo.petsInfos[widget.index].emergencyContact =
            profile.userGeneralInfo.userEmergencyContact;
        profile.userGeneralInfo.petsInfos[widget.index].emergencyContact
            .forEach((element) {
          addBlockEmergency.add(false);
        });
      });
      nombrebolckAlsoContact = profile
          .userGeneralInfo.petsInfos[widget.index].emergencyContact.length;
    } else {
      profile.userGeneralInfo.subUsers.forEach((element) {
        if (element.userGeneralInfo.idMember == idMember) {
          profile.userGeneralInfo.petsInfos[widget.index].emergencyContact =
              element.userGeneralInfo.userEmergencyContact;
        }
      });
      nombrebolckAlsoContact = profile
          .userGeneralInfo.petsInfos[widget.index].emergencyContact.length;
      profile.userGeneralInfo.petsInfos[widget.index].emergencyContact
          .forEach((element) {
        addBlockEmergency.add(false);
      });
    }
  }
FocusNode focusNodeName =FocusNode();
  bool isMember = false;
  alsoContactOwner(String idMember, Profile profile) {
    if (idMember == profile.userGeneralInfo.idMember) {
      setState(() {
        profile.userGeneralInfo.petsInfos[widget.index].memberInfo.firstName =profile.userGeneralInfo.firstName;
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo
                .lastName = profile.userGeneralInfo.lastName;
        profile.userGeneralInfo.petsInfos[widget.index].memberInfo.mail =
            profile.userGeneralInfo.mail;
        profile.userGeneralInfo.petsInfos[widget.index].memberInfo.mail2 =
            profile.userGeneralInfo.mail2;
        profile.userGeneralInfo.petsInfos[widget.index].memberInfo.mobile =
            profile.userGeneralInfo.mobile;
        profile.userGeneralInfo.petsInfos[widget.index].memberInfo.codePhone =
            profile.userGeneralInfo.codePhone;
        profile
            .userGeneralInfo
            .petsInfos[widget.index]
            .preferencePet
            .allowLiveChat
            .value = profile.userGeneralInfo.preferenceUser.allowLiveChat.value;
        profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                .allowShareEmails.value =
            profile.userGeneralInfo.preferenceUser.allowShareEmails.value;
        profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                .allowSharePhone.value =
            profile.userGeneralInfo.preferenceUser.allowSharePhone.value;
        profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                .allowSharePicture.value =
            profile.userGeneralInfo.preferenceUser.allowSharePicture.value;
        profile
            .userGeneralInfo
            .petsInfos[widget.index]
            .preferencePet
            .includeMobile
            .value = profile.userGeneralInfo.preferenceUser.includeMobile.value;
        profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                .allowShareName.value =
            profile.userGeneralInfo.preferenceUser.allowShareName.value;
        profile
            .userGeneralInfo
            .petsInfos[widget.index]
            .preferencePet
            .includeMail1
            .value = profile.userGeneralInfo.preferenceUser.includeMail1.value;
        profile
            .userGeneralInfo
            .petsInfos[widget.index]
            .preferencePet
            .includeMail2
            .value = profile.userGeneralInfo.preferenceUser.includeMail2.value;
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
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo
                .firstName = profile.userGeneralInfo.firstName;
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo
                .lastName = profile.userGeneralInfo.lastName;
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo.mail =
                profile.userGeneralInfo.mail;
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo.mail2 =
                profile.userGeneralInfo.mail2;
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo.mobile =
                profile.userGeneralInfo.mobile;
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo
                .codePhone = profile.userGeneralInfo.codePhone;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .allowLiveChat.value =
                profile.userGeneralInfo.preferenceUser.allowLiveChat.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .allowShareEmails.value =
                profile.userGeneralInfo.preferenceUser.allowShareEmails.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .allowSharePhone.value =
                profile.userGeneralInfo.preferenceUser.allowSharePhone.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .allowSharePicture.value =
                profile.userGeneralInfo.preferenceUser.allowSharePicture.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .includeMobile.value =
                profile.userGeneralInfo.preferenceUser.includeMobile.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .allowShareName.value =
                profile.userGeneralInfo.preferenceUser.allowShareName.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .includeMail1.value =
                profile.userGeneralInfo.preferenceUser.includeMail1.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .includeMail2.value =
                profile.userGeneralInfo.preferenceUser.includeMail2.value;
          } else {
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo
                .firstName = element.userGeneralInfo.firstName;
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo
                .lastName = element.userGeneralInfo.lastName;
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo.mail =
                element.userGeneralInfo.mail;
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo.mail2 =
                element.userGeneralInfo.mail2;
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo.mobile =
                element.userGeneralInfo.mobile;
            profile.userGeneralInfo.petsInfos[widget.index].memberInfo
                .codePhone = element.userGeneralInfo.codePhone;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .allowLiveChat.value =
                element.userGeneralInfo.preferenceUser.allowLiveChat.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .allowShareEmails.value =
                element.userGeneralInfo.preferenceUser.allowShareEmails.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .allowSharePhone.value =
                element.userGeneralInfo.preferenceUser.allowSharePhone.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .allowSharePicture.value =
                element.userGeneralInfo.preferenceUser.allowSharePicture.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .includeMobile.value =
                element.userGeneralInfo.preferenceUser.includeMobile.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .allowShareName.value =
                element.userGeneralInfo.preferenceUser.allowShareName.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .includeMail1.value =
                element.userGeneralInfo.preferenceUser.includeMail1.value;
            profile.userGeneralInfo.petsInfos[widget.index].preferencePet
                    .includeMail2.value =
                element.userGeneralInfo.preferenceUser.includeMail2.value;
          }

          //  profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
          //     .tags[widget.index].preferenceUser.allowShareEmails.value =
          // element.userGeneralInfo.preferenceUser.allowShareEmails.value;
        }
      });
    }
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;
    int indexPet = widget.index;
    PopupMenuP.context = context;
    print('IdPet' +
        profile.userGeneralInfo.petsInfos[indexPet].generalInfo.idPet
            .toString());
    profile.userGeneralInfo.petsInfos[indexPet].generalInfo.active = 1;
    int convertMonth(String month) {
      if (month == '01') {
        return 01;
      }
      if (month == '02') {
        return 02;
      }
      if (month == '03') {
        return 03;
      }
      if (month == '04') {
        return 04;
      }
      if (month == '05') {
        return 05;
      }
      if (month == '06') {
        return 06;
      }
      if (month == '07') {
        return 07;
      }
      if (month == '08') {
        return 08;
      }
      if (month == '09') {
        return 09;
      }
      if (month == '10') {
        return 10;
      }
      if (month == '11') {
        return 11;
      }
      if (month == '12') {
        return 12;
      }
    }

    int convertDay(String day) {
      if (day == '01') {
        return 01;
      }
      if (day == '02') {
        return 02;
      }
      if (day == '03') {
        return 03;
      }
      if (day == '04') {
        return 04;
      }
      if (day == '05') {
        return 05;
      }
      if (day == '06') {
        return 06;
      }
      if (day == '07') {
        return 07;
      }
      if (day == '08') {
        return 08;
      }
      if (day == '09') {
        return 09;
      }
      if (day == '10') {
        return 10;
      }
      if (day == '11') {
        return 11;
      }
      if (day == '12') {
        return 12;
      }
      if (day == '13') {
        return 13;
      }
      if (day == '14') {
        return 14;
      }
      if (day == '15') {
        return 15;
      }
      if (day == '16') {
        return 16;
      }
      if (day == '17') {
        return 17;
      }
      if (day == '18') {
        return 18;
      }
      if (day == '19') {
        return 19;
      }
      if (day == '20') {
        return 20;
      }
      if (day == '21') {
        return 21;
      }
      if (day == '22') {
        return 22;
      }
      if (day == '23') {
        return 23;
      }
      if (day == '24') {
        return 24;
      }
      if (day == '25') {
        return 25;
      }
      if (day == '26') {
        return 26;
      }
      if (day == '27') {
        return 27;
      }
      if (day == '28') {
        return 28;
      }
      if (day == '29') {
        return 29;
      }
      if (day == '30') {
        return 30;
      }
      if (day == '31') {
        return 31;
      }
    }

    dropdownDatePicker = DropdownDatePicker(
      profile: profile,
      index: widget.index,
      initialDate: NullableValidDate(
          year: widget.profile.userGeneralInfo.petsInfos[widget.index]
              .generalInfo.birthInfo.year,
          month: convertMonth(widget.profile.userGeneralInfo
              .petsInfos[widget.index].generalInfo.birthInfo.month),
          day: convertDay(widget.profile.userGeneralInfo.petsInfos[widget.index]
              .generalInfo.birthInfo.day)),
      firstDate: ValidDate(year: now.year - 100, month: 1, day: 1),
      lastDate: ValidDate(year: now.year, month: now.month, day: now.day),
      dateHint: DateHint(
        year: "editprofil_medical_label_year".tr(),
        month: "editprofil_medical_label_month".tr(),
        day: "editprofil_medical_label_day".tr(),
      ),
      ascending: false,
    );

    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: NestedScrollView(
          floatHeaderSlivers: true,
          controller: _scrollController,
          //    physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, value) {
            return [
              SliverPersistentHeader(
                key: GlobalKey(),
                pinned: true,
                floating: true,
                delegate: CustomSliverDelegate(
                    hideTitleWhenExpanded: true,
                    expandedHeight: 165,
                    profile: profile,
                    indexPet: indexPet,
                    idMembers: idMembers,
                    loading: widget.loading
                    ),
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
                          _DescriptionObject(profile, indexPet),
                          SizedBox(
                            height: 16,
                          ),
                          _ObjectInfo(profile, indexPet),
                          SizedBox(height: 16),
                          _AdvancedSettings(profile, indexPet),
                          SizedBox(height: 17),
                          _PosterFound(profile, indexPet),
                          SizedBox(height: 39),
                          _editTag(profile, indexPet),
                          SizedBox(height: 17),
                          _deleteButton(profile, indexPet),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _DescriptionObject(Profile profile, int indexPet) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
            border:
                DescriptionObject || _DescriptionObjectStatus(profile, indexPet)
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
            color:
                DescriptionObject || _DescriptionObjectStatus(profile, indexPet)
                    ? ColorConstant.pinkColor
                    : ColorConstant.colorBlockVide,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: InkWell(
              onTap: () {
                setState(() {
                  DescriptionObject = !DescriptionObject;
                  _scrollController.jumpTo(0);
                  tagInformation = false;
                  gender = false;
                  height = false;
                  microchipedPet = false;
                  breedPet = false;
                  colorPet = false;
                  distinctiveSigns = false;
                  dob = false;
                  vaccin = false;
                  dietPet = false;
                  other = false;
                  AdvancedSettings = false;
                  ObjectInfo = false;
                  PosterFound = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: Image.asset(
                        "Assets/Images/iconPetInfo.png",
                        height: 32,
                        width: 31,
                        color: DescriptionObject ||
                                _DescriptionObjectStatus(profile, indexPet)
                            ? ColorConstant.whiteTextColor
                            : ColorConstant.textBlockVide,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                              value: "pets_label_petinformation".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: DescriptionObject ||
                                      _DescriptionObjectStatus(
                                          profile, indexPet)
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 12),
                        _Description(profile, indexPet),
                        SizedBox(height: 12),
                        _tagInformation(profile, indexPet),
                        SizedBox(height: 12),
                        _gender(profile, indexPet),
                        SizedBox(height: 12),
                        _heightAndWeight(profile, indexPet),
                        SizedBox(height: 12),
                        _microchipedPet(profile, indexPet),
                        SizedBox(height: 12),
                        _breedPet(profile, indexPet),
                        SizedBox(height: 12),
                        _colorPet(profile, indexPet),
                        SizedBox(height: 12),
                        _distinctiveSigns(profile, indexPet),
                        SizedBox(height: 12),
                        _dateOfBirth(profile, indexPet),
                        SizedBox(height: 12),
                        _vaccines(profile, indexPet),
                        SizedBox(height: 12),
                        _dietPet(profile, indexPet),
                        SizedBox(height: 12),
                        _other(profile, indexPet)
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _tagInformation(Profile profile, int indexPet) {
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
              color: tagInformation || _tagInformationStatus(profile, indexPet)
                  ? ColorConstant.pinkColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(tagInformation ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: GestureDetector(
            onTap: () {
              setState(() {
                tagInformation = !tagInformation;
                gender = false;
                height = false;
                microchipedPet = false;
                breedPet = false;
                colorPet = false;
                distinctiveSigns = false;
                dob = false;
                vaccin = false;
                dietPet = false;
                other = false;
              });
            },
            child: Container(
              height: 49.5,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(tagInformation ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 21),
                          child: Image.asset(
                            "Assets/Images/iconPetTags.png",
                            height: 24,
                            width: 32,
                            color: tagInformation ||
                                    _tagInformationStatus(profile, indexPet)
                                ? ColorConstant.pinkColor
                                : ColorConstant.darkGray,
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1, right: 5),
                            child: MyText(
                                value: "drawer_label_tags".tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: tagInformation ||
                                        _tagInformationStatus(profile, indexPet)
                                    ? ColorConstant.textColor
                                    : ColorConstant.darkGray),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                  tagInformation
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
          ),
        ),
        tagInformation
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 23),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 0.45, color: ColorConstant.dividerColor),
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.30)),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: profile.userGeneralInfo.petsInfos[indexPet]
                              .petTag.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                ListTile(
                                  leading: Container(
                                    child: Image.asset(
                                      "Assets/Images/iconTagsPet.png",
                                      height: 24,
                                      width: 32,
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      MyText(
                                          value: '#',
                                          fontSize: 24,
                                          color: ColorConstant.textColor,
                                          fontWeight: FontWeight.w600),
                                      MyText(
                                          value: profile
                                              .userGeneralInfo
                                              .petsInfos[indexPet]
                                              .petTag[index]
                                              .tagInfo
                                              .serialNumber,
                                          fontSize: 24,
                                          color: ColorConstant.textColor,
                                          fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  top: 13,
                                  child: Visibility(
                                    visible: visiTag,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
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
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            widget.profile.userGeneralInfo
                                                .update = true;

                                            profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .petTag[index]
                                                .tagInfo
                                                .archive = 1;
                                            profile.userGeneralInfo
                                                .petsInfos[indexPet].petTag
                                                .removeAt(index);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                              ],
                            );
                          },
                        ),
                        Container(
                            height: 0.45,
                            color: ColorConstant.dividerColor.withOpacity(.30)),
                        SizedBox(
                          height: 23.5,
                        ),
                        profile.userGeneralInfo.petsInfos[indexPet].petTag
                                    .length ==
                                0
                            ? MyButton(
                                title: "+ " + "homescree_info_addpettag".tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.pinkColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    BlocProvider.of<PetsBloc>(context).dispatch(
                                      GoToSerialNumberToPetTagEvent(
                                          profile: profile, index: indexPet),
                                    );
                                    visiTag = false;
                                  });
                                },
                              )
                            : Container(),
                        profile.userGeneralInfo.petsInfos[indexPet].petTag
                                    .length !=
                                0
                            ? Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: !visiTag,
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
                                            textColor: ColorConstant.pinkColor,
                                            child: MyText(
                                              value: "+ " +
                                                  "objecttag_btn_addnew".tr(),
                                              color: ColorConstant.pinkColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                BlocProvider.of<PetsBloc>(
                                                        context)
                                                    .dispatch(
                                                  GoToSerialNumberToPetTagEvent(
                                                      profile: profile,
                                                      index: indexPet),
                                                );
                                                visiTag = false;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                    visible: !visiTag,
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
                                                    "objecttag_btn_delete".tr(),
                                                color: ColorConstant.pinkColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  visiTag = !visiTag;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: visiTag,
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
                                            textColor: ColorConstant.pinkColor,
                                            child: MyText(
                                              value:
                                                  "editprofil_general_btn_done"
                                                      .tr(),
                                              color: ColorConstant.pinkColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                visiTag = !visiTag;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _gender(Profile profile, int indexPet) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              gender = !gender;
              tagInformation = false;
              height = false;
              microchipedPet = false;
              breedPet = false;
              colorPet = false;
              distinctiveSigns = false;
              dob = false;
              vaccin = false;
              dietPet = false;
              other = false;
            });
          },
          child: Container(
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
                color: gender || _genderStatus(profile, indexPet)
                    ? ColorConstant.pinkColor
                    : ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(gender ? 0 : 5.00),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(gender ? 0 : 5.0),
                ),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    gender = !gender;
                    tagInformation = false;
                    height = false;
                    microchipedPet = false;
                    breedPet = false;
                    colorPet = false;
                    distinctiveSigns = false;
                    dob = false;
                    vaccin = false;
                    dietPet = false;
                    other = false;
                  });
                },
                child: Container(
                  height: 49,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          bottomRight: Radius.circular(gender ? 0 : 5.0))),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 21),
                        child: Image.asset(
                          "Assets/Images/gender.png",
                          height: 24,
                          width: 32,
                          color: gender || _genderStatus(profile, indexPet)
                              ? ColorConstant.pinkColor
                              : ColorConstant.darkGray,
                        ),
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            Flexible(
                              child: MyText(
                                value: "pets_label_gender".tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color:
                                    gender || _genderStatus(profile, indexPet)
                                        ? ColorConstant.textColor
                                        : ColorConstant.darkGray,
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            gender
                                ? Image.asset(
                                    "Assets/Images/info.png",
                                    height: 14,
                                    width: 14,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),

                      gender
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
        gender
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor,
                        ),
                        SizedBox(
                          height: 12.5,
                        ),
                        profile.parameters.genderList != null
                            ? Container(
                                height: 24,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: ColorConstant.textfieldColor,
                                    items: profile.parameters.genderList
                                        .map((value) => DropdownMenuItem(
                                              child: MyText(
                                                value: value['gendre_label'],
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: ColorConstant.textColor,
                                              ),
                                              value: value,
                                            ))
                                        .toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        widget.profile.userGeneralInfo.update =
                                            true;
                                        genderData = newVal;

                                        profile
                                            .userGeneralInfo
                                            .petsInfos[indexPet]
                                            .generalInfo
                                            .idGender = newVal['id'];
                                      });
                                    },
                                    isExpanded: true,
                                    value: genderData,
                                    hint: MyText(
                                        value: profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .idGender !=
                                                null
                                            ? profile.parameters.genderList[
                                                profile
                                                        .userGeneralInfo
                                                        .petsInfos[indexPet]
                                                        .generalInfo
                                                        .idGender -
                                                    1]['gendre_label']
                                            : '',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.darkGray),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: ColorConstant.textfieldColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  // border: Border.all(style: BorderStyle.solid, width: 0.70),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 13,
                        ),
                      ],
                    ),
                  ),
                ))
            : Container(),
      ],
    );
  }

  _heightAndWeight(Profile profile, int indexPet) {
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
                color: height || _weightHeightStatus(profile, indexPet)
                    ? ColorConstant.pinkColor
                    : ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(height ? 0 : 5.0),
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0))),
            child: InkWell(
              onTap: () {
                setState(() {
                  height = !height;
                  tagInformation = false;
                  gender = false;
                  microchipedPet = false;
                  breedPet = false;
                  colorPet = false;
                  distinctiveSigns = false;
                  dob = false;
                  vaccin = false;
                  dietPet = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(height ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 21),
                      child: Image.asset(
                        "Assets/Images/iconPetWeight.png",
                        height: 24,
                        width: 32,
                        color: height || _weightHeightStatus(profile, indexPet)
                            ? ColorConstant.pinkColor
                            : ColorConstant.darkGray,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                              value: "pets_label_weight".tr() +
                                  ' ' +
                                  "pets_label_and".tr() +
                                  ' ' +
                                  "pets_label_height".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: height ||
                                      _weightHeightStatus(profile, indexPet)
                                  ? ColorConstant.textColor
                                  : ColorConstant.darkGray,
                            ),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          height
                              ? Image.asset(
                                  "Assets/Images/info.png",
                                  height: 14,
                                  width: 14,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    height
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
        height
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
                    bottomRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor,
                        ),
                        SizedBox(
                          height: 12.5,
                        ),
                        Container(
                          child: KeyboardActions(
                            autoScroll: false,
                            disableScroll: true,
                            config: KeyboardActionsConfig(
                                keyboardActionsPlatform:
                                    KeyboardActionsPlatform.ALL,
                                actions: [
                                  KeyboardActionsItem(focusNode: feetFocus),
                                  KeyboardActionsItem(focusNode: inchFocus),
                                  KeyboardActionsItem(focusNode: cmFocus),
                                ]),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      MyText(
                                          value: "pets_label_height".tr(),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                    .textScaleFactor
                                                    .clamp(1.0, 1.0),
                                          ),
                                          child: MyTextField(
                                            key: ValueKey(
                                              profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .generalInfo
                                                  .heightweight
                                                  .heightFt
                                                  .toString(),
                                            ),
                                            width: 35,
                                            keyboardType: TextInputType.number,
                                            focusNode: feetFocus,
                                            maxline: 1,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintTextColor: Colors.white54,
                                            initialValue: profile
                                                        .userGeneralInfo
                                                        .petsInfos[indexPet]
                                                        .generalInfo
                                                        .heightweight
                                                        .heightFt !=
                                                    null
                                                ? profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .heightweight
                                                    .heightFt
                                                    .toString()
                                                : '',
                                            onChanged: (value) {
                                              widget.profile.userGeneralInfo
                                                  .update = true;

                                              FocusScope.of(context)
                                                  .requestFocus(feetFocus);

                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .heightweight
                                                      .heightFt =
                                                  double.parse(value);
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .heightweight
                                                      .heightCm =
                                                  (double.parse(value) * 30.48);
                                            },
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, right: 10),
                                        child: MyText(
                                            value:
                                                "editprofil_medical_unit_heightft"
                                                    .tr(),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor),
                                      ),
                                      MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                    .textScaleFactor
                                                    .clamp(1.0, 1.0),
                                          ),
                                          child: MyTextField(
                                            key: ObjectKey(profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .heightweight
                                                .heightInch
                                                .toString()),
                                            width: 35,
                                            keyboardType: TextInputType.number,
                                            focusNode: inchFocus,
                                            maxline: 1,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintTextColor: Colors.white54,
                                            title: '',
                                            initialValue: profile
                                                        .userGeneralInfo
                                                        .petsInfos[indexPet]
                                                        .generalInfo
                                                        .heightweight
                                                        .heightInch !=
                                                    null
                                                ? profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .heightweight
                                                    .heightInch
                                                    .toString()
                                                : '',
                                            onChanged: (value) {
                                              widget.profile.userGeneralInfo
                                                  .update = true;

                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .heightweight
                                                      .heightInch =
                                                  double.parse(value);
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .heightweight
                                                      .heightCm =
                                                  (double.parse(value) * 2.54);
                                              FocusScope.of(context)
                                                  .requestFocus(inchFocus);
                                            },
                                            // textController: inchController,
                                          )),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      MyText(
                                          value:
                                              "editprofil_medical_unit_heightin"
                                                  .tr(),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                    .textScaleFactor
                                                    .clamp(1.0, 1.0),
                                          ),
                                          child: MyTextField(
                                            key: ObjectKey(profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .heightweight
                                                .heightCm
                                                .toString()),
                                            width: 44,
                                            keyboardType: TextInputType.number,
                                            focusNode: cmFocus,
                                            maxline: 1,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintTextColor: Colors.white54,
                                            title: '',
                                            // textController: cmController,
                                            initialValue: profile
                                                        .userGeneralInfo
                                                        .petsInfos[indexPet]
                                                        .generalInfo
                                                        .heightweight
                                                        .heightCm !=
                                                    null
                                                ? profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .heightweight
                                                    .heightCm
                                                    .toString()
                                                : '',
                                            onChanged: (value) {
                                              widget.profile.userGeneralInfo
                                                  .update = true;

                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .heightweight
                                                      .heightCm =
                                                  double.parse(value);

                                              double inc = profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .heightweight
                                                      .heightCm /
                                                  2.54;
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .heightweight
                                                      .heightFt =
                                                  (inc / 12).floorToDouble();
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .heightweight
                                                      .heightInch =
                                                  inc -
                                                      (12 *
                                                          profile
                                                              .userGeneralInfo
                                                              .petsInfos[
                                                                  indexPet]
                                                              .generalInfo
                                                              .heightweight
                                                              .heightFt);
                                              FocusScope.of(context)
                                                  .requestFocus(cmFocus);
                                            },
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                        ),
                                        child: MyText(
                                            value:
                                                "editprofil_medical_unit_heightcm"
                                                    .tr(),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(top: 12.5, bottom: 12.5),
                            child: Container(
                              height: 0.40,
                              color:
                                  ColorConstant.dividerColor.withOpacity(.30),
                            )),
                        Container(
                          child: KeyboardActions(
                            autoScroll: false,
                            disableScroll: true,
                            config: KeyboardActionsConfig(
                                keyboardActionsPlatform:
                                    KeyboardActionsPlatform.ALL,
                                actions: [
                                  KeyboardActionsItem(focusNode: lbsFocus),
                                  KeyboardActionsItem(focusNode: kgFocus),
                                ]),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      MyText(
                                          value:
                                              "editprofil_medical_label_weight"
                                                  .tr(),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                    .textScaleFactor
                                                    .clamp(1.0, 1.0),
                                          ),
                                          child: MyTextField(
                                            key: Key(profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .heightweight
                                                .weightLbs
                                                .toString()),
                                            width: 44,
                                            keyboardType: TextInputType.number,
                                            focusNode: lbsFocus,
                                            maxline: 1,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintTextColor: Colors.white54,
                                            title: '',
                                            // textController: lbsController,
                                            initialValue: profile
                                                        .userGeneralInfo
                                                        .petsInfos[indexPet]
                                                        .generalInfo
                                                        .heightweight
                                                        .weightLbs !=
                                                    null
                                                ? profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .heightweight
                                                    .weightLbs
                                                    .toString()
                                                : '',
                                            onChanged: (value) {
                                              widget.profile.userGeneralInfo
                                                  .update = true;

                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .heightweight
                                                      .weightLbs =
                                                  double.parse(value);
                                              double kg =
                                                  double.parse(value) * 0.4536;
                                              print(kg);

                                              profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .generalInfo
                                                  .heightweight
                                                  .weightKg = profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .heightweight
                                                      .weightLbs *
                                                  0.4536;
                                            },
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, right: 10),
                                        child: MyText(
                                            value:
                                                "editprofil_medical_unit_heightlbs"
                                                    .tr(),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                    .textScaleFactor
                                                    .clamp(1.0, 1.0),
                                          ),
                                          child: MyTextField(
                                            key: Key(profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .heightweight
                                                .weightKg
                                                .toString()),
                                            width: 44,
                                            keyboardType: TextInputType.number,
                                            focusNode: kgFocus,
                                            maxline: 1,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintTextColor: Colors.white54,
                                            title: '',
                                            // textController: kgController,
                                            initialValue: profile
                                                        .userGeneralInfo
                                                        .petsInfos[indexPet]
                                                        .generalInfo
                                                        .heightweight
                                                        .weightKg !=
                                                    null
                                                ? profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .heightweight
                                                    .weightKg
                                                    .toString()
                                                : '',
                                            onChanged: (value) {
                                              widget.profile.userGeneralInfo
                                                  .update = true;

                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .heightweight
                                                      .weightKg =
                                                  double.parse(value);
                                              double lbs =
                                                  double.parse(value) * 2.2046;

                                              profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .generalInfo
                                                  .heightweight
                                                  .weightLbs = lbs;
                                            },
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                        ),
                                        child: MyText(
                                            value:
                                                "editprofil_medical_unit_heightkg"
                                                    .tr(),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
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

  _distinctiveSigns(Profile profile, int indexPet) {
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
              color:
                  distinctiveSigns || _distinctiveSignsStatus(profile, indexPet)
                      ? ColorConstant.pinkColor
                      : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(distinctiveSigns ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  distinctiveSigns = !distinctiveSigns;
                  tagInformation = false;
                  gender = false;
                  height = false;
                  microchipedPet = false;
                  breedPet = false;
                  colorPet = false;
                  dob = false;
                  vaccin = false;
                  dietPet = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight:
                            Radius.circular(distinctiveSigns ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 22.5),
                      child: Image.asset(
                        "Assets/Images/distinctivePet.png",
                        height: 30.5,
                        width: 30.5,
                        color: distinctiveSigns ||
                                _distinctiveSignsStatus(profile, indexPet)
                            ? ColorConstant.pinkColor
                            : ColorConstant.darkGray,
                      ),
                    ),
                    MyText(
                        value: "editprofil_medical_subtitle_signs".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: distinctiveSigns ||
                                _distinctiveSignsStatus(profile, indexPet)
                            ? ColorConstant.textColor
                            : ColorConstant.darkGray),
                    SizedBox(
                      width: 17,
                    ),
                    Expanded(
                      child: distinctiveSigns
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                "Assets/Images/info.png",
                                height: 14,
                                width: 14,
                              ))
                          : Container(),
                    ),
                    distinctiveSigns
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
        distinctiveSigns
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
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
                          height: 13,
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
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                textScaleFactor: MediaQuery.of(context)
                                    .textScaleFactor
                                    .clamp(1.0, 1.0),
                              ),
                              child: MyTextField(
                                initialValue: profile
                                    .userGeneralInfo
                                    .petsInfos[indexPet]
                                    .generalInfo
                                    .distinctsSigns,

                                inputType: TextInputType.multiline,
//                                  textAlign: TextAlign.start,
                                focusNode: distinctiveSignsFocus,
                                editTextBgColor: ColorConstant.textfieldColor,
                                hintTextColor: Colors.white54,
                                title: '',
                                maxline: 5,
                                onChanged: (value) {
                                  setState(() {
                                    widget.profile.userGeneralInfo.update =
                                        true;

                                    profile.userGeneralInfo.petsInfos[indexPet]
                                        .generalInfo.distinctsSigns = value;
                                  });
                                },
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _dateOfBirth(Profile profile, int indexPet) {
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
              color: dob || _dateOfBirthStatus(profile, indexPet)
                  ? ColorConstant.pinkColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(dob ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
            onTap: () {
              setState(() {
                dob = !dob;
                tagInformation = false;
                gender = false;
                height = false;
                microchipedPet = false;
                breedPet = false;
                colorPet = false;
                distinctiveSigns = false;
                vaccin = false;
                dietPet = false;
                other = false;
              });
            },
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(dob ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 14.3, right: 26),
                    child: Image.asset(
                      "Assets/Images/birthPet.png",
                      height: 26,
                      width: 22.73,
                      color: dob || _dateOfBirthStatus(profile, indexPet)
                          ? ColorConstant.pinkColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                    value: "editprofil_medical_subtitle_birth".tr(),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: dob || _dateOfBirthStatus(profile, indexPet)
                        ? ColorConstant.textColor
                        : ColorConstant.darkGray,
                  ),
                  //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),
                  SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: dob
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              "Assets/Images/info.png",
                              height: 14,
                              width: 14,
                            ))
                        : Container(),
                  ),

                  dob
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
          ),
        ),
        dob
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor,
                        ),
                        SizedBox(
                          height: 12.5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: dropdownDatePicker,
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

  _microchipedPet(Profile profile, int indexPet) {
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
            color: microchipedPet || _microchipedPetStatus(profile, indexPet)
                ? ColorConstant.pinkColor
                : ColorConstant.boxColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(microchipedPet ? 0 : 5.0),
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                microchipedPet = !microchipedPet;
                tagInformation = false;
                gender = false;
                height = false;
                breedPet = false;
                colorPet = false;
                distinctiveSigns = false;
                dob = false;
                vaccin = false;
                dietPet = false;
                other = false;
              });
            },
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(microchipedPet ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 9.4, right: 21),
                    child: Image.asset(
                      "Assets/Images/iconMicrochiped.png",
                      height: 28.6,
                      width: 31.8,
                      color: microchipedPet ||
                              _microchipedPetStatus(profile, indexPet)
                          ? ColorConstant.pinkColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "pets_label_microchiped".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: microchipedPet ||
                              _microchipedPetStatus(profile, indexPet)
                          ? ColorConstant.textColor
                          : ColorConstant.darkGray),
                  SizedBox(
                    width: 19,
                  ),
                  Expanded(
                    child: microchipedPet
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              "Assets/Images/info.png",
                              height: 14,
                              width: 14,
                            ))
                        : Container(),
                  ),
                  microchipedPet
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
          ),
        ),
        microchipedPet
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor,
                        ),
                        SizedBox(
                          height: 12.5,
                        ),
                        MyText(
                            value: "pets_label_microchipnumber".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorConstant.textColor),
                        SizedBox(
                          height: 12,
                        ),
                        MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaleFactor: MediaQuery.of(context)
                                  .textScaleFactor
                                  .clamp(1.0, 1.0),
                            ),
                            child: MyTextField(
                              initialValue: profile
                                  .userGeneralInfo
                                  .petsInfos[indexPet]
                                  .generalInfo
                                  .microscopic
                                  .michrochipNumber,
                              focusNode: microchipFocus,
                              keyboardType: TextInputType.text,
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              title: '',
                              onChanged: (value) {
                                setState(() {
                                  widget.profile.userGeneralInfo.update = true;
                                  profile
                                      .userGeneralInfo
                                      .petsInfos[indexPet]
                                      .generalInfo
                                      .microscopic
                                      .michrochipNumber = value;
                                });
                              },
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        MyText(
                            value: "pets_label_microchipnumber".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorConstant.textColor),
                        SizedBox(
                          height: 12,
                        ),
                        MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaleFactor: MediaQuery.of(context)
                                  .textScaleFactor
                                  .clamp(1.0, 1.0),
                            ),
                            child: MyTextField(
                              initialValue: profile
                                  .userGeneralInfo
                                  .petsInfos[indexPet]
                                  .generalInfo
                                  .microscopic
                                  .note,
                              inputType: TextInputType.multiline,
                              focusNode: distinctiveSignsFocus,
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              title: '',
                              maxline: 3,
                              onChanged: (value) {
                                setState(() {
                                  widget.profile.userGeneralInfo.update = true;

                                  profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.microscopic.note = value;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _breedPet(Profile profile, int indexPet) {
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
            color: breedPet || _breedStatus(profile, indexPet)
                ? ColorConstant.pinkColor
                : ColorConstant.boxColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(breedPet ? 0 : 5.0),
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                breedPet = !breedPet;
                tagInformation = false;
                gender = false;
                height = false;
                microchipedPet = false;
                colorPet = false;
                distinctiveSigns = false;
                dob = false;
                vaccin = false;
                dietPet = false;
                other = false;
              });
            },
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(breedPet ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 9.4, right: 21),
                    child: Image.asset(
                      "Assets/Images/breedPet.png",
                      height: 28.6,
                      width: 31.8,
                      color: breedPet || _breedStatus(profile, indexPet)
                          ? ColorConstant.pinkColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "pets_label_breed".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: breedPet || _breedStatus(profile, indexPet)
                          ? ColorConstant.textColor
                          : ColorConstant.darkGray),
                  SizedBox(
                    width: 19,
                  ),
                  Expanded(
                    child: breedPet
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              "Assets/Images/info.png",
                              height: 14,
                              width: 14,
                            ))
                        : Container(),
                  ),
                  breedPet
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
          ),
        ),
        breedPet
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor,
                        ),
                        SizedBox(
                          height: 12.5,
                        ),
                        MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaleFactor: MediaQuery.of(context)
                                  .textScaleFactor
                                  .clamp(1.0, 1.0),
                            ),
                            child: MyTextField(
                              initialValue: profile.userGeneralInfo
                                  .petsInfos[indexPet].generalInfo.breed,
                              inputType: TextInputType.number,
                              //                                  textAlign: TextAlign.start,
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              title: '',
                              onChanged: (value) {
                                setState(() {
                                  widget.profile.userGeneralInfo.update = true;

                                  profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.breed = value;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _dietPet(Profile profile, int indexPet) {
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
              color: dietPet || _dietPetStatus(profile, indexPet)
                  ? ColorConstant.pinkColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(dietPet ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
            onTap: () {
              setState(() {
                dietPet = !dietPet;
                tagInformation = false;
                gender = false;
                height = false;
                microchipedPet = false;
                breedPet = false;
                colorPet = false;
                distinctiveSigns = false;
                dob = false;
                vaccin = false;
                other = false;
              });
            },
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(dietPet ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 9.4, right: 21),
                    child: Image.asset(
                      "Assets/Images/dietPet.png",
                      height: 28.6,
                      width: 31.8,
                      color: dietPet || _dietPetStatus(profile, indexPet)
                          ? ColorConstant.pinkColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "pets_label_diet".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: dietPet || _dietPetStatus(profile, indexPet)
                          ? ColorConstant.textColor
                          : ColorConstant.darkGray),
                  SizedBox(
                    width: 19,
                  ),
                  Expanded(
                    child: dietPet
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              "Assets/Images/info.png",
                              height: 14,
                              width: 14,
                            ))
                        : Container(),
                  ),
                  dietPet
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
          ),
        ),
        dietPet
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor,
                        ),
                        SizedBox(
                          height: 12.5,
                        ),
                        MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaleFactor: MediaQuery.of(context)
                                  .textScaleFactor
                                  .clamp(1.0, 1.0),
                            ),
                            child: MyTextField(
                              initialValue: profile.userGeneralInfo
                                  .petsInfos[indexPet].generalInfo.diet,
                              inputType: TextInputType.number,
                              //                                  textAlign: TextAlign.start,
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              title: '',
                              onChanged: (value) {
                                setState(() {
                                  widget.profile.userGeneralInfo.update = true;

                                  profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.diet = value;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _colorPet(Profile profile, int indexPet) {
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
              color: colorPet || _colorStatus(profile, indexPet)
                  ? ColorConstant.pinkColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(colorPet ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
            onTap: () {
              setState(() {
                colorPet = !colorPet;
                tagInformation = false;
                gender = false;
                height = false;
                microchipedPet = false;
                breedPet = false;
                distinctiveSigns = false;
                dob = false;
                vaccin = false;
                dietPet = false;
                other = false;
              });
            },
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(breedPet ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 9.4, right: 21),
                    child: Image.asset(
                      "Assets/Images/colorPet.png",
                      height: 28.6,
                      width: 31.8,
                      color: colorPet || _colorStatus(profile, indexPet)
                          ? ColorConstant.pinkColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "pets_label_color".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: colorPet || _colorStatus(profile, indexPet)
                          ? ColorConstant.textColor
                          : ColorConstant.darkGray),
                  SizedBox(
                    width: 19,
                  ),
                  Expanded(
                    child: colorPet
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              "Assets/Images/info.png",
                              height: 14,
                              width: 14,
                            ))
                        : Container(),
                  ),
                  colorPet
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
          ),
        ),
        colorPet
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor,
                        ),
                        SizedBox(
                          height: 12.5,
                        ),
                        MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaleFactor: MediaQuery.of(context)
                                  .textScaleFactor
                                  .clamp(1.0, 1.0),
                            ),
                            child: MyTextField(
                              initialValue: profile.userGeneralInfo
                                  .petsInfos[indexPet].generalInfo.color,
                              inputType: TextInputType.number,
                              //                                  textAlign: TextAlign.start,
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              title: '',
                              onChanged: (value) {
                                setState(() {
                                  widget.profile.userGeneralInfo.update = true;

                                  profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.color = value;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _alsoContact(Profile profile, int indexPet) {
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0, color: ColorConstant.boxColor),
                        color: ColorConstant.boxColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
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
                                  child: MyText(
                                      value: profile
                                          .userGeneralInfo
                                          .petsInfos[indexPet]
                                          .memberInfo
                                          .firstName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: ColorConstant.textColor)),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: MyText(
                                      value: profile
                                              .userGeneralInfo
                                              .petsInfos[indexPet]
                                              .memberInfo
                                              .lastName ??
                                          ' ',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: ColorConstant.textColor))
                            ]),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          MyText(
                              value: "pets_label_authorize".tr(),
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
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 8,
                                      child: MyText(
                                          value: profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .memberInfo
                                                  .mail ??
                                              '',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor)),
                                  Expanded(
                                    flex: 4,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .memberInfo
                                                      .mail ==
                                                  '' ||
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .memberInfo
                                                      .mail ==
                                                  null
                                          ? DiseableCustomSwitch(
                                              activeColor: Color(0xff34C759),
                                              value: false)
                                          : CustomSwitch(
                                              activeColor: Color(0xff34C759),
                                              value: profile
                                                          .userGeneralInfo
                                                          .petsInfos[indexPet]
                                                          .preferencePet
                                                          .includeMail1
                                                          .value ==
                                                      '1'
                                                  ? true
                                                  : false,
                                              onChanged: (value) {
                                                setState(() {
                                                  widget.profile.userGeneralInfo
                                                      .update = true;

                                                  profile
                                                          .userGeneralInfo
                                                          .petsInfos[indexPet]
                                                          .preferencePet
                                                          .includeMail1
                                                          .value =
                                                      value == true ? '1' : '0';
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
                              profile.userGeneralInfo.petsInfos[indexPet]
                                              .memberInfo.mail2 ==
                                          null ||
                                      profile
                                              .userGeneralInfo
                                              .petsInfos[indexPet]
                                              .memberInfo
                                              .mail2 ==
                                          ''
                                  ? Container()
                                  : Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 6,
                                            child: MyText(
                                                value: profile
                                                        .userGeneralInfo
                                                        .petsInfos[indexPet]
                                                        .memberInfo
                                                        .mail2 ??
                                                    '',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color:
                                                    ColorConstant.textColor)),
                                        Expanded(
                                          flex: 4,
                                          child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: profile
                                                              .userGeneralInfo
                                                              .petsInfos[
                                                                  indexPet]
                                                              .memberInfo
                                                              .mail2 ==
                                                          '' ||
                                                      profile
                                                              .userGeneralInfo
                                                              .petsInfos[
                                                                  indexPet]
                                                              .memberInfo
                                                              .mail2 ==
                                                          null
                                                  ? DiseableCustomSwitch(
                                                      activeColor:
                                                          Color(0xff34C759),
                                                      value: false)
                                                  : CustomSwitch(
                                                      activeColor:
                                                          Color(0xff34C759),
                                                      value: profile
                                                                  .userGeneralInfo
                                                                  .petsInfos[
                                                                      indexPet]
                                                                  .preferencePet
                                                                  .includeMail1
                                                                  .value ==
                                                              '1'
                                                          ? true
                                                          : false,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          widget
                                                              .profile
                                                              .userGeneralInfo
                                                              .update = true;

                                                          profile
                                                              .userGeneralInfo
                                                              .petsInfos[
                                                                  indexPet]
                                                              .preferencePet
                                                              .includeMail2
                                                              .value = value ==
                                                                  true
                                                              ? '1'
                                                              : '0';
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
                              (profile.userGeneralInfo.petsInfos[indexPet]
                                                  .memberInfo.mail ==
                                              '' ||
                                          profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .memberInfo
                                                  .mail ==
                                              null) &&
                                      (profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .memberInfo
                                                  .mail2 ==
                                              '' ||
                                          profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .memberInfo
                                                  .mail2 ==
                                              null)
                                  ? DiseableCustomSwitch(
                                      activeColor: Color(0xff34C759),
                                      value: false)
                                  : CustomSwitch(
                                      activeColor: Color(0xff34C759),
                                      value: profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .preferencePet
                                                  .allowLiveChat
                                                  .value ==
                                              '1'
                                          ? true
                                          : false,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.profile.userGeneralInfo
                                              .update = true;

                                          profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .preferencePet
                                                  .allowLiveChat
                                                  .value =
                                              value == true ? '1' : '0';
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
                          profile.userGeneralInfo.petsInfos[indexPet].memberInfo
                                          .mobile ==
                                      null ||
                                  profile.userGeneralInfo.petsInfos[indexPet]
                                          .memberInfo.mobile ==
                                      ""
                              ? Container()
                              : Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 6,
                                      child: MyText(
                                          value: "pets_label_mobilecellnumber"
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
                          profile.userGeneralInfo.petsInfos[indexPet].memberInfo
                                          .mobile ==
                                      null ||
                                  profile.userGeneralInfo.petsInfos[indexPet]
                                          .memberInfo.mobile ==
                                      ""
                              ? Container()
                              : Row(children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: MyText(
                                        value: profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .memberInfo
                                                .codePhone ??
                                            ' ',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorConstant.textColor,
                                      )),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: MyText(
                                          value: profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .memberInfo
                                                  .mobile ??
                                              ' ',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor)),
                                  SizedBox(
                                    width: 46,
                                  ),
                                  profile.userGeneralInfo.petsInfos[indexPet]
                                                  .memberInfo.mobile ==
                                              '' ||
                                          profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .memberInfo
                                                  .mobile ==
                                              null
                                      ? DiseableCustomSwitch(
                                          activeColor: Color(0xff34C759),
                                          value: false)
                                      : CustomSwitch(
                                          activeColor: Color(0xff34C759),
                                          value: profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .preferencePet
                                                      .includeMobile
                                                      .value ==
                                                  '1'
                                              ? true
                                              : false,
                                          onChanged: (value) {
                                            setState(() {
                                              widget.profile.userGeneralInfo
                                                  .update = true;

                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .preferencePet
                                                      .includeMobile
                                                      .value =
                                                  value == true ? '1' : '0';
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
                isMember  == true ||member==true
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
                              bottomRight: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                              topLeft: Radius.circular(8.0),
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0, color: ColorConstant.boxColor),
                              color: ColorConstant.boxColor,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8.0),
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
                                _includeEmail(profile, indexPet),
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
                                _includePhone(profile, indexPet),
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
                                _includeName(profile, indexPet),
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
                                _includePicture(profile, indexPet),
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0, color: ColorConstant.boxColor),
                        color: ColorConstant.boxColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
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
                          _emergencyContacts(profile, indexPet),
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

  _includePhone(Profile profile, int indexPet) {
    PopupMenu.context = context;
    return Column(
      children: <Widget>[
        Container(
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0))),
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
                CustomSwitch(
                  key: btnKeyp1,
                  activeColor: Color(0xff34C759),
                  value: profile.userGeneralInfo.petsInfos[indexPet]
                              .preferencePet.allowSharePhone.value ==
                          '1'
                      ? true
                      : false,
                  onChanged: (value) {
                    widget.profile.userGeneralInfo.update = true;
                    setState(() {
                      profile.userGeneralInfo.petsInfos[indexPet].preferencePet
                          .allowSharePhone.value = value == true ? '1' : '0';
                      if (!value) {
                        return maxColumnP();
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

  _includePicture(Profile profile, int indexPet) {
    return Column(
      children: <Widget>[
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: _switchIncludepic
                  ? ColorConstant.boxColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: Container(
            height: 49,
            decoration: BoxDecoration(
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0))),
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
                CustomSwitch(
                  activeColor: Color(0xff34C759),
                  value: profile.userGeneralInfo.petsInfos[indexPet]
                              .preferencePet.allowSharePicture.value ==
                          '1'
                      ? true
                      : false,
                  onChanged: (value) {
                    setState(() {
                      widget.profile.userGeneralInfo.update = true;

                      profile.userGeneralInfo.petsInfos[indexPet].preferencePet
                          .allowSharePicture.value = value == true ? '1' : '0';
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

  _includeName(Profile profile, int indexPet) {
    return Column(
      children: <Widget>[
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: _switchIncludename
                  ? ColorConstant.boxColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0))),
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
                CustomSwitch(
                  activeColor: Color(0xff34C759),
                  value: profile.userGeneralInfo.petsInfos[indexPet]
                              .preferencePet.allowShareName.value ==
                          '1'
                      ? true
                      : false,
                  onChanged: (value) {
                    setState(() {
                      widget.profile.userGeneralInfo.update = true;

                      profile.userGeneralInfo.petsInfos[indexPet].preferencePet
                          .allowShareName.value = value == true ? '1' : '0';
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

  _includeEmail(Profile profile, int indexPet) {
    return Column(
      children: <Widget>[
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: _switchIncludemail
                  ? ColorConstant.boxColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0))),
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
                              fontSize: 14,
                              color: ColorConstant.textColor),
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
                CustomSwitch(
                  activeColor: Color(0xff34C759),
                  value: profile.userGeneralInfo.petsInfos[indexPet]
                              .preferencePet.allowShareEmails.value ==
                          '1'
                      ? true
                      : false,
                  onChanged: (value) {
                    setState(() {
                      widget.profile.userGeneralInfo.update = true;

                      profile.userGeneralInfo.petsInfos[indexPet].preferencePet
                          .allowShareEmails.value = value == true ? '1' : '0';
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

  _emergencyContacts(Profile profile, int indexPet) {
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
                  itemCount: profile.userGeneralInfo.petsInfos[widget.index]
                      .emergencyContact.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(children: [
                      ExpandableEmergency(
                          key: Key(profile
                                  .userGeneralInfo
                                  .petsInfos[widget.index]
                                  .emergencyContact[index]
                                  .firstName ??
                              ''),
                          userEmergencyContactPet: profile.userGeneralInfo
                              .petsInfos[widget.index].emergencyContact[index],
                          addBlockEmergency: addBlockEmergency,
                          dropdownValue: profile.userGeneralInfo
                              .petsInfos[widget.index].emergencyContact[index].active==1?true:false,
                          visibile: _visibile,
                          profile: profile,
                          updated: widget.profile.userGeneralInfo.update,
                          index: index,
                          indexPet: indexPet),
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
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: RaisedButton(
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.white,
                                color: Colors.white,
                                textColor: ColorConstant.pinkColor,
                                child: MyText(
                                  value: "editprofil_general_btn_addnew".tr(),
                                  color: ColorConstant.pinkColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                onPressed: nombrebolckAlsoContact < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckAlsoContact++;
                                          for (int i = 0;
                                              i < addBlockEmergency.length;
                                              i++) {
                                            if (addBlockEmergency[i] == true) {
                                              addBlockEmergency[i] = false;
                                            }
                                          }

                                          addBlockEmergency.add(true);
                                          UserEmergencyContact alsoContPet =
                                              UserEmergencyContact(
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

                                          profile
                                              .userGeneralInfo
                                              .petsInfos[widget.index]
                                              .emergencyContact
                                              .add(alsoContPet);
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

  _Description(Profile profile, int indexPet) {
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
                bottomRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              )),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0, color: ColorConstant.boxColor),
                color: ColorConstant.boxColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(8.0))),
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
                      value: "reminders_label_petname".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: ColorConstant.textColor),
                  SizedBox(
                    height: 14.5,
                  ),
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: MediaQuery.of(context)
                          .textScaleFactor
                          .clamp(1.0, 1.0),
                    ),
                    child: MyTextField(
                      initialValue: profile
                          .userGeneralInfo.petsInfos[indexPet].generalInfo.name,
                      inputType: TextInputType.number,
                      //                                  textAlign: TextAlign.start,
                      focusNode: focusNodeName,
                      editTextBgColor: ColorConstant.textfieldColor,
                      hintTextColor: Colors.white54,
                      title: '',
                      onChanged: (value) {
                        setState(() {
                          widget.profile.userGeneralInfo.update = true;

                          profile.userGeneralInfo.petsInfos[indexPet]
                              .generalInfo.name = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 14.5,
                  ),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .name !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.name !=
                              ''
                      ? MyText(
                          value: "reminders_label_owner".tr() +
                              profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.name +
                              " " +
                              "reminders_label_is".tr(),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorConstant.textColor)
                      : MyText(
                          value: "reminders_label_ownerofpet".tr(),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorConstant.textColor,
                        ),
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
                                    value: e['firstName'],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.textColor),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (newVal) {
                          setState(() {
                            widget.profile.userGeneralInfo.update = true;

                            profile.userGeneralInfo.petsInfos[indexPet]
                                .generalInfo.idMember = newVal['idMember'];
                          });
                          emergencyContactOwner(newVal['idMember'], profile);
                          alsoContactOwner(newVal['idMember'], profile);
                        },
                        isExpanded: true,
                        hint: MyText(
                            value: profile.userGeneralInfo.petsInfos[indexPet]
                                        .generalInfo.idMember !=
                                    null
                                ? idMembers.firstWhere((element) =>
                                        element['idMember'] ==
                                        profile
                                            .userGeneralInfo
                                            .petsInfos[indexPet]
                                            .generalInfo
                                            .idMember)['firstName'] ??
                                    ' '
                                : ' ',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.textColor),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: ColorConstant.textfieldColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  SizedBox(
                    height: 14.5,
                  ),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .name !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.name !=
                              ''
                      ? MyText(
                          value: profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.name +
                              " " +
                              "reminders_label_isa".tr(),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorConstant.textColor)
                      : MyText(
                          value: "pets_label_petisa".tr(),
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
                        items: profile.parameters.petTypesList
                            .map(
                              (e) => DropdownMenuItem(
                                child: MyText(
                                    value: e['pet_type_label'],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.textColor),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (newVal) {
                          setState(() {
                            print(newVal['id']);
                            widget.profile.userGeneralInfo.update = true;

                            profile.userGeneralInfo.petsInfos[indexPet]
                                .generalInfo.idType = newVal['id'];
                          });
                        },
                        isExpanded: true,
                        value: ObjectData,
                        hint: MyText(
                            value: profile.userGeneralInfo.petsInfos[indexPet]
                                        .generalInfo.idType !=
                                    null
                                ? profile.parameters.petTypesList[profile
                                        .userGeneralInfo
                                        .petsInfos[indexPet]
                                        .generalInfo
                                        .idType -
                                    1]['pet_type_label']
                                : ' ',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.textColor),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: ColorConstant.textfieldColor,
                      borderRadius: BorderRadius.circular(8.0),
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

  _ObjectInfo(Profile profile, int indexPet) {
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
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _scrollController.jumpTo(0);

                  ObjectInfo = !ObjectInfo;
                  AdvancedSettings = false;
                  PosterFound = false;
                  DescriptionObject = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: Image.asset(
                        "Assets/Images/iconSettingPet.png",
                        height: 32,
                        width: 31,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                                value: "pets_label_ownercontact".tr(),
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
                      bottomRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 12),
                        _alsoContact(profile, indexPet),
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

  _thankyou(Profile profile, int indexPet) {
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
              color: thankyou || _thnakyouStatus(profile, indexPet)
                  ? ColorConstant.pinkColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(thankyou ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  thankyou = !thankyou;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(thankyou ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 12.5),
                    ),
                    MyText(
                        value: "editprofil_special_bloctitle_thankyoumsg".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: thankyou || _thnakyouStatus(profile, indexPet)
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
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
                            value: "pets_label_someonefinds".tr(),
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
                          child: MediaQuery(
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
                                      .petsInfos[indexPet]
                                      .generalInfo
                                      .thankYouMsg ??
                                  ' ',
                              maxLines: 2,
                              keyboardType: TextInputType.text,
                              focusNode: _thankYouFocus,
                              maxLength: 90,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 1.0, color: Colors.black),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  widget.profile.userGeneralInfo.update = true;

                                  profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.thankYouMsg = value;
                                });
                              },
                            ),
                          ),
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

  _viwExport(Profile profile, int indexPet) {
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
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0))),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0, color: ColorConstant.boxColor),
            color: ColorConstant.boxColor,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.0))),
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
                          value: "pets_label_viewexport".tr(),
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
                child: _petRecord(profile, indexPet),
              )
            ],
          ),
        ),
      ),
    );
  }

  _PosterFound(Profile profile, int indexPet) {
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
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: InkWell(
              onTap: () {
                setState(() {
                  _scrollController.jumpTo(180);

                  PosterFound = !PosterFound;
                  AdvancedSettings = false;
                  ObjectInfo = false;
                  DescriptionObject = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: Image.asset(
                        "Assets/Images/iconLostPet.png",
                        height: 32,
                        width: 31,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                              value: "pets_label_lostfound".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant.whiteTextColor,
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
                    bottomRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                ),
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
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _other(Profile profile, int indexPet) {
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
              color: other || _otherStatus(profile, indexPet)
                  ? ColorConstant.pinkColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(other ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  other = !other;
                  tagInformation = false;
                  gender = false;
                  height = false;
                  microchipedPet = false;
                  breedPet = false;
                  colorPet = false;
                  distinctiveSigns = false;
                  dob = false;
                  vaccin = false;
                  dietPet = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(other ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 14, right: 13),
                        child: Image.asset(
                          "Assets/Images/threedotB.png",
                          height: 6,
                          width: 24,
                          color: other || _otherStatus(profile, indexPet)
                              ? ColorConstant.pinkColor
                              : ColorConstant.darkGray,
                        ) /**/
                        // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                        ),
                    Expanded(
                      child: MyText(
                          value: "pets_label_otherinfo".tr(),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: other || _otherStatus(profile, indexPet)
                              ? ColorConstant.textColor
                              : ColorConstant.darkGray),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    iconAttachmentOther(profile) == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderOther(profile) == true
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 6.3, right: 11.3),
                            child: Image.asset(
                              "Assets/Images/alarm.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    other
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
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
                          itemCount: profile.userGeneralInfo.petsInfos[indexPet]
                              .otherInfo.length,
                          padding: EdgeInsets.zero,
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.30)),
                          itemBuilder: (BuildContext context, int index) {
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
                                                    widget
                                                        .profile
                                                        .userGeneralInfo
                                                        .update = true;

                                                    profile
                                                        .userGeneralInfo
                                                        .petsInfos[widget.index]
                                                        .otherInfo
                                                        .removeAt(index);
                                                    nombrebolckOther = profile
                                                        .userGeneralInfo
                                                        .petsInfos[widget.index]
                                                        .otherInfo
                                                        .length;
                                                          if (profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .otherInfo
                                                      .length ==
                                                  0) {
                                                _visiOther = true;
                                              }
                                                        
                                                  });
                                                 
                                        
                                                })),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new ExpandableOtherList(
                                    profile: profile,
                                    index: index,
                                    indexPet: indexPet,
                                    other: profile.userGeneralInfo
                                        .petsInfos[indexPet].otherInfo[index],
                                    title: profile
                                        .userGeneralInfo
                                        .petsInfos[indexPet]
                                        .otherInfo[index]
                                        .label,
                                    addBlockOther: addBlockOther,
                                    updated:
                                        widget.profile.userGeneralInfo.update,
                                    desc: profile
                                        .userGeneralInfo
                                        .petsInfos[indexPet]
                                        .otherInfo[index]
                                        .description,
                                    attachments: profile
                                        .userGeneralInfo
                                        .petsInfos[indexPet]
                                        .otherInfo[index]
                                        .documents,
                                    reminders: profile
                                        .userGeneralInfo
                                        .petsInfos[indexPet]
                                        .otherInfo[index]
                                        .reminders,
                                    switchValue: profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .otherInfo[index]
                                                .active ==
                                            1
                                        ? true
                                        : false,
                                    visibilite: _visiOther,
                                  ),
                                ),
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
                        profile.userGeneralInfo.petsInfos[indexPet].otherInfo
                                    .length ==
                                0
                            ? MyButton(
                                title: "+ " + "pets_label_newother".tr(),
                                height: 36.0,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.pinkColor,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckOther < nbblock
                                    ? () {
                                        setState(() {
                                          widget.profile.userGeneralInfo
                                              .update = true;

                                          nombrebolckOther++;

                                          addBlockOther.add(true);
                                          OtherInfo otherInfo = OtherInfo(
                                              allow: 1,
                                              active: 1,
                                              description: "",
                                              id: null,
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          profile.userGeneralInfo
                                              .petsInfos[indexPet].otherInfo
                                              .add(otherInfo);
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
                                        child: ButtonTheme(
                                          height: 36.0,
                                          minWidth: 133.5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: RaisedButton(
                                            disabledColor: Colors.grey,
                                            disabledTextColor: Colors.white,
                                            color: Colors.white,
                                            textColor: ColorConstant.pinkColor,
                                            child: MyText(
                                              value:
                                                  "editprofil_general_btn_addnew"
                                                      .tr(),
                                              color: ColorConstant.pinkColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            onPressed: nombrebolckOther <
                                                    nbblock
                                                ? () {
                                                    setState(() {
                                                      widget
                                                          .profile
                                                          .userGeneralInfo
                                                          .update = true;

                                                      for (int i = 0;
                                                          i <
                                                              addBlockOther
                                                                  .length;
                                                          i++) {
                                                        if (addBlockOther[i] ==
                                                            true) {
                                                          addBlockOther[i] =
                                                              false;
                                                        }
                                                      }

                                                      addBlockOther.add(true);
                                                      nombrebolckOther++;
                                                      OtherInfo otherInfo =
                                                          OtherInfo(
                                                              allow: 1,
                                                              active: 1,
                                                              description: "",
                                                              label: '',
                                                              documents: [],
                                                              reminders: []);
                                                      profile
                                                          .userGeneralInfo
                                                          .petsInfos[indexPet]
                                                          .otherInfo
                                                          .add(otherInfo);
                                                    });
                                                  }
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                                    "editprofil_general_btn_delete"
                                                        .tr(),
                                                color: ColorConstant.pinkColor,
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
                                            textColor: ColorConstant.pinkColor,
                                            child: MyText(
                                              value:
                                                  "editprofil_general_btn_done"
                                                      .tr(),
                                              color: ColorConstant.pinkColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _visiOther = !_visiOther;
                                              });
                                            },
                                          ),
                                        ),
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

  _vaccines(Profile profile, int indexPet) {
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
            color: vaccin || _vaccinesStatus(profile, indexPet)
                ? ColorConstant.pinkColor
                : ColorConstant.boxColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(vaccin ? 0 : 5.0),
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                vaccin = !vaccin;
                tagInformation = false;
                gender = false;
                height = false;
                microchipedPet = false;
                breedPet = false;
                colorPet = false;
                distinctiveSigns = false;
                dob = false;
                dietPet = false;
                other = false;
              });
            },
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(vaccin ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 9.4, right: 21),
                    child: Image.asset(
                      "Assets/Images/vaccinPet.png",
                      height: 28.6,
                      width: 31.8,
                      color: vaccin || _vaccinesStatus(profile, indexPet)
                          ? ColorConstant.pinkColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  Expanded(
                    child: MyText(
                        value: "pets_label_vaccines".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: vaccin || _vaccinesStatus(profile, indexPet)
                            ? ColorConstant.textColor
                            : ColorConstant.darkGray),
                  ),
                  SizedBox(
                    width: 19,
                  ),
                  iconAttachmentVaccine() == true
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Image.asset(
                            "Assets/Images/attachment-green.png",
                            height: 16,
                            width: 16,
                          ),
                        )
                      : Container(),
                  iconReminderVaccine() == true
                      ? Padding(
                          padding: const EdgeInsets.only(right: 11.3),
                          child: Image.asset(
                            "Assets/Images/alarm.png",
                            height: 16,
                            width: 16,
                          ),
                        )
                      : Container(),
                  vaccin
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
          ),
        ),
        vaccin
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
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 0.45, color: ColorConstant.dividerColor),
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.30)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: profile.userGeneralInfo.petsInfos[indexPet]
                              .vaccins.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visiVaccin,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
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
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              widget.profile.userGeneralInfo
                                                  .update = true;

                                              profile.userGeneralInfo
                                                  .petsInfos[indexPet].vaccins
                                                  .removeAt(index);

                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                              nombrebolckVaccines = profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .vaccins
                                                  .length;
                                              if (profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .vaccins
                                                      .length ==
                                                  0) {
                                                _visiVaccin = true;
                                              }
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              ExpandableListView(
                                  profile: profile,
                                  index: index,
                                  indexPet: indexPet,
                                  type: 'vaccin',
                                  addBlockVaccin: addBlockVaccin,
                                  vaccinPets: profile.userGeneralInfo
                                      .petsInfos[indexPet].vaccins[index],
                                  title: profile.userGeneralInfo
                                      .petsInfos[indexPet].vaccins[index].label,
                                  updated: profile.userGeneralInfo.update,
                                  desc: profile
                                      .userGeneralInfo
                                      .petsInfos[indexPet]
                                      .vaccins[index]
                                      .description,
                                  attachment: profile
                                              .userGeneralInfo
                                              .petsInfos[indexPet]
                                              .vaccins[index]
                                              .documents
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  documents: profile
                                      .userGeneralInfo
                                      .petsInfos[indexPet]
                                      .vaccins[index]
                                      .documents,
                                  alarm: profile
                                              .userGeneralInfo
                                              .petsInfos[indexPet]
                                              .vaccins[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders: profile
                                      .userGeneralInfo
                                      .petsInfos[indexPet]
                                      .vaccins[index]
                                      .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: !_visiVaccin),
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
                        profile.userGeneralInfo.petsInfos[indexPet].vaccins
                                    .length ==
                                0
                            ? MyButton(
                                title: "+ " + "pets_label_addnewvaccine".tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.pinkColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckVaccines < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckVaccines++;
                                          widget.profile.userGeneralInfo
                                              .update = true;

                                          addBlockVaccin.add(true);
                                          Vaccins vaccin = Vaccins(
                                              allow: 1,
                                              active: 1,
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          profile.userGeneralInfo
                                              .petsInfos[indexPet].vaccins
                                              .add(vaccin);
                                          nombrebolckVaccines = profile
                                              .userGeneralInfo
                                              .petsInfos[indexPet]
                                              .vaccins
                                              .length;
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiVaccin,
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
                                                value: "+ " +
                                                    "editprofil_medical_btn_addnew"
                                                        .tr(),
                                                color: ColorConstant.pinkColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              onPressed: nombrebolckVaccines <
                                                      nbblock
                                                  ? () {
                                                      setState(() {
                                                        widget
                                                            .profile
                                                            .userGeneralInfo
                                                            .update = true;

                                                        nombrebolckVaccines++;
                                                        for (int i = 0;
                                                            i <
                                                                addBlockVaccin
                                                                    .length;
                                                            i++) {
                                                          if (addBlockVaccin[
                                                                  i] ==
                                                              true) {
                                                            addBlockVaccin[i] =
                                                                false;
                                                          }
                                                        }

                                                        addBlockVaccin
                                                            .add(true);
                                                        Vaccins vaccin =
                                                            Vaccins(
                                                                allow: 1,
                                                                active: 1,
                                                                description: '',
                                                                label: '',
                                                                documents: [],
                                                                reminders: []);
                                                        profile
                                                            .userGeneralInfo
                                                            .petsInfos[indexPet]
                                                            .vaccins
                                                            .add(vaccin);
                                                      });
                                                    }
                                                  : null,
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                      visible: _visiVaccin,
                                      child: Expanded(
                                          flex: 5,
                                          child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: ButtonTheme(
                                                height: 36.0,
                                                minWidth: 280.5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: RaisedButton(
                                                  disabledColor: Colors.grey,
                                                  disabledTextColor:
                                                      Colors.white,
                                                  color: Colors.white,
                                                  textColor:
                                                      ColorConstant.pinkColor,
                                                  child: MyText(
                                                    value:
                                                        "editprofil_medical_btn_delete"
                                                            .tr(),
                                                    color:
                                                        ColorConstant.pinkColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _visiVaccin = false;
                                                    });
                                                  },
                                                ),
                                              )))),
                                  Visibility(
                                    visible: !_visiVaccin,
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
                                                      "editprofil_general_btn_done"
                                                          .tr(),
                                                  color:
                                                      ColorConstant.pinkColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiVaccin = !_visiVaccin;
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

  static showOverlayUpdate(
    BuildContext context,
    String headerMessage,
    String message,
    int index,
    Profile profile,
  ) {
    Navigator.of(context).push(AlertDialogueUpdate(
      context,
      headerMessage,
      message,
      index,
      profile,
    ));
  }

  _petRecord(Profile profile, int indexPet) {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (profile.userGeneralInfo.update == false) {
                      dispatchViewPet(profile, indexPet);
                    } else {
                      showOverlayUpdate(
                        context,
                        "messages_label_confirmationleave".tr(),
                        "messages_label_confirmationdesc".tr(),
                        indexPet,
                        profile,
                      );
                    }
                    _viewRecord = !_viewRecord;
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
                        color: _viewRecord
                            ? ColorConstant.pinkColor
                            : ColorConstant.whiteTextColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          "Assets/Images/view-red.png",
                          color: _viewRecord
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
                      value: "pets_label_viewpet".tr(),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.textColor,
                    ),
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
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                        color: _printRecord
                            ? ColorConstant.pinkColor
                            : ColorConstant.whiteTextColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
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
                      value: "editprofil_medical_btn_print".tr(),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.textColor,
                    )
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
                            offset: Offset(0, 0),
                          ),
                        ],
                        color: _emailRecord
                            ? ColorConstant.pinkColor
                            : ColorConstant.whiteTextColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
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
                        value: "editprofil_medical_btn_email".tr(),
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
                bottomRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              )),
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0, color: ColorConstant.boxColor),
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8.0),
                ),
              ),
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
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _viewPoster = !_viewPoster;
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
                                              offset: Offset(0, 0),
                                            ),
                                          ],
                                          color: _viewPoster
                                              ? ColorConstant.pinkColor
                                              : ColorConstant.whiteTextColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Center(
                                        child: InkWell(
                                          child: Image.asset(
                                            "Assets/Images/iconViewPet.png",
                                            color: _viewPoster
                                                ? Colors.white
                                                : ColorConstant.pinkColor,
                                            height: 21,
                                            width: 24.85,
                                          ),
                                          onTap: () {
                                            //  dispatchViewTag(profile,index) ;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    MyText(
                                      value: "objecttag_btn_view".tr(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.textColor,
                                    ),
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
                                    _printPoster = !_printPoster;
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
                                        color: _printPoster
                                            ? ColorConstant.pinkColor
                                            : ColorConstant.whiteTextColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "Assets/Images/print-red.png",
                                          color: _printPoster
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
                                      color: ColorConstant.textColor,
                                    )
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
                                    _emailPoster = !_emailPoster;
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
                                        color: _emailPoster
                                            ? ColorConstant.pinkColor
                                            : ColorConstant.whiteTextColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "Assets/Images/email-red.png",
                                          color: _emailPoster
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
                                      color: ColorConstant.textColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ]))))
    ]);
  }

  _AdvancedSettings(Profile profile, int indexPet) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              border: AdvancedSettings || _thnakyouStatus(profile, indexPet)
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
              color: AdvancedSettings || _thnakyouStatus(profile, indexPet)
                  ? ColorConstant.pinkColor
                  : ColorConstant.colorBlockVide,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _scrollController.jumpTo(190);

                  AdvancedSettings = !AdvancedSettings;
                  ObjectInfo = false;
                  PosterFound = false;
                  DescriptionObject = false;
                  thankyou = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: Image.asset(
                        "Assets/Images/settings.png",
                        height: 32,
                        width: 31,
                        color: AdvancedSettings ||
                                _thnakyouStatus(profile, indexPet)
                            ? ColorConstant.whiteTextColor
                            : ColorConstant.textBlockVide,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                              value: "pets_label_settings".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AdvancedSettings ||
                                      _thnakyouStatus(profile, indexPet)
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
                    bottomRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                ),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 12),
                        _thankyou(profile, indexPet),
                        SizedBox(height: 12),
                        SizedBox(height: 12),
                        _viwExport(profile, indexPet),
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

  void dispatchUploadFile(Profile profile, int indexPet) {
    BlocProvider.of<PetsBloc>(context).dispatch(
      UploadFilePetEvent(profile: profile, index: indexPet),
    );
  }

  static showOverlay(
      BuildContext context, String headerMessage, String message) {
    Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  String message;
  bool checkerFirstName = true;
  bool checkerEmail1 = true;
  bool checkerEmail2 = true;
  bool checkerTel = true;
  int i;
  _editTag(Profile profile, int indexPet) {
    return MyButton(
      title: button == null ? "pets_label_save".tr() : "pets_label_save".tr(),
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
        i = 0;
        checkerEmail2 = true;
        checkerTel = true;
        for (int j = 0; j < 5; j++) {
          if (profile.userGeneralInfo.petsInfos[indexPet].emergencyContact !=
                  null &&
              profile.userGeneralInfo.petsInfos[indexPet].emergencyContact
                      .length !=
                  0) {
            i = 0;
            while (i <
                profile.userGeneralInfo.petsInfos[indexPet].emergencyContact
                    .length) {
              if (profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].firstName ==
                      '' &&
                  profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].lastName ==
                      '' &&
                  profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].mail ==
                      '' &&
                  profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].mail2 ==
                      '' &&
                  profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].mobile ==
                      '') {
                nombrebolckAlsoContact--;
                profile.userGeneralInfo.petsInfos[indexPet].emergencyContact
                    .removeAt(i);
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.petsInfos[indexPet].emergencyContact
                    .length) {
              if (profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].firstName !=
                      null &&
                  profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].firstName !=
                      '') {
                if (regExpName.hasMatch(profile.userGeneralInfo
                        .petsInfos[indexPet].emergencyContact[i].firstName) !=
                    true) {
                  checkerFirstName = false;
                  message =
                      "pets_label_nameemergencycontact".tr() + ' ${i + 1}';
                }
              }
              if (profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].mail ==
                      null ||
                  profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].mail ==
                      '') {
                checkerEmail1 = false;
                message =
                    "pets_label_primarymailemergencycontact".tr() + ' ${i + 1}';
              } else {
                if (regExpEmail.hasMatch(profile.userGeneralInfo
                        .petsInfos[indexPet].emergencyContact[i].mail) !=
                    true) {
                  checkerEmail1 = false;
                  message = "pets_label_primarymailemergencycontact".tr() +
                      ' ${i + 1}';
                }
              }

              if (profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].mail2 !=
                      null &&
                  profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].mail2 !=
                      '') {
                if (regExpEmail.hasMatch(profile.userGeneralInfo
                        .petsInfos[indexPet].emergencyContact[i].mail2) !=
                    true) {
                  checkerEmail2 = false;
                  message = "pets_label_secondarymailemergencycontact".tr() +
                      ' ${i + 1}';
                }
              }

              if (profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].mobile !=
                      null &&
                  profile.userGeneralInfo.petsInfos[indexPet]
                          .emergencyContact[i].mobile !=
                      '') {
                if (regExpNumber.hasMatch(profile.userGeneralInfo
                        .petsInfos[indexPet].emergencyContact[i].mobile) !=
                    true) {
                  checkerTel = false;
                  message =
                      "pets_label_phoneemergencycontact".tr() + ' ${i + 1}';
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.petsInfos[indexPet].vaccins.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.petsInfos[indexPet].vaccins.length) {
              if (profile.userGeneralInfo.petsInfos[indexPet].vaccins[i]
                          .label ==
                      '' &&
                  profile.userGeneralInfo.petsInfos[indexPet].vaccins[i]
                          .description ==
                      '' &&
                  profile.userGeneralInfo.petsInfos[indexPet].vaccins[i]
                          .documents.length ==
                      0 &&
                  profile.userGeneralInfo.petsInfos[indexPet].vaccins[i]
                          .reminders.length ==
                      0) {
                profile.userGeneralInfo.petsInfos[indexPet].vaccins.removeAt(i);
                nombrebolckVaccines--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.petsInfos[indexPet].vaccins.length) {
              if (profile.userGeneralInfo.petsInfos[indexPet].vaccins[i]
                          .label ==
                      null ||
                  profile.userGeneralInfo.petsInfos[indexPet].vaccins[i]
                          .label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namevaccine".tr() + ' ${i + 1}';
              } else {
                if (regExpName.hasMatch(profile.userGeneralInfo
                        .petsInfos[indexPet].vaccins[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namevaccineinfo".tr() + ' ${i + 1}';
                }
              }

              i++;
            }
          }
          if (profile
              .userGeneralInfo.petsInfos[indexPet].otherInfo.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.petsInfos[indexPet].otherInfo.length) {
              if (profile.userGeneralInfo.petsInfos[indexPet].otherInfo[i]
                          .label ==
                      '' &&
                  profile.userGeneralInfo.petsInfos[indexPet].otherInfo[i]
                          .description ==
                      '' &&
                  profile.userGeneralInfo.petsInfos[indexPet].otherInfo[i]
                          .documents.length ==
                      0 &&
                  profile.userGeneralInfo.petsInfos[indexPet].otherInfo[i]
                          .reminders.length ==
                      0) {
                profile.userGeneralInfo.petsInfos[indexPet].otherInfo
                    .removeAt(i);
                nombrebolckVaccines--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.petsInfos[indexPet].otherInfo.length) {
              if (profile.userGeneralInfo.petsInfos[indexPet].otherInfo[i]
                          .label ==
                      null ||
                  profile.userGeneralInfo.petsInfos[indexPet].otherInfo[i]
                          .label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameotherinfo".tr() + ' ${i + 1}';
              } else {
                if (regExpName.hasMatch(profile.userGeneralInfo
                        .petsInfos[indexPet].otherInfo[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameotherinfo".tr() + ' ${i + 1}';
                }
              }
              i++;
            }
          }
        }
        profile.userGeneralInfo.petsInfos[indexPet].generalInfo.name == null ||
                profile.userGeneralInfo.petsInfos[indexPet].generalInfo.name ==
                    ''
            ? _validateName = false
            : _validateName = true;
        profile.userGeneralInfo.petsInfos[indexPet].generalInfo.idMember ==
                    null ||
                profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                        .idMember ==
                    ''
            ? _validateOwner = false
            : _validateOwner = true;
        profile.userGeneralInfo.petsInfos[indexPet].generalInfo.idType == null
            ? _validateType = false
            : _validateType = true;
        if (_validateName == true &&
            _validateType == true &&
            _validateOwner == true &&
            checkerFirstName == true &&
            checkerEmail1 == true &&
            checkerEmail2 == true) {
          profile.userGeneralInfo.update = false;
          profile.parameters.newPet = false;
          dispatchAddEditPet(profile, indexPet);
        }
        if (_validateName == false) {
          Future.delayed(
            Duration.zero,
            () => showOverlay(
              context,
              "problem_infos".tr(),
              "pets_label_namerequired".tr(),
            ),
          );
        } else if (_validateOwner == false) {
          Future.delayed(
            Duration.zero,
            () => showOverlay(
              context,
              "problem_infos".tr(),
              "pets_label_ownerrequired".tr(),
            ),
          );
        } else if (_validateType == false) {
          Future.delayed(
            Duration.zero,
            () => showOverlay(
              context,
              "problem_infos".tr(),
              "pets_label_typerequired".tr(),
            ),
          );
        } else if (checkerFirstName == false) {
          Future.delayed(
            Duration.zero,
            () => showOverlay(context, "problem_infos".tr(), message),
          );
        } else if (checkerEmail1 == false) {
          Future.delayed(
            Duration.zero,
            () => showOverlay(context, "problem_infos".tr(), message),
          );
        } else if (checkerEmail2 == false) {
          Future.delayed(
            Duration.zero,
            () => showOverlay(context, "problem_infos".tr(), message),
          );
        }
      },
    );
  }

  dispatchAddEditPet(profile, int indexPet) {
    BlocProvider.of<PetsBloc>(context).dispatch(
      GoToEditProfilePetEvent(profile: profile, index: indexPet),
    );
  }

  dispatchViewPet(profile, int indexPet) {
    BlocProvider.of<PetsBloc>(context).dispatch(
      GoToViewProfilePetEvent(profile: profile, index: indexPet),
    );
  }

  void dispatchGoToHelp(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/helpProvider',
      arguments: profile,
    );
  }

  _deleteButton(Profile profile, int indexPet) {
    return MyButton(
      title: "objecttag_btn_delete".tr(),
      height: 46.0,
      titleSize: 14,
      cornerRadius: 8,
      fontWeight: FontWeight.w600,
      titleColor: Color(0xffEC1C40),
      btnBgColor: ColorConstant.boxColor,
      onPressed: () {
        setState(() {
          profile.userGeneralInfo.petsInfos[indexPet].generalInfo.delete = 1;
        });
        BlocProvider.of<PetsBloc>(context).dispatch(
          GoToEditProfilePetEvent(profile: profile, index: indexPet),
        );
      },
    );
  }

  bool _genderStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.petsInfos[index].generalInfo.idGender != null) {
      return true;
    }
    return false;
  }

  bool _weightHeightStatus(Profile profile, int index) {
    if ((profile.userGeneralInfo.petsInfos[index].generalInfo.heightweight.heightFt != 0 &&
            profile.userGeneralInfo.petsInfos[index].generalInfo.heightweight
                    .heightFt !=
                null) ||
        (profile.userGeneralInfo.petsInfos[index].generalInfo.heightweight
                    .heightInch !=
                0 &&
            profile.userGeneralInfo.petsInfos[index].generalInfo.heightweight
                    .heightInch !=
                null) ||
        (profile.userGeneralInfo.petsInfos[index].generalInfo.heightweight.heightCm !=
                0 &&
            profile.userGeneralInfo.petsInfos[index].generalInfo.heightweight
                    .heightCm !=
                null) ||
        (profile.userGeneralInfo.petsInfos[index].generalInfo.heightweight
                    .weightLbs !=
                0 &&
            profile.userGeneralInfo.petsInfos[index].generalInfo.heightweight
                    .weightLbs !=
                null) ||
        (profile.userGeneralInfo.petsInfos[index].generalInfo.heightweight
                    .weightKg !=
                0 &&
            profile.userGeneralInfo.petsInfos[index].generalInfo.heightweight
                    .weightKg !=
                null)) {
      return true;
    }
    return false;
  }

  bool _microchipedPetStatus(Profile profile, int index) {
    if ((profile.userGeneralInfo.petsInfos[index].generalInfo.microscopic
                    .michrochipNumber !=
                null &&
            profile.userGeneralInfo.petsInfos[index].generalInfo.microscopic
                    .michrochipNumber !=
                "") ||
        (profile.userGeneralInfo.petsInfos[index].generalInfo.microscopic
                    .note !=
                null &&
            profile.userGeneralInfo.petsInfos[index].generalInfo.microscopic
                    .note !=
                "")) {
      return true;
    }
    return false;
  }

  bool _breedStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.petsInfos[index].generalInfo.breed != null &&
        profile.userGeneralInfo.petsInfos[index].generalInfo.breed != "") {
      return true;
    }
    return false;
  }

  bool _colorStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.petsInfos[index].generalInfo.color != null &&
        profile.userGeneralInfo.petsInfos[index].generalInfo.color != "") {
      return true;
    }
    return false;
  }

  bool _distinctiveSignsStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.petsInfos[index].generalInfo.distinctsSigns !=
            null &&
        profile.userGeneralInfo.petsInfos[index].generalInfo.distinctsSigns !=
            "") {
      return true;
    }
    return false;
  }

  bool _dietPetStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.petsInfos[index].generalInfo.diet != null &&
        profile.userGeneralInfo.petsInfos[index].generalInfo.diet != "") {
      return true;
    }
    return false;
  }

  bool _dateOfBirthStatus(Profile profile, int index) {
    if ((profile.userGeneralInfo.petsInfos[index].generalInfo.birthInfo.day !=
                null &&
            profile.userGeneralInfo.petsInfos[index].generalInfo.birthInfo
                    .day !=
                "") &&
        (profile.userGeneralInfo.petsInfos[index].generalInfo.birthInfo.month !=
                null &&
            profile.userGeneralInfo.petsInfos[index].generalInfo.birthInfo
                    .month !=
                "") &&
        (profile.userGeneralInfo.petsInfos[index].generalInfo.birthInfo.year !=
                null &&
            profile.userGeneralInfo.petsInfos[index].generalInfo.birthInfo
                    .year !=
                "")) {
      return true;
    }
    return false;
  }

  bool _vaccinesStatus(Profile profile, int index) {
    bool ok = false;

    for (int i = 0;
        i < profile.userGeneralInfo.petsInfos[index].vaccins.length;
        i++) {
      if ((profile.userGeneralInfo.petsInfos[index].vaccins[i].label != "" &&
              profile.userGeneralInfo.petsInfos[index].vaccins[i].label !=
                  null) ||
          (profile.userGeneralInfo.petsInfos[index].vaccins[i].description !=
                  "" &&
              profile.userGeneralInfo.petsInfos[index].vaccins[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.petsInfos[index].vaccins.isNotEmpty && ok) {
      return true;
    }
    return false;
  }

  bool _otherStatus(Profile profile, int index) {
    bool ok = false;

    for (int i = 0;
        i < profile.userGeneralInfo.petsInfos[index].otherInfo.length;
        i++) {
      if ((profile.userGeneralInfo.petsInfos[index].otherInfo[i].label != "" &&
              profile.userGeneralInfo.petsInfos[index].otherInfo[i].label !=
                  null) ||
          (profile.userGeneralInfo.petsInfos[index].otherInfo[i].description !=
                  "" &&
              profile.userGeneralInfo.petsInfos[index].otherInfo[i]
                      .description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.petsInfos[index].otherInfo.isNotEmpty && ok) {
      return true;
    }
    return false;
  }

  bool _tagInformationStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.petsInfos[index].petTag.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool _DescriptionObjectStatus(Profile profile, int index) {
    if (_tagInformationStatus(profile, index) ||
        _otherStatus(profile, index) ||
        _vaccinesStatus(profile, index) ||
        _dateOfBirthStatus(profile, index) ||
        _dietPetStatus(profile, index) ||
        _distinctiveSignsStatus(profile, index) ||
        _colorStatus(profile, index) ||
        _breedStatus(profile, index) ||
        _microchipedPetStatus(profile, index) ||
        _weightHeightStatus(profile, index) ||
        _genderStatus(profile, index) ||
        (profile.userGeneralInfo.petsInfos[index].generalInfo.name != null &&
            profile.userGeneralInfo.petsInfos[index].generalInfo.name != "") ||
        (profile.userGeneralInfo.petsInfos[index].generalInfo.idType != null) ||
        (profile.userGeneralInfo.petsInfos[index].generalInfo.idMember !=
            null)) {
      return true;
    }
    return false;
  }

  bool _thnakyouStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.petsInfos[index].generalInfo.thankYouMsg !=
            null &&
        profile.userGeneralInfo.petsInfos[index].generalInfo.thankYouMsg !=
            "") {
      return true;
    }
    return false;
  }
}
