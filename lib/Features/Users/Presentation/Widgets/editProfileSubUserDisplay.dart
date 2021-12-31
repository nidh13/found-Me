import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopolis/Core/Utils/date_hint.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:neopolis/Core/Utils/nullable_valid_date.dart';
import 'package:neopolis/Core/Utils/validDate.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/Sean4Dialog.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/date_picker.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/expandable_Alsocontact_list.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/expandable_EmergencyContact.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/ExpandableAlsoContactChild.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/customSwitchDiseable.dart';
import 'package:neopolis/Features/Users/Presentation/bloc/users_bloc.dart';
import 'package:neopolis/Features/users/Presentation/Widgets/Components/expandable_insurance.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/expandable_list.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/expandable_misclaneous_list.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/expandable_other_list.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/expandable_physician_list.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/expandable_Donar.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/expandable_Dnr.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popUpImage.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/alertDialogUpdate.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/animationEditSubUser.dart';

class EditProfileSubUserDisplay extends StatefulWidget {
  final Profile profile;
  final int index;
  final String loading;
  const EditProfileSubUserDisplay(
      {Key key, @required this.profile, this.index, this.loading})
      : super(key: key);

  @override
  EditProfileSubUserDisplayState createState() =>
      EditProfileSubUserDisplayState();
}

class EditProfileSubUserDisplayState extends State<EditProfileSubUserDisplay> {
  var screenWidth, screenHeight;
  bool textField = false;
  bool petOwner = false;
  bool contact = false;
  bool _visiInsurance = true;
  bool _visiPhysician = true;
  bool _visiBoold = true;
  bool _visiAllergies = true;
  bool _visiDnr = true;
  bool _visiimplants = true;
  bool _visiRenal = true;
  bool _visiCardiac = true;
  bool _visiPsych = true;
  bool _visiNeuro = true;
  bool _visiPul = true;
  bool _visiMedication = true;
  bool _visiCancer = true;
  bool _visiInfection = true;
  bool _visiOther = true;
  bool _visiMescelanous = true;
  String role;
  TextEditingController phone1controller = new TextEditingController();
  bool persInfo = false;
  bool emegInfo = false;
  bool alsoInfo = false;
  bool nameUser = false;
  bool userRights = false;
  bool userInfoChild = false;
  ValidDate firstDate;
  AnimationController animationController;
  bool maxNombreAdmin = false;
  nombreUserAdmin() {
    widget.profile.userGeneralInfo.subUsers.forEach((element) {
      if (element.userGeneralInfo.role == 2) {
        maxNombreAdmin = true;
      }
    });
  }

  /// Maximum date value that [DropdownButton] widgets can have.
  ValidDate lastDate;
  bool memebrs = false;
  bool advancedSettings = false;
  bool medicInfo = false;
  bool viewExport = false;
  ScrollController _userScrollController = new ScrollController();
  FocusNode _thankYouFocus = FocusNode();

  //General & Medical Records

  int nbblock = 5;

  bool _viewRecord = false;
  bool _emailRecord = false;
  bool _printRecord = false;

  //Medical information
  List<bool> addBlock = [];
  List<bool> addBlockChild = [];
  int nombrebolckAlsoContact = 0;
  int nombrebolckInsurance = 0;
  List<bool> addBlockInsurance = [];

  int nombrebolckEmergencyContact = 0;
  List<bool> addBlockEmergency = [];

  int nombrebolckPhysicianContact = 0;
  List<bool> addBlockPhysician = [];

  int nombrebolckInfectiousDesease = 0;
  List<bool> addBlockInfec = [];

  int nombrebolckAllergies = 0;
  List<bool> addBlockAllerg = [];

  int nombrebolckDnr = 0;
  List<bool> addBlockDNR = [];

  int nombrebolckImplant = 0;
  List<bool> addBlockImpl = [];

  int nombrebolckRenal = 0;
  List<bool> addBlockRenal = [];

  int nombrebolckCardiac = 0;
  List<bool> addBlockCardiac = [];

  int nombrebolckPsychiatric = 0;
  List<bool> addBlockPsy = [];

  int nombrebolckNeurologic = 0;
  List<bool> addBlockNeuro = [];

  int nombrebolckPulmonary = 0;
  List<bool> addBlockPulmo = [];

  int nombrebolckMedication = 0;
  List<bool> addBlockMedica = [];

  int nombrebolckCancer = 0;
  List<bool> addBlockCancer = [];

  int nombrebolckBlood = 0;
  List<bool> addBlockBlood = [];

  int nombrebolckOther = 0;
  List<bool> addBlockOther = [];

  int nombrebolckMiscelaneous = 0;
  List<bool> addBlockMisc = [];

  bool _infectiousdiseases = false;
  bool _allergies = false;
  bool _dnr = false;
  bool lockSreen = true;
  bool _implants = false;
  bool _renalKidney = false;
  bool _psychiatric = false;
  bool _neurologic = false;
  bool _pulmonary = false;
  bool _medication = false;
  bool _cancer = false;

  // Organ Donor
  int _userIndicatorIndex = 0;
  bool organDonor = false;
  bool _switchOrganDonor = false;
  bool organDonorInner = false;
  TextEditingController organDonorController = new TextEditingController();
  FocusNode organDonorFocus = FocusNode();

//other
  bool other = false;
  TextEditingController otherController = new TextEditingController();
  FocusNode otherFocus = FocusNode();
  TextEditingController other2Controller = new TextEditingController();
  FocusNode other2Focus = FocusNode();

  //Insurance Information
  bool insuranceInformation = false;

  bool attachment = false;
  bool block = false;
  bool medicalTag = false;
  bool medical = true;
  bool contactInfo = false;
  bool visi = true;
  bool alsoContact = false;
  bool info = true;
  bool rewards = false;
  //_emergencyContacts
  bool emergencyContacts = false;
  FocusNode physicianContact = FocusNode();
  TextEditingController physicianContactController =
      new TextEditingController();

  //Cardiac
  bool cardiac = false;

  //Blood
  bool blood = false;
  bool bloodInner = false;
  // List bloodList = ['A+', 'B+', 'O+', 'AB+', 'A-', 'B-', 'O-', 'AB-'];
  var bloodData;
  List systolicList = ['110 mmHg', '115 mmHg', '120 mmHg'];
  var systolicData;
  List diastolicList = ['80 mmHg+', '90 mmHg', '100 mmHg'];
  var diastolicData;

  TextEditingController bloodController = new TextEditingController();

//Physician Contacts
  bool physicianContacts = false;
  //Miscelaneous
  bool miscelaneous = false;
  bool miscelaneousinner = false;
  TextEditingController miscelaneousController = new TextEditingController();
  FocusNode miscelaneousFocus = FocusNode();
  TextEditingController miscelaneous2Controller = new TextEditingController();
  FocusNode miscelaneous2Focus = FocusNode();
  //DateOFBirth
  bool dob = false;

  FocusNode nbreFocus = FocusNode();

//_maritalStatus

  bool maritalStatus = false;
  List maritalList = ['Married', 'UnMarried'];
  var maritalData;

//Pets at Home
  bool petsHome = false;
  TextEditingController petsHomeController = new TextEditingController();
  FocusNode petsHomeFocus = FocusNode();

  bool _switchReward;

  //_distinctiveSigns
  bool distinctiveSigns = false;
  bool thankyou = false;
  TextEditingController distinctiveSignsController =
      new TextEditingController();
  FocusNode distinctiveSignsFocus = FocusNode();
  String rewardsum;
  String rewardCurrency;
  //eyecolor
  bool eye = false;
  var eyeData;
  var religionData;

  //religion
  bool religion = false;
  TextEditingController religionController = new TextEditingController();
  FocusNode religionFocus = FocusNode();

  // Microchiped
  bool microChiPed = false;
  bool language = false;
  TextEditingController languageController = new TextEditingController();
  FocusNode languageFocus = FocusNode();
  TextEditingController microChiPedNoController = new TextEditingController();
  TextEditingController microChiPedNoteController = new TextEditingController();
  FocusNode microChiPedNoFocus = FocusNode();
  FocusNode microChiPedNoteFocus = FocusNode();
  //Breed
  bool breed = false;
  TextEditingController breedController = new TextEditingController();
  FocusNode breedFocus = FocusNode();
  bool _validate = false;
  bool _validateEmail = false;
//Color
  bool color = false;
  TextEditingController colorController = new TextEditingController();
  FocusNode colorFocus = FocusNode();

  TextEditingController contact1controller = new TextEditingController();
  TextEditingController thankYouController = new TextEditingController();

  bool _switchAllowLiveChat;
  bool _switchAllowShareEmails;
  bool _switchAllowMobile;
  bool _switchIncludeMail;
  bool _switchIncludePhone;
  bool _switchIncludeName;
  bool _switchAllowPicture;
  bool attachmentMedical = false;
  bool reminderMedical = false;
  bool attachmentInsuranceInfo = false;
  bool reminderInsuranceInfo = false;
  bool attachmentMedicalInfectious = false;
  bool reminderMedicalInfectious = false;
  bool attachmentMedicalAllergies = false;
  bool reminderMedicalAllergies = false;
  bool attachmentMedicalImplant = false;
  bool reminderMedicalImplant = false;
  bool attachmentMedicalRenal = false;
  bool reminderMedicalRenal = false;
  bool attachmentMedicalCardiac = false;
  bool reminderMedicalCaridac = false;

  bool attachmentMedicalPsy = false;
  bool reminderMedicalPsy = false;
  bool attachmentMedicalNeuro = false;
  bool reminderMedicalNeuro = false;
  bool attachmentMedicalPulmo = false;
  bool reminderMedicalPulmo = false;
  bool attachmentMedicalMedication = false;
  bool reminderMedicalMedication = false;
  bool attachmentMedicalCancer = false;
  bool reminderMedicalCancer = false;
  bool attachmentMedicalBlood = false;
  bool reminderMedicalBlood = false;
  bool attachmentMedicalOrgan = false;
  bool reminderMedicalOrgan = false;
  bool attachmentMedicalCardia = false;
  bool reminderMedicalCardiac = false;
  bool attachmentMedicalOther = false;
  bool reminderMedicalOther = false;
  bool attachmentMiscilaneous = false;
  bool reminderMiscilaneous = false;
  List<Tags> userMedicalTags = [];
  List<InsuranceInfo> userInsuranceInfo = [];
  List<Miscilanious> userMiscelaneous = [];
  List<PhysicianContact> userMedicalPhysicianEmergencyContacts = [];
  List<Blocks> userMedicalDiseacesCancer = [];
  List<Blocks> userMedicalDiseacesAllergies = [];
  List<Blocks> userMedicalDiseacesCardiac = [];
  List<Resuscitate> userMedicalDiseacesDnr = [];

  List<Blocks> userMedicalDiseacesImplants = [];
  List<Blocks> userMedicalDiseacesMedication = [];
  List<Blocks> userMedicalDiseacesNeurologic = [];
  List<Blocks> userMedicalDiseacesPlumonary = [];
  List<Blocks> userMedicalDiseacesPsychiatric = [];
  List<Blocks> userMedicalDiseacesRenal = [];
  List<Blocks> userMedicalDiseacesInfectionDisaces = [];
  List<Diabates> userMedicalBloodDiabates = [];
  List<Widget> listALsoContact = [];
  List<Widget> listInsurance = [];
  viewFisrtNameLastName(String first, String last) {
    if (first != null && last == null) {
      return MyText(
          value: first,
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
    if (first == null && last != null) {
      return MyText(
          value: last,
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
    if (first == null && last == null) {
      return MyText(
          value: ' ',
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
    if (first != null && last != null) {
      return MyText(
          value: first + ' ' + last,
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
  }

  preferenceUser() {
    widget.profile.userGeneralInfo.subUsers.length;
    print(widget.profile.userGeneralInfo.subUsers.length);
    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                .preferenceUser.allowLiveChat ==
            null
        ? _switchAllowLiveChat = false
        : widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                    .preferenceUser.allowLiveChat.value ==
                '1'
            ? _switchAllowLiveChat = true
            : _switchAllowLiveChat = false;

    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                .preferenceUser.allowShareEmails ==
            null
        ? _switchAllowShareEmails = false
        : widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                    .preferenceUser.allowShareEmails.value ==
                '1'
            ? _switchAllowShareEmails = true
            : _switchAllowShareEmails = false;

    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                .preferenceUser.allowSharePhone ==
            null
        ? _switchAllowMobile = false
        : widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                    .preferenceUser.allowSharePhone.value ==
                '1'
            ? _switchAllowMobile = true
            : _switchAllowMobile = false;

    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                .preferenceUser.includeMail1 ==
            null
        ? _switchIncludeMail = false
        : widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                    .preferenceUser.includeMail1.value ==
                '1'
            ? _switchIncludeMail = true
            : _switchIncludeMail = false;

    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                .preferenceUser.includeMobile ==
            null
        ? _switchIncludePhone = false
        : widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                    .preferenceUser.includeMobile.value ==
                '1'
            ? _switchIncludePhone = true
            : _switchIncludePhone = false;

    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                .preferenceUser.allowShareName ==
            null
        ? _switchIncludeName = false
        : widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                    .preferenceUser.allowShareName.value ==
                '1'
            ? _switchIncludeName = true
            : _switchIncludeName = false;

    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                .preferenceUser.allowSharePicture ==
            null
        ? _switchAllowPicture = false
        : widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                    .preferenceUser.allowSharePicture.value ==
                '1'
            ? _switchAllowPicture = true
            : _switchAllowPicture = false;
  }

  List<bool> addEmergencyChild = [];
  userEmergencyContacts() {
    nombrebolckAlsoContact = widget.profile.userGeneralInfo
        .subUsers[widget.index].userGeneralInfo.userEmergencyContact.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
        .userEmergencyContact
        .forEach((element) {
      addBlockChild.add(false);
    });
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
        .userEmergencyContact
        .forEach((element) {
      addEmergencyChild.add(false);
    });
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
        .userEmergencyContact
        .forEach((element) {
      addBlockEmergency.add(false);
    });
  }

  myMedicalTags() {
    widget.profile.userGeneralInfo.tagsList.medicalTag.forEach((element) {
      if (widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
              .idMember ==
          element.idMember) {
        userMedicalTags = element.tags;
      }
    });
  }

  myInsuranceInfo() {
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .insuranceInfo !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .insuranceInfo
            .forEach((element) {
            userInsuranceInfo.add(element);
            addBlockInsurance.add(false);
          })
        : Container();
    nombrebolckInsurance = userInsuranceInfo.length;
  }

  myMiscelaneous() {
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .miscilanious !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .miscilanious
            .forEach((element) {
            userMiscelaneous.add(element);
            addBlockMisc.add(false);
          })
        : Container();
    nombrebolckMiscelaneous = userMiscelaneous.length;
  }

  myMedicalEmergencyContacts() {
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .userEmergencyContact !=
            null
        ? nombrebolckEmergencyContact = widget.profile.userGeneralInfo
            .subUsers[widget.index].medicalRecord.userEmergencyContact.length
        : Container();
  }

  myMedicalPhysicianEmergencyContacts() {
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .physicianContact !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .physicianContact
            .forEach((element) {
            userMedicalPhysicianEmergencyContacts.add(element);
            addBlockPhysician.add(false);
          })
        : Container();
    nombrebolckPhysicianContact = userMedicalPhysicianEmergencyContacts.length;
  }

  myMedicalDiseaces() {
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.cancer !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.cancer.blocks
            .forEach((element) {
            userMedicalDiseacesCancer.add(element);
            addBlockCancer.add(false);
          })
        : Container();
    nombrebolckCancer = userMedicalDiseacesCancer.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.allergies !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.allergies.blocks
            .forEach((element) {
            addBlockAllerg.add(false);
            userMedicalDiseacesAllergies.add(element);
          })
        : Container();
    nombrebolckAllergies = userMedicalDiseacesAllergies.length;

    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.cardiac !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.cardiac.blocks
            .forEach((element) {
            addBlockCardiac.add(false);
            userMedicalDiseacesCardiac.add(element);
          })
        : Container();
    nombrebolckCardiac = userMedicalDiseacesCardiac.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.implants !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.implants.blocks
            .forEach((element) {
            addBlockImpl.add(false);
            userMedicalDiseacesImplants.add(element);
          })
        : Container();
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.medication !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.medication.blocks
            .forEach((element) {
            addBlockMedica.add(false);
            userMedicalDiseacesMedication.add(element);
          })
        : Container();
    nombrebolckMedication = userMedicalDiseacesMedication.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.neuroligic !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.neuroligic.blocks
            .forEach((element) {
            addBlockNeuro.add(false);
            userMedicalDiseacesNeurologic.add(element);
          })
        : Container();
    nombrebolckNeurologic = userMedicalDiseacesNeurologic.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.plumonary !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.plumonary.blocks
            .forEach((element) {
            addBlockPulmo.add(false);
            userMedicalDiseacesPlumonary.add(element);
          })
        : Container();
    nombrebolckPulmonary = userMedicalDiseacesPlumonary.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.psychiatric !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.psychiatric.blocks
            .forEach((element) {
            addBlockPsy.add(false);
            userMedicalDiseacesPsychiatric.add(element);
          })
        : Container();
    nombrebolckPsychiatric = userMedicalDiseacesPsychiatric.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.renalKenedy !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.renalKenedy.blocks
            .forEach((element) {
            addBlockRenal.add(false);
            userMedicalDiseacesRenal.add(element);
          })
        : Container();
    nombrebolckRenal = userMedicalDiseacesRenal.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.infectionDisaces !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.infectionDisaces.blocks
            .forEach((element) {
            addBlockInfec.add(false);
            userMedicalDiseacesInfectionDisaces.add(element);
          })
        : Container();
    nombrebolckInfectiousDesease = userMedicalDiseacesInfectionDisaces.length;
  }

  myMedicalBloodDiabates() {
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .bloodInfo.diabates !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .bloodInfo.diabates
            .forEach((element) {
            addBlockBlood.add(false);
            userMedicalBloodDiabates.add(element);
          })
        : Container();
    nombrebolckBlood = userMedicalBloodDiabates.length;
    nombrebolckOther = widget.profile.userGeneralInfo.subUsers[widget.index]
        .medicalRecord.otherMedicalRecordInfo.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
        .otherMedicalRecordInfo
        .forEach((element) {
      addBlockOther.add(false);
    });
  }

  bool iconAttachmentMedicalTag() {
    userMedicalTags.forEach((element) {
      element.otherInfo.forEach((element) {
        if (element.documents.length != null) {
          attachmentMedical = true;
        }
      });
    });
    return attachmentMedical;
  }

  bool iconReminderMedicalTag() {
    userMedicalTags.forEach((element) {
      element.otherInfo.forEach((element) {
        if (element.reminders.length != null) {
          reminderMedical = true;
        }
      });
    });
    return reminderMedical;
  }

  bool iconAttachmentMiscilaneous() {
    userMiscelaneous.forEach((element) {
      if (element.documents != null) {
        if (element.documents.length != 0) {
          attachmentMiscilaneous = true;
        }
      }
    });
    return attachmentMiscilaneous;
  }

  bool iconReminderMiscilaneous() {
    userMiscelaneous.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMiscilaneous = true;
      }
    });
    return reminderMiscilaneous;
  }

  double valu;
  bool iconAttachmentInsuranceInfo() {
    userInsuranceInfo.forEach((element) {
      if (element.documents != null) {
        if (element.documents.length != 0) {
          attachmentInsuranceInfo = true;
        }
      }
    });
    return attachmentInsuranceInfo;
  }

  bool iconReminderInsuranceInfo() {
    userInsuranceInfo.forEach((element) {
      if (element.reminders != null) {
        if (element.reminders.length != 0) {
          reminderInsuranceInfo = true;
        }
      }
    });
    return reminderInsuranceInfo;
  }

  bool iconAttachmentMedicalInfectious() {
    userMedicalDiseacesInfectionDisaces.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalInfectious = true;
      }
    });
    return attachmentMedicalInfectious;
  }

  bool iconReminderMedicalInfectious() {
    userMedicalDiseacesInfectionDisaces.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalInfectious = true;
      }
    });
    return reminderMedicalInfectious;
  }

  bool iconAttachmentMedicalAllergies() {
    userMedicalDiseacesAllergies.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalAllergies = true;
      }
    });
    return attachmentMedicalAllergies;
  }

  bool iconReminderMedicalAllergies() {
    userMedicalDiseacesAllergies.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalAllergies = true;
      }
    });
    return reminderMedicalAllergies;
  }

  bool iconAttachmentMedicalImplant() {
    userMedicalDiseacesImplants.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalImplant = true;
      }
    });
    return attachmentMedicalImplant;
  }

  bool iconReminderMedicalImplant() {
    userMedicalDiseacesImplants.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalImplant = true;
      }
    });
    return reminderMedicalImplant;
  }

  bool iconAttachmentMedicalCardiac() {
    userMedicalDiseacesCardiac.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalCardia = true;
      }
    });
    return attachmentMedicalCardia;
  }

  bool iconReminderMedicalCardiac() {
    userMedicalDiseacesCardiac.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalCardiac = true;
      }
    });
    return reminderMedicalCardiac;
  }

  bool iconAttachmentMedicalRenal() {
    userMedicalDiseacesRenal.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalRenal = true;
      }
    });
    return attachmentMedicalRenal;
  }

  bool iconReminderMedicalRenal() {
    userMedicalDiseacesRenal.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalRenal = true;
      }
    });
    return reminderMedicalRenal;
  }

  bool iconAttachmentMedicalPsy() {
    userMedicalDiseacesPsychiatric.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalPsy = true;
      }
    });
    return attachmentMedicalPsy;
  }

  bool iconReminderMedicalPsy() {
    userMedicalDiseacesPsychiatric.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalPsy = true;
      }
    });
    return reminderMedicalPsy;
  }

  bool iconAttachmentMedicalNeuro() {
    userMedicalDiseacesNeurologic.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalNeuro = true;
      }
    });
    return attachmentMedicalNeuro;
  }

  bool iconReminderMedicalNeuro() {
    userMedicalDiseacesNeurologic.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalNeuro = true;
      }
    });
    return reminderMedicalNeuro;
  }

  bool iconAttachmentMedicalPulmo() {
    userMedicalDiseacesPlumonary.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalPulmo = true;
      }
    });
    return attachmentMedicalPulmo;
  }

  bool iconReminderMedicalPulmo() {
    userMedicalDiseacesPlumonary.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalPulmo = true;
      }
    });
    return reminderMedicalPulmo;
  }

  bool iconAttachmentMedicalMedication() {
    userMedicalDiseacesMedication.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalMedication = true;
      }
    });
    return attachmentMedicalMedication;
  }

  bool iconReminderMedicalMedication() {
    userMedicalDiseacesMedication.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalMedication = true;
      }
    });
    return reminderMedicalMedication;
  }

  bool iconAttachmentMedicalCancer() {
    userMedicalDiseacesCancer.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalCancer = true;
      }
    });
    return attachmentMedicalCancer;
  }

  bool iconReminderMedicalCancer() {
    userMedicalDiseacesCancer.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalCancer = true;
      }
    });
    return reminderMedicalCancer;
  }

  bool iconAttachmentMedicalBlood() {
    userMedicalBloodDiabates.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalBlood = true;
      }
    });
    return attachmentMedicalBlood;
  }

  bool iconReminderMedicalBlood() {
    userMedicalBloodDiabates.forEach((element) {
      if (element.reminder != null) {
        if (element.reminder.length != 0) {
          reminderMedicalBlood = true;
        }
      }
    });
    return reminderMedicalBlood;
  }

  bool iconAttachmentOther(Profile profile) {
    profile.userGeneralInfo.subUsers[widget.index].medicalRecord
        .otherMedicalRecordInfo
        .forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalOther = true;
      }
    });
    return attachmentMedicalOther;
  }

  bool iconReminderOther(Profile profile) {
    profile.userGeneralInfo.subUsers[widget.index].medicalRecord
        .otherMedicalRecordInfo
        .forEach((element) {
      if (element.reminder != null) {
        if (element.reminder.length != 0) {
          reminderMedicalOther = true;
        }
      }
    });
    return reminderMedicalOther;
  }

  bool alarm = true;
  bool _visibile = true;
  bool _visi = true;
  bool pTags = false;
  bool otherinfo = false;
  //gender
  var genderData;
  bool gender = false;

  //Include my email
  bool _switchIncludemail = false;
  bool _switchIncludepic = false;
  bool _switchIncludename = false;
  //Include my real address
  bool realAddress = false;
  File imageFile;
  //Include my temporary Address
  bool tempAddress = false;

  //Declare Pet lost
  bool petLose = false;
  bool liveChatme = false;
  bool firstemail = false;
  bool secondEmail = false;
  bool shareMobile = false;
  bool shareEmail = false;
  bool includeNumbre = false;
  bool includeName = false;
  bool includePicture = false;
  List nameList = ["Joe Smith", "Max Smith", "Bill Smith"];
  String contactName = "Max Smith";
  TextEditingController feetController = new TextEditingController();
  TextEditingController inchController = new TextEditingController();
  TextEditingController cmController = new TextEditingController();
  TextEditingController lbsController = new TextEditingController();
  TextEditingController kgController = new TextEditingController();

  FocusNode feetFocus = FocusNode();
  FocusNode inchFocus = FocusNode();
  FocusNode cmFocus = FocusNode();
  FocusNode lbsFocus = FocusNode();
  FocusNode kgFocus = FocusNode();
  FocusNode codeFocus = FocusNode();

  FocusNode thankFocus = FocusNode();

  double _petItemWidth = 0.0;
  //height and weight
  bool height = false;
  Map<dynamic, dynamic> some = {};
  Map<dynamic, dynamic> someInsur = {};
  int _petIndicatorIndex = 0;
  final List<String> petList = [
    "Np",
    "Mp",
    "Ap",
    "Kp",
    "Dp",
    "Sp",
    "Xp",
    "Op",
    "Wp",
  ];
  ScrollController _petScrollController = new ScrollController();

  void scrollListenerWithItemHeight() {
    double itemHeight =
        _petItemWidth; // including padding above and below the list item
    double scrollOffset = _petScrollController.offset;
    int firstVisibleItemIndex =
        scrollOffset < itemHeight ? 0 : ((scrollOffset) ~/ itemHeight);
    _petIndicatorIndex = firstVisibleItemIndex;
    setState(() {});
  }

  bool checkerEmail1Switch;
  bool checkerEmail2Switch;
  @override
  void initState() {
    nombreUserAdmin();
    preferenceUser();
    userEmergencyContacts();
    myMedicalTags();
    myInsuranceInfo();
    myMiscelaneous();
    myMedicalEmergencyContacts();
    myMedicalPhysicianEmergencyContacts();
    myMedicalDiseaces();
    myMedicalBloodDiabates();
    iconAttachmentMedicalTag();
    iconReminderMedicalTag();
    iconAttachmentInsuranceInfo();
    if (widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
            .role ==
        4) {
      widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                  .custumMessage ==
              null
          ? widget
              .profile
              .userGeneralInfo
              .subUsers[widget.index]
              .userGeneralInfo
              .custumMessage = widget.profile.userGeneralInfo.custumMessage
          : widget.profile.userGeneralInfo.subUsers[widget.index]
                  .userGeneralInfo.custumMessage =
              widget.profile.userGeneralInfo.subUsers[widget.index]
                  .userGeneralInfo.custumMessage;
    }
    checkerEmail1Switch = regExpEmail.hasMatch(widget.profile.userGeneralInfo
            .subUsers[widget.index].userGeneralInfo.mail ??
        '');
    checkerEmail2Switch = regExpEmail.hasMatch(widget.profile.userGeneralInfo
            .subUsers[widget.index].userGeneralInfo.mail2 ??
        '');
    _petScrollController.addListener(scrollListenerWithItemHeight);
    checkerEmail1ContactInfo = widget.profile.userGeneralInfo
                    .subUsers[widget.index].userGeneralInfo.mail ==
                '' ||
            widget.profile.userGeneralInfo.subUsers[widget.index]
                    .userGeneralInfo.mail ==
                null
        ? true
        : regExpEmail.hasMatch(widget.profile.userGeneralInfo
                .subUsers[widget.index].userGeneralInfo.mail ??
            '');
    checkerEmail2ContactInfo = widget.profile.userGeneralInfo
                    .subUsers[widget.index].userGeneralInfo.mail2 ==
                "" ||
            widget.profile.userGeneralInfo.subUsers[widget.index]
                    .userGeneralInfo.mail2 ==
                null
        ? true
        : regExpEmail.hasMatch(widget.profile.userGeneralInfo
                .subUsers[widget.index].userGeneralInfo.mail2 ??
            '');
    if (widget.profile.userGeneralInfo.update == null) {
      widget.profile.userGeneralInfo.update = false;
    }
    super.initState();
  }

  String roleUser() {
    if (widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
            .role ==
        2) {
      role = 'Administrator';
    }
    if (widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
            .role ==
        3) {
      role = 'Member';
    }
    if (widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
            .role ==
        4) {
      role = 'child';
    }
    return role;
  }

  Widget customRoleAdmin(int role) {
    if (role == 2) {
      return Image.asset("Assets/Images/switchIcon.png");
    } else {
      return Image.asset("Assets/Images/falseSwitchIcon.png");
    }
  }

  Widget customRoleMember(int role) {
    if (role == 3) {
      return Image.asset("Assets/Images/switchIcon.png");
    } else {
      return Image.asset("Assets/Images/falseSwitchIcon.png");
    }
  }

  Widget customRoleChild(int role) {
    if (role == 4) {
      return Image.asset("Assets/Images/switchIcon.png");
    } else {
      return Image.asset("Assets/Images/falseSwitchIcon.png");
    }
  }

  static final now = DateTime.now();
  List<Asset> images = <Asset>[];

  bool isDateSelected = false;
  DateTime birthDate; // instance of DateTime
  String birthDateInString;
  bool roleAdmin;
  bool roleMember;
  bool roleChild;
  DropdownDatePicker dropdownDatePicker;
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    roleUser();
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

    Profile profile = widget.profile;
    dropdownDatePicker = DropdownDatePicker(
      profile: profile,
      index: widget.index,
      initialDate: NullableValidDate(
          year: widget.profile.userGeneralInfo.subUsers[widget.index]
              .userGeneralInfo.birthInfo.year,
          month: convertMonth(widget.profile.userGeneralInfo
              .subUsers[widget.index].userGeneralInfo.birthInfo.month),
          day: convertDay(widget.profile.userGeneralInfo.subUsers[widget.index]
              .userGeneralInfo.birthInfo.day)),
      firstDate: ValidDate(year: now.year - 100, month: 1, day: 1),
      lastDate: ValidDate(year: now.year, month: now.month, day: now.day),
      dateHint: DateHint(
          year: "editprofil_medical_label_year".tr(),
          month: "editprofil_medical_label_month".tr(),
          day: "editprofil_medical_label_day".tr()),
      ascending: false,
    );

    roleAdmin =
        profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo.role == 2
            ? true
            : false;
    roleMember =
        profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo.role == 3
            ? true
            : false;
    roleChild =
        profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo.role == 4
            ? true
            : false;
    int index = widget.index;

    final Map<dynamic, dynamic> someMap = {
      "visibility": _visi,
      "listofwidget": listALsoContact,
    };
    final Map<dynamic, dynamic> someinsurance = {
      "visibility": _visiInsurance,
      "listofwidget": listInsurance,
    };
    some = someMap;
    someInsur = someinsurance;

    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return NestedScrollView(
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
                  firstName: profile.userGeneralInfo.subUsers[widget.index]
                      .userGeneralInfo.firstName,
                  lastName: profile.userGeneralInfo.subUsers[widget.index]
                      .userGeneralInfo.lastName,
                  role: profile.userGeneralInfo.subUsers[widget.index]
                      .userGeneralInfo.roleLabel,
                  index: widget.index,
                  loading: widget.loading,
                )),
          ];
        },
        body: Column(
          children: [
            Expanded(
                child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 0, 26, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: MyText(
                          value: "editprofil_general_label_general".tr(),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: ColorConstant.textColor),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    role == "child" ? nameMember(profile) : Container(),
                    role == "child"
                        ? SizedBox(
                            height: 16,
                          )
                        : Container(),
                    _Contact(profile),
                    SizedBox(
                      height: 16,
                    ),
                    role != "child" ? alsoInfos(profile) : Container(),
                    role != "child"
                        ? SizedBox(
                            height: 16,
                          )
                        : Container(),
                    _AdvancedSettings(profile),
                    SizedBox(
                      height: 16,
                    ),
                    _Memebrs(profile, index),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: MyText(
                        value: "editprofil_general_label_medical".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: ColorConstant.textColor,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    _medicalTags(profile),
                    SizedBox(
                      height: 12,
                    ),
                    _PersInfo(profile),
                    SizedBox(
                      height: 12,
                    ),
                    _EmegInfo(profile),
                    SizedBox(
                      height: 12,
                    ),
                    _MedicInfo(profile),
                    SizedBox(
                      height: 12,
                    ),
                    _ViewExport(profile),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(height: 40),
                    _editButton(profile, index),
                    SizedBox(
                      height: 20,
                    ),
                    _deleteButton(profile, index),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ]))
          ],
        ),
      );
    });
  }

// GENERAL
  //MY contact info

  _Contact(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              border: contact || _GenerlInfoStatus(profile, widget.index)
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
              color: role == "child"
                  ? ColorConstant.pinkColor
                  : contact || _GenerlInfoStatus(profile, widget.index)
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
                  profile.userGeneralInfo.role != 4
                      ? _scrollController.jumpTo(0)
                      : _scrollController.jumpTo(65);
                  contact = !contact;
                  alsoInfo = false;
                  nameUser = false;
                  advancedSettings = false;
                  memebrs = false;
                  medicInfo = false;
                  persInfo = false;
                  medicalTag = false;
                  viewExport = false;
                  emegInfo = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: Image.asset("Assets/Images/infoC.png",
                          height: 32,
                          width: 31,
                          color: role == "child"
                              ? null
                              : contact ||
                                      _GenerlInfoStatus(profile, widget.index)
                                  ? null
                                  : ColorConstant.textBlockVide),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                                value: "editprofil_medical_title".tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: role == "child"
                                    ? ColorConstant.whiteTextColor
                                    : contact ||
                                            _GenerlInfoStatus(
                                                profile, widget.index)
                                        ? ColorConstant.whiteTextColor
                                        : ColorConstant.textBlockVide),
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
                    contact
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
        contact
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
                        _info(profile),
                        SizedBox(height: 12),
                        role == "child"
                            ? alsoContactsChild(profile)
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

  _info(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          height: 10,
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
                  bottomLeft: Radius.circular(info ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),
              InkWell(
                  child: Container(
            height: 49,
            decoration: BoxDecoration(
                border: Border.all(width: 0, color: ColorConstant.boxColor),
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(info ? 0 : 5.0))),
          )),
        ),
        info
            ? Column(
                children: [
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
                            bottomLeft: Radius.circular(8.0))),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0, color: ColorConstant.boxColor),
                          color: ColorConstant.boxColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8.0))),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 11, right: 20.5, bottom: 23),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            role == 'child'
                                ? profile.userGeneralInfo.subUsers[widget.index]
                                                .userGeneralInfo.firstName !=
                                            null &&
                                        profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .userGeneralInfo
                                                .firstName !=
                                            ''
                                    ? /*Text(
                                        "When " +
                                            profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .userGeneralInfo
                                                .firstName +
                                            " is found",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontFamily: 'SourceSansPro',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor),
                                      )*/
                                    MyText(
                                        value: "editprofil_general_blocinfo_when"
                                                .tr() +
                                            " " +
                                            profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .userGeneralInfo
                                                .firstName +
                                            " " +
                                            "editprofil_general_blocinfo_isfound"
                                                .tr(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorConstant.textColor)
                                    : MyText(
                                        value: "editprofil_general_blocinfo_whenhe"
                                                .tr() +
                                            " " +
                                            "editprofil_general_blocinfo_isfound"
                                                .tr(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorConstant.textColor)
                                : Container(),
                            role == 'child'
                                ? Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: MyText(
                                            value:
                                                "objecttag_label_authorizecontact"
                                                        .tr() +
                                                    ":",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Image.asset(
                                          "Assets/Images/info.png",
                                          height: 14,
                                          width: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                              height: 8,
                            ),
                            role == 'child'
                                ? Container(
                                    height: 0.40,
                                    color: ColorConstant.dividerColor,
                                  )
                                : Container(),
                            SizedBox(
                              height: 14.5,
                            ),
                            Center(
                              child: Row(children: <Widget>[
                                role == 'child'
                                    ? Expanded(
                                        flex: 2,
                                        //check Me
                                        child: MyText(
                                          value:
                                              profile.userGeneralInfo.firstName,
                                        ) /*Text(
                                          profile.userGeneralInfo.firstName,
                                          textScaleFactor: 1.0,
                                        )*/
                                        ,
                                      )
                                    : Expanded(
                                        flex: 2,
                                        child: MyTextField(
                                          initialValue: profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .userGeneralInfo
                                              .firstName,
                                          inputType: TextInputType.number,
                                          editTextBgColor:
                                              ColorConstant.textfieldColor,
                                          title:
                                              "editprofil_general_label_firstname"
                                                  .tr(),
                                          hintTextColor: Colors.white54,
                                          decoration: InputDecoration(
                                            errorText: _validate
                                                ? "editprofil_general_label_errormsg"
                                                    .tr()
                                                : null,
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              profile.userGeneralInfo.update =
                                                  true;
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .userGeneralInfo
                                                  .firstName = value;
                                            });
                                          },
                                        ),
                                      ),
                                role != 'child'
                                    ? SizedBox(
                                        width: 16,
                                      )
                                    : SizedBox(
                                        width: 0,
                                      ),
                                role == 'child'
                                    ? Expanded(
                                        flex: 3,
                                        //  check me
                                        child: MyText(
                                          value:
                                              profile.userGeneralInfo.lastName,
                                        ) /*Text(
                                          profile.userGeneralInfo.lastName,
                                          textScaleFactor: 1.0,
                                        ),*/
                                        )
                                    : Expanded(
                                        flex: 2,
                                        child: MyTextField(
                                            initialValue: profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .userGeneralInfo
                                                .lastName,
                                            title:
                                                "editprofil_general_label_lastname"
                                                    .tr(),
                                            inputType: TextInputType.number,
                                            maxline: 1,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintTextColor: Colors.white54,
                                            onChanged: (value) {
                                              setState(() {
                                                profile.userGeneralInfo.update =
                                                    true;

                                                profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .userGeneralInfo
                                                    .lastName = value;
                                              });
                                            }),
                                      )
                              ]),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            role != 'child'
                                ? MyText(
                                    value: "objecttag_label_authorize".tr(),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: ColorConstant.textColor)
                                : Container(),
                            SizedBox(
                              height: 11,
                            ),
                            MyText(
                                value: "pets_label_emailme".tr(),
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: ColorConstant.textColor),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8.0 ?? 12.5,
                                ),
                                role == 'child'
                                    ? Row(
                                        children: <Widget>[
                                          Expanded(
                                              flex: 12,
                                              //check me
                                              child: MyText(
                                                value: profile
                                                    .userGeneralInfo.mail,
                                              ) /*Text(
                                              profile.userGeneralInfo.mail,
                                              textScaleFactor: 1.0,
                                            ),*/
                                              ),
                                          Expanded(
                                            flex: 4,
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: profile.userGeneralInfo
                                                              .mail ==
                                                          '' ||
                                                      profile.userGeneralInfo
                                                              .mail ==
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
                                                                  .subUsers[
                                                                      widget
                                                                          .index]
                                                                  .userGeneralInfo
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
                                                          profile
                                                              .userGeneralInfo
                                                              .subUsers[
                                                                  widget.index]
                                                              .userGeneralInfo
                                                              .preferenceUser
                                                              .includeMail1
                                                              .value = value ==
                                                                  true
                                                              ? '1'
                                                              : '0';
                                                        });
                                                        _switchAllowShareEmails =
                                                            value;
                                                      },
                                                    ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 11,
                                            child: MyTextField(
                                              initialValue: profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .userGeneralInfo
                                                  .mail,
                                              maxline: 1,
                                              inputType:
                                                  TextInputType.multiline,
                                              editTextBgColor:
                                                  ColorConstant.textfieldColor,
                                              hintTextColor: Colors.white54,
                                              decoration: InputDecoration(
                                                errorText: _validateEmail
                                                    ? 'editprofil_general_label_errormsg'
                                                        .tr()
                                                    : null,
                                              ),
                                              title:
                                                  "editprofil_general_subtitle_primaryemail"
                                                      .tr(),
                                              onChanged: (value) {
                                                profile.userGeneralInfo.update =
                                                    true;

                                                profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .userGeneralInfo
                                                    .mail = value;

                                                setState(() {
                                                  value == ""
                                                      ? checkerEmail1ContactInfo =
                                                          true
                                                      : checkerEmail1ContactInfo =
                                                          regExpEmail
                                                              .hasMatch(value);
                                                  checkerEmail1Switch =
                                                      regExpEmail
                                                          .hasMatch(value);
                                                });
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: checkerEmail1Switch ==
                                                      false
                                                  ? DiseableCustomSwitch(
                                                      activeColor:
                                                          Color(0xff34C759),
                                                      value: false)
                                                  : CustomSwitch(
                                                      activeColor:
                                                          Color(0xff34C759),
                                                      value: profile
                                                                  .userGeneralInfo
                                                                  .subUsers[
                                                                      widget
                                                                          .index]
                                                                  .userGeneralInfo
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
                                                          profile
                                                              .userGeneralInfo
                                                              .subUsers[
                                                                  widget.index]
                                                              .userGeneralInfo
                                                              .preferenceUser
                                                              .includeMail1
                                                              .value = value ==
                                                                  true
                                                              ? '1'
                                                              : '0';
                                                        });
                                                        _switchAllowShareEmails =
                                                            value;
                                                      },
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                checkerEmail1ContactInfo
                                    ? Container()
                                    : Padding(
                                        padding:
                                            EdgeInsets.only(left: 2, top: 8.0),
                                        //check me
                                        child: MyText(
                                          value: "registration_info_email".tr(),
                                          fontSize: 12,
                                          color: ColorConstant.redColor,
                                        ) /*Text(
                                          "registration_info_email".tr(),
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.red,
                                          ),
                                        ),*/
                                        ),
                                SizedBox(
                                  height: 0.0 ?? 12.5,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8.0 ?? 12.5,
                                ),
                                role == 'child'
                                    ? profile.userGeneralInfo.mail2 != null &&
                                            profile.userGeneralInfo.mail2 != ''
                                        ? Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 11,
                                                //check me
                                                child: MyText(
                                                  value: profile.userGeneralInfo
                                                          .mail2 ??
                                                      ' ',
                                                ) /*Text(
                                                  profile.userGeneralInfo
                                                          .mail2 ??
                                                      ' ',
                                                  textScaleFactor: 1.0,
                                                )*/
                                                ,
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: profile.userGeneralInfo
                                                                  .mail2 ==
                                                              '' ||
                                                          profile.userGeneralInfo
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
                                                                      .subUsers[
                                                                          widget
                                                                              .index]
                                                                      .userGeneralInfo
                                                                      .preferenceUser
                                                                      .includeMail2
                                                                      .value ==
                                                                  "1"
                                                              ? true
                                                              : false,
                                                          onChanged: (value) {
                                                            profile
                                                                .userGeneralInfo
                                                                .update = true;

                                                            setState(() {
                                                              profile
                                                                  .userGeneralInfo
                                                                  .subUsers[
                                                                      widget
                                                                          .index]
                                                                  .userGeneralInfo
                                                                  .preferenceUser
                                                                  .includeMail2
                                                                  .value = value ==
                                                                      true
                                                                  ? '1'
                                                                  : '0';
                                                            });
                                                          },
                                                        ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container()
                                    : Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 11,
                                            child: MyTextField(
                                              initialValue: profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .userGeneralInfo
                                                  .mail2,
                                              maxline: 1,
                                              inputType:
                                                  TextInputType.multiline,
                                              editTextBgColor:
                                                  ColorConstant.textfieldColor,
                                              hintTextColor: Colors.white54,
                                              title:
                                                  "editprofil_general_subtitle_secondaryemail"
                                                      .tr(),
                                              onChanged: (value) {
                                                profile.userGeneralInfo.update =
                                                    true;

                                                profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .userGeneralInfo
                                                    .mail2 = value;

                                                setState(() {
                                                  value == ""
                                                      ? checkerEmail2ContactInfo =
                                                          true
                                                      : checkerEmail2ContactInfo =
                                                          regExpEmail
                                                              .hasMatch(value);
                                                  checkerEmail2Switch =
                                                      regExpEmail
                                                          .hasMatch(value);
                                                });
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: checkerEmail2Switch ==
                                                      false
                                                  ? DiseableCustomSwitch(
                                                      activeColor:
                                                          Color(0xff34C759),
                                                      value: false)
                                                  : CustomSwitch(
                                                      activeColor:
                                                          Color(0xff34C759),
                                                      value: profile
                                                                  .userGeneralInfo
                                                                  .subUsers[
                                                                      widget
                                                                          .index]
                                                                  .userGeneralInfo
                                                                  .preferenceUser
                                                                  .includeMail2
                                                                  .value ==
                                                              "1"
                                                          ? true
                                                          : false,
                                                      onChanged: (value) {
                                                        profile.userGeneralInfo
                                                            .update = true;

                                                        setState(() {
                                                          profile
                                                              .userGeneralInfo
                                                              .subUsers[
                                                                  widget.index]
                                                              .userGeneralInfo
                                                              .preferenceUser
                                                              .includeMail2
                                                              .value = value ==
                                                                  true
                                                              ? '1'
                                                              : '0';
                                                        });
                                                      },
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                checkerEmail2ContactInfo
                                    ? Container()
                                    : Padding(
                                        padding:
                                            EdgeInsets.only(left: 2, top: 8.0),
                                        //check me
                                        child: MyText(
                                          value: "registration_info_email".tr(),
                                          fontSize: 12,
                                          color: ColorConstant.redColor,
                                        ) /*Text(
                                          "registration_info_email".tr(),
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.red,
                                          ),
                                        )*/
                                        ,
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
                                MyText(
                                    value: "pets_label_livechatme".tr(),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: ColorConstant.textColor),
                                SizedBox(
                                  width: 40,
                                ),
                                Image.asset(
                                  "Assets/Images/info.png",
                                  height: 14,
                                  width: 14,
                                ),
                                SizedBox(
                                  width: 70,
                                ),
                                role == 'child'
                                    ? Expanded(
                                        flex: 4,
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: (profile.userGeneralInfo
                                                                .mail ==
                                                            null ||
                                                        profile.userGeneralInfo
                                                                .mail ==
                                                            '') &&
                                                    (profile.userGeneralInfo
                                                                .mail2 ==
                                                            '' ||
                                                        profile.userGeneralInfo
                                                                .mail2 ==
                                                            null)
                                                ? DiseableCustomSwitch(
                                                    activeColor:
                                                        Color(0xff34C759),
                                                    value: false)
                                                : CustomSwitch(
                                                    activeColor:
                                                        Color(0xff34C759),
                                                    value: profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .userGeneralInfo
                                                                .preferenceUser
                                                                .allowLiveChat
                                                                .value ==
                                                            "1"
                                                        ? true
                                                        : false,
                                                    onChanged: (value) {
                                                      profile.userGeneralInfo
                                                          .update = true;

                                                      print("VALUE : $value");
                                                      setState(() {
                                                        profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .userGeneralInfo
                                                                .preferenceUser
                                                                .allowLiveChat
                                                                .value =
                                                            value == true
                                                                ? '1'
                                                                : '0';
                                                      });
                                                    },
                                                  )),
                                      )
                                    : Expanded(
                                        flex: 4,
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: (profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .userGeneralInfo
                                                                .mail ==
                                                            null ||
                                                        profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .userGeneralInfo
                                                                .mail ==
                                                            '') &&
                                                    (profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .userGeneralInfo
                                                                .mail2 ==
                                                            '' ||
                                                        profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .userGeneralInfo
                                                                .mail2 ==
                                                            null)
                                                ? DiseableCustomSwitch(
                                                    activeColor:
                                                        Color(0xff34C759),
                                                    value: false)
                                                : CustomSwitch(
                                                    activeColor:
                                                        Color(0xff34C759),
                                                    value: profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .userGeneralInfo
                                                                .preferenceUser
                                                                .allowLiveChat
                                                                .value ==
                                                            "1"
                                                        ? true
                                                        : false,
                                                    onChanged: (value) {
                                                      print("VALUE : $value");
                                                      profile.userGeneralInfo
                                                          .update = true;

                                                      setState(() {
                                                        profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .userGeneralInfo
                                                                .preferenceUser
                                                                .allowLiveChat
                                                                .value =
                                                            value == true
                                                                ? '1'
                                                                : '0';
                                                      });
                                                    },
                                                  )),
                                      )
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
                            role == 'child' &&
                                    (profile.userGeneralInfo.mobile == null ||
                                        profile.userGeneralInfo.mobile == '')
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
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: KeyboardActions(
                                autoScroll: false,
                                disableScroll: true,
                                config: KeyboardActionsConfig(
                                    keyboardActionsPlatform:
                                        KeyboardActionsPlatform.ALL,
                                    actions: [
                                      KeyboardActionsItem(focusNode: codeFocus),
                                      KeyboardActionsItem(focusNode: nbreFocus),
                                    ]),
                                child: Row(children: <Widget>[
                                  role == 'child'
                                      ? Expanded(
                                          flex: 2,
                                          //check me
                                          child: MyText(
                                            value: profile.userGeneralInfo
                                                    .codePhone ??
                                                ' ',
                                          ) /*Text(
                                            profile.userGeneralInfo.codePhone ??
                                                ' ',
                                          )*/
                                          ,
                                        )
                                      : Expanded(
                                          flex: 4,
                                          child: MyTextField(
                                            maxline: 1,
                                            initialValue: profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .userGeneralInfo
                                                .codePhone,
                                            title: "pets_label_mobile".tr(),
                                            keyboardType: TextInputType.number,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            focusNode: codeFocus,
                                            hintTextColor: Colors.white54,
                                            onChanged: (value) {
                                              profile.userGeneralInfo.update =
                                                  true;

                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .userGeneralInfo
                                                  .codePhone = value;
                                            },
                                          ),
                                        ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  role == 'child'
                                      ? Expanded(
                                          flex: 10,
                                          // check me
                                          child: MyText(
                                            value: profile
                                                    .userGeneralInfo.mobile ??
                                                ' ',
                                          ) /*Text(
                                            profile.userGeneralInfo.mobile ??
                                                ' ',
                                            textScaleFactor: 1.0,
                                          ),*/
                                          )
                                      : Expanded(
                                          flex: 10,
                                          child: MyTextField(
                                            initialValue: profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .userGeneralInfo
                                                .mobile,
                                            title: "pets_label_cellnumber".tr(),
                                            maxline: 1,
                                            keyboardType: TextInputType.number,
                                            focusNode: nbreFocus,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintTextColor: Colors.white54,
                                            onChanged: (value) {
                                              setState(() {
                                                profile.userGeneralInfo.update =
                                                    true;

                                                profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .userGeneralInfo
                                                    .mobile = value;
                                              });
                                            },
                                          ),
                                        ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  role == 'child'
                                      ? profile.userGeneralInfo.mobile == '' ||
                                              profile.userGeneralInfo.mobile ==
                                                  null
                                          ? Container()
                                          : CustomSwitch(
                                              activeColor: Color(0xff34C759),
                                              value: profile
                                                          .userGeneralInfo
                                                          .subUsers[
                                                              widget.index]
                                                          .userGeneralInfo
                                                          .preferenceUser
                                                          .allowSharePhone
                                                          .value ==
                                                      "1"
                                                  ? true
                                                  : false,
                                              onChanged: (value) {
                                                profile.userGeneralInfo.update =
                                                    true;

                                                setState(() {
                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .preferenceUser
                                                      .allowSharePhone
                                                      .value = value ==
                                                          true
                                                      ? '1'
                                                      : '0';
                                                  _switchAllowMobile = value;
                                                });
                                              },
                                            )
                                      : profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .mobile !=
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .mobile !=
                                                  null
                                          ? DiseableCustomSwitch(
                                              activeColor: Color(0xff34C759),
                                              value: false)
                                          : CustomSwitch(
                                              activeColor: Color(0xff34C759),
                                              value: profile
                                                          .userGeneralInfo
                                                          .subUsers[
                                                              widget.index]
                                                          .userGeneralInfo
                                                          .preferenceUser
                                                          .allowSharePhone
                                                          .value ==
                                                      "1"
                                                  ? true
                                                  : false,
                                              onChanged: (value) {
                                                profile.userGeneralInfo.update =
                                                    true;

                                                setState(() {
                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .preferenceUser
                                                      .allowSharePhone
                                                      .value = value ==
                                                          true
                                                      ? '1'
                                                      : '0';
                                                  _switchAllowMobile = value;
                                                });
                                              },
                                            ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  role != 'Member'
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
                                  topRight: Radius.circular(8.0),
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
                                  _includeEmail(profile),
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
                                  _includePhone(profile),
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
                                  _includeName(profile),
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
                                  _includePicture(profile),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              )
            : Container(),
      ],
    );
  }

  _includePicture(Profile profile) {
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
                role == 'child'
                    ? CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile.userGeneralInfo.preferenceUser
                                    .allowSharePicture.value ==
                                "1"
                            ? true
                            : false,
                        onChanged: (value) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            profile
                                .userGeneralInfo
                                .preferenceUser
                                .allowSharePicture
                                .value = value == true ? '1' : '0';

                            _switchIncludePhone = value;
                          });
                        },
                      )
                    : CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile
                                    .userGeneralInfo
                                    .subUsers[widget.index]
                                    .userGeneralInfo
                                    .preferenceUser
                                    .allowSharePicture
                                    .value ==
                                "1"
                            ? true
                            : false,
                        onChanged: (value) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            profile
                                .userGeneralInfo
                                .subUsers[widget.index]
                                .userGeneralInfo
                                .preferenceUser
                                .allowSharePicture
                                .value = value == true ? '1' : '0';
                            _switchAllowPicture = value;
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

  _includeName(Profile profile) {
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
                role == 'child'
                    ? CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile.userGeneralInfo.preferenceUser
                                    .allowShareName.value ==
                                "1"
                            ? true
                            : false,
                        onChanged: (value) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            profile
                                .userGeneralInfo
                                .preferenceUser
                                .allowShareName
                                .value = value == true ? '1' : '0';

                            _switchIncludePhone = value;
                          });
                        },
                      )
                    : CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile
                                    .userGeneralInfo
                                    .subUsers[widget.index]
                                    .userGeneralInfo
                                    .preferenceUser
                                    .allowShareName
                                    .value ==
                                "1"
                            ? true
                            : false,
                        onChanged: (value) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            profile
                                .userGeneralInfo
                                .subUsers[widget.index]
                                .userGeneralInfo
                                .preferenceUser
                                .allowShareName
                                .value = value == true ? '1' : '0';
                            _switchIncludeName = value;
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

  _includeEmail(Profile profile) {
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
                role == 'child'
                    ? CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile.userGeneralInfo.preferenceUser
                                    .allowShareEmails.value ==
                                "1"
                            ? true
                            : false,
                        onChanged: (value) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            profile
                                .userGeneralInfo
                                .preferenceUser
                                .allowShareEmails
                                .value = value == true ? '1' : '0';

                            _switchIncludePhone = value;
                          });
                        },
                      )
                    : CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile
                                    .userGeneralInfo
                                    .subUsers[widget.index]
                                    .userGeneralInfo
                                    .preferenceUser
                                    .allowShareEmails
                                    .value ==
                                "1"
                            ? true
                            : false,
                        onChanged: (value) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            profile
                                .userGeneralInfo
                                .subUsers[widget.index]
                                .userGeneralInfo
                                .preferenceUser
                                .allowShareEmails
                                .value = value == true ? '1' : '0';
                            _switchIncludeMail = value;
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

  _includePhone(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: _switchIncludePhone
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
                role == 'child'
                    ? CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile.userGeneralInfo.preferenceUser
                                    .includeMobile.value ==
                                "1"
                            ? true
                            : false,
                        onChanged: (value) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            profile.userGeneralInfo.preferenceUser.includeMobile
                                .value = value == true ? '1' : '0';

                            _switchIncludePhone = value;
                          });
                        },
                      )
                    : CustomSwitch(
                        activeColor: Color(0xff34C759),
                        value: profile
                                    .userGeneralInfo
                                    .subUsers[widget.index]
                                    .userGeneralInfo
                                    .preferenceUser
                                    .includeMobile
                                    .value ==
                                "1"
                            ? true
                            : false,
                        onChanged: (value) {
                          profile.userGeneralInfo.update = true;

                          setState(() {
                            profile
                                .userGeneralInfo
                                .subUsers[widget.index]
                                .userGeneralInfo
                                .preferenceUser
                                .includeMobile
                                .value = value == true ? '1' : '0';

                            _switchIncludePhone = value;
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

  static showOverlayUpdate(BuildContext context, String headerMessage,
      String message, Profile profile, int index) {
    Navigator.of(context)
        .push(AlertDialogueUpdate(headerMessage, message, profile, index));
  }

  static showOverlay(
      BuildContext context, String headerMessage, String message) {
    Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  String message;
  bool checkerFirstName = true;
  bool checkerEmail1ContactInfo;
  bool checkerEmail2ContactInfo;

  bool checkerEmail1 = true;
  bool checkerEmail2 = true;
  bool checkerTel = true;
  int i;
  int j;
  int k;
  int l;
  int m;
  int n;
  int o;

  _editButton(Profile profile, int index) {
    return MyButton(
      title: "pets_label_save".tr(),
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
        i = 0;

        for (int p = 0; p < 5; p++) {
          if (profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                      .firstName !=
                  null &&
              profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                      .firstName !=
                  '') {
            if (regExpName.hasMatch(profile.userGeneralInfo
                    .subUsers[widget.index].userGeneralInfo.firstName) !=
                true) {
              checkerFirstName = false;
              message = "pets_label_verifyname".tr();
            }
          } else {
            checkerFirstName = false;
            message = "pets_label_verifyname".tr();
          }

          // MAIL
          if (profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                  .role !=
              4) {
            if (profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                        .mail !=
                    null &&
                profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                        .mail !=
                    '') {
              if (regExpEmail.hasMatch(profile.userGeneralInfo
                      .subUsers[widget.index].userGeneralInfo.mail) !=
                  true) {
                checkerEmail1 = false;
                contact = true;
                message = "pets_label_verifyprimarymail".tr();
              }
            } else {
              checkerEmail1 = false;
              contact = true;
              message = "pets_label_verifyprimarymail".tr();
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                      .mail2 !=
                  null &&
              profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                      .mail2 !=
                  '') {
            if (regExpEmail.hasMatch(profile.userGeneralInfo
                    .subUsers[widget.index].userGeneralInfo.mail2) !=
                true) {
              checkerEmail2 = false;
              message = "pets_label_verifysecondarymail".tr();
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                      .mobile !=
                  null &&
              profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                      .mobile !=
                  '') {
            if (regExpNumber.hasMatch(profile.userGeneralInfo
                    .subUsers[widget.index].userGeneralInfo.mobile) !=
                true) {
              checkerTel = false;
              message = "pets_label_verifyphone".tr();
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
              .userEmergencyContact.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                    .userEmergencyContact.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].firstName ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].lastName ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].mail ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].mail2 ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].mobile ==
                      '') {
                nombrebolckAlsoContact--;
                profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                    .userEmergencyContact
                    .removeAt(i);
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                    .userEmergencyContact.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].firstName !=
                      null &&
                  profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].firstName !=
                      '') {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .userGeneralInfo
                        .userEmergencyContact[i]
                        .firstName) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namealsocontact".tr() + ' ${i + 1}';
                }
              }
              if (profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].mail ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].mail ==
                      '') {
                checkerEmail1 = false;
                message =
                    "pets_label_primarymailalsocontact2".tr() + ' ${i + 1}';
              } else {
                if (regExpEmail.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .userGeneralInfo
                        .userEmergencyContact[i]
                        .mail) !=
                    true) {
                  checkerEmail1 = false;
                  message =
                      "pets_label_primarymailalsocontact2".tr() + ' ${i + 1}';
                }
              }
              if (profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].mail2 !=
                      null &&
                  profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].mail2 !=
                      '') {
                if (regExpEmail.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .userGeneralInfo
                        .userEmergencyContact[i]
                        .mail2) !=
                    true) {
                  checkerEmail2 = false;
                  message =
                      "pets_label_secondarymailalsocontact2".tr() + ' ${i + 1}';
                }
              }
              if (profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].mobile !=
                      null &&
                  profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                          .userEmergencyContact[i].mobile !=
                      '') {
                if (regExpNumber.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .userGeneralInfo
                        .userEmergencyContact[i]
                        .mobile) !=
                    true) {
                  checkerTel = false;
                  message = "pets_label_phonealsocontact2".tr() + ' ${i + 1}';
                }
              }
              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .userEmergencyContact.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .userEmergencyContact.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].firstName ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].lastName ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].mail ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].mail2 ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].mobile ==
                      '') {
                nombrebolckEmergencyContact--;
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .userEmergencyContact
                    .removeAt(i);
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .userEmergencyContact.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].firstName !=
                      null &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].firstName !=
                      '') {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .userEmergencyContact[i]
                        .firstName) !=
                    true) {
                  checkerFirstName = false;
                  message =
                      "pets_label_nameemergencycontact".tr() + ' ${i + 1}';
                }
              }
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].mail ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].mail ==
                      '') {
                checkerEmail1 = false;
                message =
                    "pets_label_primarymailemergencycontact".tr() + ' ${i + 1}';
              } else {
                if (regExpEmail.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .userEmergencyContact[i]
                        .mail) !=
                    true) {
                  checkerEmail1 = false;
                  message = "pets_label_primarymailemergencycontact".tr() +
                      ' ${i + 1}';
                }
              }

              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].mail2 !=
                      null &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].mail2 !=
                      '') {
                if (regExpEmail.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .userEmergencyContact[i]
                        .mail2) !=
                    true) {
                  checkerEmail2 = false;
                  message = "pets_label_secondarymailemergencycontact".tr() +
                      ' ${i + 1}';
                }
              }

              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].mobile !=
                      null &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .userEmergencyContact[i].mobile !=
                      '') {
                if (regExpNumber.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .userEmergencyContact[i]
                        .mobile) !=
                    true) {
                  checkerTel = false;
                  message =
                      "pets_label_phoneemergencycontact".tr() + ' ${i + 1}';
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .physicianContact.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .physicianContact.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].firstName ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].mail ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].mail2 ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].mobile ==
                      '') {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .physicianContact
                    .removeAt(i);
                userMedicalPhysicianEmergencyContacts.removeAt(i);
                nombrebolckPhysicianContact--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .physicianContact.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].firstName !=
                      null &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].firstName !=
                      '') {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .physicianContact[i]
                        .firstName) !=
                    true) {
                  checkerFirstName = false;
                  message =
                      "pets_label_namephysiciancontact".tr() + ' ${i + 1}';
                }
              }
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].mail ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].mail ==
                      '') {
                checkerEmail1 = false;
                message =
                    "pets_label_primarymailphysiciancontact".tr() + ' ${i + 1}';
              } else {
                if (regExpEmail.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .physicianContact[i]
                        .mail) !=
                    true) {
                  checkerEmail1 = false;
                  message = "pets_label_primarymailphysiciancontact".tr() +
                      ' ${i + 1}';
                }
              }

              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].mail2 !=
                      null &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].mail2 !=
                      '') {
                if (regExpEmail.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .physicianContact[i]
                        .mail2) !=
                    true) {
                  checkerEmail2 = false;
                  message = "pets_label_secondaryymailphysiciancontact".tr() +
                      " ${i + 1}";
                }
              }

              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].mobile !=
                      null &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .physicianContact[i].mobile !=
                      '') {
                if (regExpNumber.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .physicianContact[i]
                        .mobile) !=
                    true) {
                  checkerTel = false;
                  message =
                      "pets_label_phonephysiciancontact".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .insuranceInfo.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .insuranceInfo.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .insuranceInfo[i].insuranceCampanyName ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .insuranceInfo[i].additionalInformations ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .insuranceInfo[i].documents.length ==
                      0 &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .insuranceInfo[i].reminders.length ==
                      0) {
                userInsuranceInfo.removeAt(i);
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .insuranceInfo
                    .removeAt(i);
                nombrebolckInsurance--;
              } else {
                i++;
              }
            }

            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .insuranceInfo.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .insuranceInfo[i].insuranceCampanyName ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .insuranceInfo[i].insuranceCampanyName ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameinsuranceinfo".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .insuranceInfo[i]
                        .insuranceCampanyName) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameinsuranceinfo".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .miscilanious.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .miscilanious.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .miscilanious[i].label ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .miscilanious[i].description ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .miscilanious[i].documents.length ==
                      0 &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .miscilanious[i].reminders.length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .miscilanious
                    .removeAt(i);
                userMiscelaneous.removeAt(i);
                nombrebolckMiscelaneous--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .miscilanious.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .miscilanious[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .miscilanious[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namemiscilanious".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .miscilanious[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namemiscilanious".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .otherMedicalRecordInfo.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .otherMedicalRecordInfo.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .otherMedicalRecordInfo[i].label ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .otherMedicalRecordInfo[i].description ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .otherMedicalRecordInfo[i].documents.length ==
                      0 &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .otherMedicalRecordInfo[i].reminder.length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .otherMedicalRecordInfo
                    .removeAt(i);
                nombrebolckOther--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .otherMedicalRecordInfo.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .otherMedicalRecordInfo[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .otherMedicalRecordInfo[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameotherinfo".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .otherMedicalRecordInfo[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameotherinfo".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .medicalDiseaces.infectionDisaces.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.infectionDisaces.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.infectionDisaces.blocks[i].label ==
                      '' &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .infectionDisaces
                          .blocks[i]
                          .description ==
                      '' &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .infectionDisaces
                          .blocks[i]
                          .documents
                          .length ==
                      0 &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .infectionDisaces
                          .blocks[i]
                          .reminders
                          .length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.infectionDisaces.blocks
                    .removeAt(i);
                userMedicalDiseacesInfectionDisaces.removeAt(i);
                nombrebolckInfectiousDesease--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.infectionDisaces.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.infectionDisaces.blocks[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.infectionDisaces.blocks[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameinfectiondiseace".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .medicalDiseaces
                        .infectionDisaces
                        .blocks[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message =
                      "pets_label_nameinfectiondiseace".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .medicalDiseaces.allergies.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.allergies.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.allergies.blocks[i].label ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.allergies.blocks[i].description ==
                      '' &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .allergies
                          .blocks[i]
                          .documents
                          .length ==
                      0 &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .allergies
                          .blocks[i]
                          .reminders
                          .length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.allergies.blocks
                    .removeAt(i);
                userMedicalDiseacesAllergies.removeAt(i);
                nombrebolckAllergies--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.allergies.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.allergies.blocks[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.allergies.blocks[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameallergie".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .medicalDiseaces
                        .allergies
                        .blocks[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameallergie".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .medicalDiseaces.implants.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.implants.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.implants.blocks[i].label ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.implants.blocks[i].description ==
                      '' &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .implants
                          .blocks[i]
                          .documents
                          .length ==
                      0 &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .implants
                          .blocks[i]
                          .reminders
                          .length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.implants.blocks
                    .removeAt(i);
                userMedicalDiseacesImplants.removeAt(i);
                nombrebolckImplant--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.implants.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.implants.blocks[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.implants.blocks[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameimplants".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .medicalDiseaces
                        .implants
                        .blocks[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameimplants".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .medicalDiseaces.renalKenedy.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.renalKenedy.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.renalKenedy.blocks[i].label ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.renalKenedy.blocks[i].description ==
                      '' &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .renalKenedy
                          .blocks[i]
                          .documents
                          .length ==
                      0 &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .renalKenedy
                          .blocks[i]
                          .reminders
                          .length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.renalKenedy.blocks
                    .removeAt(i);
                userMedicalDiseacesRenal.removeAt(i);
                nombrebolckRenal--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.renalKenedy.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.renalKenedy.blocks[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.renalKenedy.blocks[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namerenalkenedy".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .medicalDiseaces
                        .renalKenedy
                        .blocks[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namerenalkenedy".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .medicalDiseaces.cardiac.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.cardiac.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cardiac.blocks[i].label ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cardiac.blocks[i].description ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cardiac.blocks[i].documents.length ==
                      0 &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cardiac.blocks[i].reminders.length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.cardiac.blocks
                    .removeAt(i);
                userMedicalDiseacesCardiac.removeAt(i);
                nombrebolckCardiac--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.cardiac.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cardiac.blocks[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cardiac.blocks[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namecardiac".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .medicalDiseaces
                        .cardiac
                        .blocks[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namecardiac".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .medicalDiseaces.psychiatric.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.psychiatric.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.psychiatric.blocks[i].label ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.psychiatric.blocks[i].description ==
                      '' &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .psychiatric
                          .blocks[i]
                          .documents
                          .length ==
                      0 &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .psychiatric
                          .blocks[i]
                          .reminders
                          .length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.psychiatric.blocks
                    .removeAt(i);
                userMedicalDiseacesPsychiatric.removeAt(i);
                nombrebolckPsychiatric--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.psychiatric.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.psychiatric.blocks[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.psychiatric.blocks[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namepsychiatric".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .medicalDiseaces
                        .psychiatric
                        .blocks[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namepsychiatric".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .medicalDiseaces.neuroligic.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.neuroligic.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.neuroligic.blocks[i].label ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.neuroligic.blocks[i].description ==
                      '' &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .neuroligic
                          .blocks[i]
                          .documents
                          .length ==
                      0 &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .neuroligic
                          .blocks[i]
                          .reminders
                          .length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.neuroligic.blocks
                    .removeAt(i);
                nombrebolckNeurologic--;
                userMedicalDiseacesNeurologic.removeAt(i);
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.neuroligic.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.neuroligic.blocks[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.neuroligic.blocks[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameneurologic".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .medicalDiseaces
                        .neuroligic
                        .blocks[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameneurologic".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .medicalDiseaces.plumonary.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.plumonary.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.plumonary.blocks[i].label ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.plumonary.blocks[i].description ==
                      '' &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .plumonary
                          .blocks[i]
                          .documents
                          .length ==
                      0 &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .plumonary
                          .blocks[i]
                          .reminders
                          .length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.plumonary.blocks
                    .removeAt(i);
                userMedicalDiseacesPlumonary.removeAt(i);
                nombrebolckPulmonary--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.plumonary.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.plumonary.blocks[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.plumonary.blocks[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameplumonary".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .medicalDiseaces
                        .plumonary
                        .blocks[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameplumonary".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .medicalDiseaces.medication.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.medication.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.medication.blocks[i].label ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.medication.blocks[i].description ==
                      '' &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .medication
                          .blocks[i]
                          .documents
                          .length ==
                      0 &&
                  profile
                          .userGeneralInfo
                          .subUsers[widget.index]
                          .medicalRecord
                          .medicalDiseaces
                          .medication
                          .blocks[i]
                          .reminders
                          .length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.medication.blocks
                    .removeAt(i);
                userMedicalDiseacesMedication.removeAt(i);
                nombrebolckMedication--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.medication.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.medication.blocks[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.medication.blocks[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namemedication".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .medicalDiseaces
                        .medication
                        .blocks[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namemedication".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
              .medicalDiseaces.cancer.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.cancer.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cancer.blocks[i].label ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cancer.blocks[i].description ==
                      '' &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cancer.blocks[i].documents.length ==
                      0 &&
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cancer.blocks[i].reminders.length ==
                      0) {
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.cancer.blocks
                    .removeAt(i);
                userMedicalDiseacesCancer.removeAt(i);
                nombrebolckCancer--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                    .medicalDiseaces.cancer.blocks.length) {
              if (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cancer.blocks[i].label ==
                      null ||
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                          .medicalDiseaces.cancer.blocks[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namecancer".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo
                        .subUsers[widget.index]
                        .medicalRecord
                        .medicalDiseaces
                        .cancer
                        .blocks[i]
                        .label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namecancer".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }
        }

        if (checkerFirstName == false ||
            checkerEmail1 == false ||
            checkerEmail2 == false ||
            checkerTel == false) {
          showOverlay(context, "problem_infos".tr(), message);
        } else {
          profile.parameters.newUser = false;
          profile.userGeneralInfo.update = false;
          profile.parameters.location = 'Save sub user';
          dispatchEditProfile(profile, index);
        }
      },
    );
  }

  _deleteButton(Profile profile, int index) {
    return MyButton(
      title: "editprofil_medical_btn_deleteuser".tr(),
      height: 46.0,
      titleSize: 14,
      cornerRadius: 8,
      fontWeight: FontWeight.w600,
      titleColor: Color(0xffEC1C40),
      btnBgColor: ColorConstant.boxColor,
      onPressed: () {
        if (profile.parameters.newUser == true) {
          profile.userGeneralInfo.subUsers.removeAt(index);
          Navigator.of(context).pushReplacementNamed(
            '/homeProvider',
            arguments: profile,
          );
        } else {
          dispatchDeleteProfile(profile, widget.index);
        }
      },
      miniWidth: null,
    );
  }

  nameMember(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              border: contact || _GenerlInfoStatus(profile, widget.index)
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
              color: nameUser || _nameChild(profile, widget.index)
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
                  _scrollController.jumpTo(0);
                  //  _scrollController.jumpTo(20);
                  nameUser = !nameUser;
                  alsoInfo = false;
                  contact = false;
                  advancedSettings = false;
                  memebrs = false;
                  medicInfo = false;
                  persInfo = false;
                  medicalTag = false;
                  viewExport = false;
                  emegInfo = false;

                  contact = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: Image.asset(
                        "Assets/Images/nameIcon.png",
                        height: 32,
                        width: 31,
                        color: nameUser || _nameChild(profile, widget.index)
                            ? null
                            : ColorConstant.textBlockVide,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                              value: "pets_label_name".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color:
                                  nameUser || _nameChild(profile, widget.index)
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
                    nameUser
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
        nameUser
            ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
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
                      color: lockSreen
                          ? ColorConstant.pinkColor
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
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 10, top: 10.9, bottom: 8.7),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: MyTextField(
                              initialValue: profile
                                  .userGeneralInfo
                                  .subUsers[widget.index]
                                  .userGeneralInfo
                                  .firstName,
                              maxline: 1,
                              inputType: TextInputType.number,
                              title: "editprofil_general_label_firstname".tr(),
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              decoration: InputDecoration(
                                errorText: _validate
                                    ? "editprofil_general_label_errormsg".tr()
                                    : null,
                              ),
                              onChanged: (value) {
                                profile.userGeneralInfo.update = true;
                                profile.userGeneralInfo.subUsers[widget.index]
                                    .userGeneralInfo.firstName = value;
                                print(profile.userGeneralInfo.firstName);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            flex: 2,
                            child: MyTextField(
                              initialValue: profile
                                  .userGeneralInfo
                                  .subUsers[widget.index]
                                  .userGeneralInfo
                                  .lastName,
                              maxline: 1,
                              inputType: TextInputType.number,
                              title: "editprofil_general_label_lastname".tr(),
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              onChanged: (value) {
                                setState(() {
                                  profile.userGeneralInfo.update = true;

                                  profile.userGeneralInfo.subUsers[widget.index]
                                      .userGeneralInfo.lastName = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),

                          // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  //MY Also Contact
  alsoInfos(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              border: alsoInfo || _alsoInfoStatus(profile, widget.index)
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
              color: alsoInfo || _alsoInfoStatus(profile, widget.index)
                  ? ColorConstant.pinkColor
                  : ColorConstant.colorBlockVide,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(alsoInfo ? 0 : 8.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(alsoInfo ? 0 : 8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _scrollController.jumpTo(65);

                  alsoInfo = !alsoInfo;
                  contact = false;
                  advancedSettings = false;
                  memebrs = false;
                  medicInfo = false;
                  persInfo = false;
                  medicalTag = false;
                  viewExport = false;
                  emegInfo = false;

                  contact = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: Image.asset("Assets/Images/Also.png",
                          height: 32,
                          width: 31,
                          color:
                              alsoInfo || _alsoInfoStatus(profile, widget.index)
                                  ? null
                                  : ColorConstant.textBlockVide),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                                value:
                                    "editprofil_general_subtitle_contact".tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: alsoInfo ||
                                        _alsoInfoStatus(profile, widget.index)
                                    ? ColorConstant.whiteTextColor
                                    : ColorConstant.textBlockVide),
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
                    alsoInfo
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
        alsoInfo
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
                        alsoContacts(profile),
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

  alsoContactsChild(Profile profile) {
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
              child: Container(
            height: 49,
            decoration: BoxDecoration(
                border: Border.all(width: 0, color: ColorConstant.boxColor),
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(alsoContact ? 0 : 5.0))),
            child: Padding(
              padding: EdgeInsets.only(top: 17, bottom: 17),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 11, right: 21),
                    child: MyText(
                        value: "pets_label_contact".tr(),
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
        !alsoContact
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
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 16),
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
                          itemCount: profile
                              .userGeneralInfo
                              .subUsers[widget.index]
                              .userGeneralInfo
                              .userEmergencyContact
                              .length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              SizedBox(width: 30),
                              ExpandableAlsoContactListChild(
                                  key: Key(profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .userGeneralInfo
                                      .userEmergencyContact[index]
                                      .firstName),
                                  userEmergencyContactUser: profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .userGeneralInfo
                                      .userEmergencyContact[index],
                                  userEmergencyContactMedicalUser: profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .medicalRecord
                                      .userEmergencyContact[index],
                                  dropdownValue: profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .userGeneralInfo
                                              .userEmergencyContact[index]
                                              .active ==
                                          1
                                      ? true
                                      : false,
                                  index: index,
                                  addAlsoBlockChild: addBlockChild,
                                  update: profile.userGeneralInfo.update,
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
                              visible: _visi,
                              child: Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ButtonTheme(
                                      height: 36.0,
                                      minWidth: 280.5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: RaisedButton(
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.white,
                                        color: Colors.white,
                                        textColor: ColorConstant.pinkColor,
                                        //check me
                                        child: MyText(
                                          value: "editprofil_general_btn_addnew"
                                              .tr(),
                                          color: ColorConstant.pinkColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ) /*Text("editprofil_general_btn_addnew".tr(),
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )
                                        )*/
                                        ,
                                        onPressed: nombrebolckAlsoContact <
                                                nbblock
                                            ? () {
                                                setState(() {
                                                  widget.profile.userGeneralInfo
                                                      .update = true;
                                                  nombrebolckAlsoContact++;
                                                  for (int i = 0;
                                                      i < addBlockChild.length;
                                                      i++) {
                                                    if (addBlockChild[i] ==
                                                        true) {
                                                      addBlockChild[i] = false;
                                                    }
                                                  }
                                                  addEmergencyChild.add(false);
                                                  addBlockChild.add(true);

                                                  UserEmergencyContact
                                                      alsoContMSUb =
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
                                                  UserEmergencyContact
                                                      alsoContGSub =
                                                      UserEmergencyContact(
                                                    id: 0,
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

                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact
                                                      .add(alsoContGSub);

                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .medicalRecord
                                                      .userEmergencyContact
                                                      .add(alsoContMSUb);
                                                });
                                              }
                                            : null,
                                      )),
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

  alsoContacts(Profile profile) {
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
                  bottomLeft: Radius.circular(alsoContact ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              child: Container(
            height: 49,
            decoration: BoxDecoration(
                border: Border.all(width: 0, color: ColorConstant.boxColor),
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(alsoContact ? 0 : 5.0))),
            child: Padding(
              padding: EdgeInsets.only(top: 17, bottom: 17),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 11, right: 21),
                    child: MyText(
                        value: "pets_label_contact".tr(),
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
        !alsoContact
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
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 16),
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
                          itemCount: profile
                              .userGeneralInfo
                              .subUsers[widget.index]
                              .userGeneralInfo
                              .userEmergencyContact
                              .length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visi,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.red, //button colour
                                        child: InkWell(
                                            splashColor: Colors
                                                .red, // inkwell onPress colour
                                            child: SizedBox(
                                                width: 24,
                                                height:
                                                    24, //customisable size of 'button'
                                                child: Center(
                                                    child: FaIcon(
                                                  FontAwesomeIcons.minus,
                                                  color: Colors.white,
                                                  size: 16,
                                                ))),
                                            onTap: () {
                                              setState(() {
                                                profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .userGeneralInfo
                                                    .userEmergencyContact
                                                    .removeAt(index);
                                                profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .userEmergencyContact
                                                    .removeAt(index);
                                                nombrebolckAlsoContact = profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .userGeneralInfo
                                                    .userEmergencyContact
                                                    .length;

                                                if (profile
                                                        .userGeneralInfo
                                                        .subUsers[widget.index]
                                                        .userGeneralInfo
                                                        .userEmergencyContact
                                                        .length ==
                                                    0) {
                                                  _visi = true;
                                                }
                                                // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                              });
                                            })),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              ExpandableAlsoContactList(
                                  key: Key(profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .userGeneralInfo
                                      .userEmergencyContact[index]
                                      .firstName),
                                  index: index,
                                  alsoBlockContact: addBlockChild,
                                  emergencyContactMedical: profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .medicalRecord
                                      .userEmergencyContact[index],
                                  userEmergencyContact: profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .userGeneralInfo
                                      .userEmergencyContact[index],
                                  dropdownValue: true,
                                  update: true,
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
                        profile
                                    .userGeneralInfo
                                    .subUsers[widget.index]
                                    .userGeneralInfo
                                    .userEmergencyContact
                                    .length ==
                                0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "editprofil_general_subtitle_contact".tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.pinkColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckAlsoContact < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckAlsoContact++;
                                          addBlockChild.add(true);
                                          addBlockEmergency.add(false);
                                          UserEmergencyContact alsoContG =
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
                                          UserEmergencyContact alsoContM =
                                              UserEmergencyContact(
                                            id: 0,
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

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .userGeneralInfo
                                              .userEmergencyContact
                                              .add(alsoContG);
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .userEmergencyContact
                                              .add(alsoContM);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
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
                                              child: MyText(
                                                value:
                                                    "editprofil_general_btn_addnew"
                                                        .tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: ColorConstant.pinkColor,
                                              ),
                                              onPressed:
                                                  nombrebolckAlsoContact <
                                                          nbblock
                                                      ? () {
                                                          setState(() {
                                                            nombrebolckAlsoContact++;
                                                            for (int i = 0;
                                                                i <
                                                                    addBlockChild
                                                                        .length;
                                                                i++) {
                                                              if (addBlockChild[
                                                                      i] ==
                                                                  true) {
                                                                addBlockChild[
                                                                    i] = false;
                                                              }
                                                            }
                                                            addBlockEmergency
                                                                .add(false);
                                                            addBlockChild
                                                                .add(true);
                                                            UserEmergencyContact
                                                                alsoContG =
                                                                UserEmergencyContact(
                                                              active: 1,
                                                              allowChat: 0,
                                                              allowMail1: 0,
                                                              allowMail2: 0,
                                                              allowMobile: 0,
                                                              codePhone: '',
                                                              codePhoneCountry:
                                                                  '',
                                                              firstName: '',
                                                              lastName: '',
                                                              mail: '',
                                                              mail2: '',
                                                              mobile: '',
                                                              tel: '',
                                                            );
                                                            UserEmergencyContact
                                                                alsoContM =
                                                                UserEmergencyContact(
                                                              id: 0,
                                                              active: 1,
                                                              allowChat: 0,
                                                              allowMail1: 0,
                                                              allowMail2: 0,
                                                              allowMobile: 0,
                                                              codePhone: '',
                                                              codePhoneCountry:
                                                                  '',
                                                              firstName: '',
                                                              lastName: '',
                                                              mail: '',
                                                              mail2: '',
                                                              mobile: '',
                                                              tel: '',
                                                            );

                                                            profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .userGeneralInfo
                                                                .userEmergencyContact
                                                                .add(alsoContG);
                                                            profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .medicalRecord
                                                                .userEmergencyContact
                                                                .add(alsoContM);
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
                                              child: MyText(
                                                value:
                                                    "editprofil_general_btn_delete"
                                                        .tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: ColorConstant.pinkColor,
                                              ),
                                              onPressed: profile
                                                          .userGeneralInfo
                                                          .subUsers[
                                                              widget.index]
                                                          .userGeneralInfo
                                                          .userEmergencyContact
                                                          .length !=
                                                      0
                                                  ? () {
                                                      setState(() {
                                                        _visi = false;
                                                        _visibile = _visi;
                                                      });
                                                    }
                                                  : null,
                                            )),
                                      ),
                                    ),
                                  ),
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
                                                child: MyText(
                                                  value:
                                                      "editprofil_general_btn_delete"
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      ColorConstant.pinkColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visi = !_visi;

                                                    _visibile = !_visibile;
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

  //adavanced settings
  // ignore: non_constant_identifier_names
  _AdvancedSettings(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              border: advancedSettings || _ThankYouStatus(profile, widget.index)
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
              color: advancedSettings || _ThankYouStatus(profile, widget.index)
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
                  advancedSettings = !advancedSettings;
                  _scrollController.jumpTo(110);

                  memebrs = false;
                  medicInfo = false;
                  persInfo = false;
                  medicalTag = false;
                  viewExport = false;
                  emegInfo = false;
                  alsoInfo = false;
                  contact = false;
                  userRights = false;
                  thankyou = false;
                  userInfoChild = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: Image.asset("Assets/Images/settings.png",
                          height: 32,
                          width: 31,
                          color: advancedSettings ||
                                  _ThankYouStatus(profile, widget.index)
                              ? null
                              : ColorConstant.textBlockVide),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                                value: "pets_label_settings".tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: advancedSettings ||
                                        _ThankYouStatus(profile, widget.index)
                                    ? ColorConstant.whiteTextColor
                                    : ColorConstant.textBlockVide),
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
                    advancedSettings
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
        advancedSettings
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
                        role != 'child' ? _LockSreeen() : Container(),
                        SizedBox(height: 12),
                        _thankyou(profile),
                        SizedBox(height: 12),
                        role == 'child'
                            ? _shareInformation(profile)
                            : Container(),
                        role == 'child' ? SizedBox(height: 12) : Container(),
                        role == 'child'
                            ? _MedicalInfoProtection()
                            : Container(),
                        role == 'child' ? SizedBox(height: 12) : Container(),
                        Column(
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
                                      bottomLeft:
                                          Radius.circular(userRights ? 0 : 5.0),
                                      topRight: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0))),
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      userRights = !userRights;
                                      thankyou = false;
                                      userInfoChild = false;
                                    });
                                  },
                                  child: Container(
                                    height: 49,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0,
                                            color: ColorConstant.boxColor),
                                        color: ColorConstant.boxColor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8.0),
                                            bottomRight: Radius.circular(
                                                userRights ? 0 : 5.0))),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 12.5),
                                        ),
                                        MyText(
                                            value: "editprofil_label_userrights"
                                                .tr(),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor),
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
                                        userRights
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
                            userRights
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
                                          border: Border.all(
                                              width: 0,
                                              color: ColorConstant.boxColor),
                                          color: ColorConstant.boxColor,
                                          borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(8.0))),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.5,
                                            right: 20.5,
                                            bottom: 12.5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              height: 0.45,
                                              color: ColorConstant.dividerColor,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: _switchIncludePhone
                                                          ? ColorConstant
                                                              .boxColor
                                                          : ColorConstant
                                                              .boxColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      5.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      5.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      5.0))),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .boxColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        5.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        5.0))),
                                                    child: maxNombreAdmin ==
                                                                true &&
                                                            profile
                                                                    .userGeneralInfo
                                                                    .subUsers[
                                                                        widget
                                                                            .index]
                                                                    .userGeneralInfo
                                                                    .role !=
                                                                2
                                                        ? Row(
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Row(
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                11,
                                                                            right:
                                                                                21),
                                                                        child: MyText(
                                                                            value: "editprofil_label_administrator"
                                                                                .tr(),
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                ColorConstant.greyTextColor),
                                                                        // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                                                                      ),
                                                                    ),
                                                                    Image.asset(
                                                                      "Assets/Images/info.png",
                                                                      height:
                                                                          14,
                                                                      width: 14,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),

                                                              SizedBox(
                                                                width: 14,
                                                              )
                                                            ],
                                                          )
                                                        : Row(
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Row(
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                11,
                                                                            right:
                                                                                21),
                                                                        child: MyText(
                                                                            value: "editprofil_label_administrator"
                                                                                .tr(),
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                ColorConstant.textColor),
                                                                        // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                                                                      ),
                                                                    ),
                                                                    Image.asset(
                                                                      "Assets/Images/info.png",
                                                                      height:
                                                                          14,
                                                                      width: 14,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),
                                                              CustomSwitch(
                                                                key: Key(profile
                                                                    .userGeneralInfo
                                                                    .subUsers[
                                                                        widget
                                                                            .index]
                                                                    .userGeneralInfo
                                                                    .role
                                                                    .toString()),
                                                                activeColor: Color(
                                                                    0xff34C759),
                                                                value:
                                                                    roleAdmin,
                                                                onChanged:
                                                                    (value) {
                                                                  /*        if (value ) {
                                                                     Navigator.of(context).push(AccountOverlay(
                                                                        profile,
                                                                        widget
                                                                            .index,
                                                                        roleChild,
                                                                        roleMember,
                                                                        value,
                                                                        context));
                                                                    setState(
                                                                        () {});
                                                                  } */

                                                                  profile
                                                                      .userGeneralInfo
                                                                      .update = true;
                                                                  int i = 0;
                                                                  profile
                                                                      .userGeneralInfo
                                                                      .subUsers
                                                                      .forEach(
                                                                          (element) {
                                                                    if (element.userGeneralInfo.role ==
                                                                            2 &&
                                                                        profile.userGeneralInfo.role ==
                                                                            2) {
                                                                      i++;
                                                                    }
                                                                  });
                                                                  if (i == 1) {
                                                                    maxNombreAdmin =
                                                                        true;
                                                                  } else {
                                                                    maxNombreAdmin =
                                                                        false;
                                                                  }
                                                                  setState(() {
                                                                    if (value ==
                                                                        true) {
                                                                      setState(
                                                                          () {
                                                                        profile
                                                                            .userGeneralInfo
                                                                            .subUsers[widget.index]
                                                                            .userGeneralInfo
                                                                            .role = 2;
                                                                        profile
                                                                            .userGeneralInfo
                                                                            .subUsers[widget.index]
                                                                            .userGeneralInfo
                                                                            .roleLabel = 'Administrator';
                                                                        roleChild =
                                                                            false;
                                                                        roleMember =
                                                                            false;
                                                                      });
                                                                      setState(
                                                                          () {
                                                                        print(
                                                                            roleChild);
                                                                      });
                                                                    } else {
                                                                      setState(
                                                                          () {});
                                                                    }
                                                                  });

                                                                  setState(
                                                                      () {});
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
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Container(
                                              height: 0.45,
                                              color: ColorConstant.dividerColor,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: _switchIncludePhone
                                                          ? ColorConstant
                                                              .boxColor
                                                          : ColorConstant
                                                              .boxColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      5.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      5.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      5.0))),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .boxColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        5.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        5.0))),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Row(
                                                            children: [
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 11,
                                                                      right:
                                                                          21),
                                                                  child: MyText(
                                                                      value: "editprofil_label_member"
                                                                          .tr(),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14,
                                                                      color: ColorConstant
                                                                          .textColor),
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
                                                        CustomSwitch(
                                                          key: Key(profile
                                                              .userGeneralInfo
                                                              .subUsers[
                                                                  widget.index]
                                                              .userGeneralInfo
                                                              .role
                                                              .toString()),
                                                          activeColor:
                                                              Color(0xff34C759),
                                                          value: roleMember,
                                                          onChanged: (value) {
                                                            profile
                                                                .userGeneralInfo
                                                                .update = true;

                                                            setState(() {
                                                              if (value ==
                                                                  true) {
                                                                setState(() {
                                                                  profile
                                                                      .userGeneralInfo
                                                                      .subUsers[
                                                                          widget
                                                                              .index]
                                                                      .userGeneralInfo
                                                                      .role = 3;
                                                                  profile
                                                                      .userGeneralInfo
                                                                      .subUsers[
                                                                          widget
                                                                              .index]
                                                                      .userGeneralInfo
                                                                      .roleLabel = 'Member';
                                                                });
                                                                setState(() {
                                                                  int i = 0;
                                                                  profile
                                                                      .userGeneralInfo
                                                                      .subUsers
                                                                      .forEach(
                                                                          (element) {
                                                                    if (element.userGeneralInfo.role ==
                                                                            2 &&
                                                                        profile.userGeneralInfo.role ==
                                                                            2) {
                                                                      i++;
                                                                    }
                                                                  });
                                                                  if (i == 1) {
                                                                    maxNombreAdmin =
                                                                        true;
                                                                  } else {
                                                                    maxNombreAdmin =
                                                                        false;
                                                                  }
                                                                });
                                                              } else {
                                                                setState(() {});
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
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Container(
                                              height: 0.45,
                                              color: ColorConstant.dividerColor,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: _switchIncludePhone
                                                          ? ColorConstant
                                                              .boxColor
                                                          : ColorConstant
                                                              .boxColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      5.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      5.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      5.0))),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .boxColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        5.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        5.0))),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Row(
                                                            children: [
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 11,
                                                                      right:
                                                                          21),
                                                                  child: MyText(
                                                                      value: "editprofil_label_child"
                                                                          .tr(),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14,
                                                                      color: ColorConstant
                                                                          .textColor),
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
                                                        CustomSwitch(
                                                          key: Key(profile
                                                              .userGeneralInfo
                                                              .subUsers[
                                                                  widget.index]
                                                              .userGeneralInfo
                                                              .role
                                                              .toString()),
                                                          activeColor:
                                                              Color(0xff34C759),
                                                          value: roleChild,
                                                          onChanged: (value) {
                                                            profile
                                                                .userGeneralInfo
                                                                .update = true;

                                                            setState(() {
                                                              if (value ==
                                                                  true) {
                                                                setState(() {
                                                                  profile
                                                                      .userGeneralInfo
                                                                      .subUsers[
                                                                          widget
                                                                              .index]
                                                                      .userGeneralInfo
                                                                      .userEmergencyContact = profile.userGeneralInfo.userEmergencyContact;
                                                                  profile
                                                                      .userGeneralInfo
                                                                      .subUsers[
                                                                          widget
                                                                              .index]
                                                                      .medicalRecord
                                                                      .userEmergencyContact = profile.userGeneralInfo.userEmergencyContact;
                                                                  profile
                                                                      .userGeneralInfo
                                                                      .subUsers[
                                                                          widget
                                                                              .index]
                                                                      .medicalRecord
                                                                      .userEmergencyContact
                                                                      .forEach(
                                                                          (element) {
                                                                    setState(
                                                                        () {
                                                                      addEmergencyChild
                                                                          .add(
                                                                              false);
                                                                    });
                                                                  });
                                                                  profile
                                                                      .userGeneralInfo
                                                                      .subUsers[
                                                                          widget
                                                                              .index]
                                                                      .userGeneralInfo
                                                                      .userEmergencyContact
                                                                      .forEach(
                                                                          (element) {
                                                                    setState(
                                                                        () {
                                                                      addBlockChild
                                                                          .add(
                                                                              false);
                                                                    });
                                                                  });

                                                                  profile
                                                                      .userGeneralInfo
                                                                      .subUsers[
                                                                          widget
                                                                              .index]
                                                                      .userGeneralInfo
                                                                      .role = 4;
                                                                  profile
                                                                      .userGeneralInfo
                                                                      .subUsers[
                                                                          widget
                                                                              .index]
                                                                      .userGeneralInfo
                                                                      .roleLabel = 'Child / Vulnerable';
                                                                });
                                                                setState(() {
                                                                  int i = 0;
                                                                  profile
                                                                      .userGeneralInfo
                                                                      .subUsers
                                                                      .forEach(
                                                                          (element) {
                                                                    if (element.userGeneralInfo.role ==
                                                                            2 &&
                                                                        profile.userGeneralInfo.role ==
                                                                            2) {
                                                                      i++;
                                                                    }
                                                                  });
                                                                  if (i == 1) {
                                                                    maxNombreAdmin =
                                                                        true;
                                                                  } else {
                                                                    maxNombreAdmin =
                                                                        false;
                                                                  }
                                                                });
                                                              } else {
                                                                setState(() {});
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
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
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

  _LockSreeen() {
    return Container(
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
              // lockSreen ? ColorConstant.pinkColor :
              ColorConstant.boxColor,
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
        child: Padding(
          padding: EdgeInsets.only(top: 8.9, bottom: 8.7),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 11, right: 21),
                child: MyText(
                    value: "editprofil_general_subtitle_lockscreen".tr(),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color:
                        //  lockSreen
                        //     ? ColorConstant.textColor
                        // :
                        ColorConstant.darkGray),
                // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _MedicalInfoProtection() {
    return Container(
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
          color: lockSreen ? ColorConstant.pinkColor : ColorConstant.boxColor,
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
        child: Padding(
          padding: EdgeInsets.only(top: 8.9, bottom: 8.7),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 11, right: 21),
                child: MyText(
                    value: "editprofil_medical_bloctitle_medicalinfoprotection"
                        .tr(),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: lockSreen
                        ? ColorConstant.textColor
                        : ColorConstant.darkGray),
                // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _thankyou(Profile profile) {
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
              color: thankyou || _ThankYouStatus(profile, widget.index)
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
                  userRights = false;
                  userInfoChild = false;
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
                        value: profile.userGeneralInfo.subUsers[widget.index]
                                    .userGeneralInfo.role !=
                                4
                            ? "editprofil_general_bloctitle_thankyoumsg".tr()
                            : "editprofil_special_bloctitle_thankyoumsg".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color:
                            thankyou || _ThankYouStatus(profile, widget.index)
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
                            value:
                                "editprofil_general_blocinfo_someonefinds".tr(),
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
                                offset:
                                    Offset(0, 0), // changes position of shadow
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
                                  .subUsers[widget.index]
                                  .userGeneralInfo
                                  .custumMessage,
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
/* buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) => null, */
                              onChanged: (value) {
                                profile.userGeneralInfo.update = true;
                                profile.userGeneralInfo.subUsers[widget.index]
                                    .userGeneralInfo.custumMessage = value;
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

  _shareInformation(Profile profile) {
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
                  userInfoChild = !userInfoChild;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(userInfoChild ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 12.5),
                    ),
                    MyText(
                        value: 'pets_label_shareinfo'.tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: ColorConstant.textColor),
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
                    userInfoChild
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
        userInfoChild
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
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 11, right: 21),
                                      child: profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .firstName !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .firstName !=
                                                  ''
                                          ? MyText(
                                              value: "pets_label_share".tr() +
                                                  " " +
                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .firstName +
                                                  "reminders_label_sname".tr(),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: ColorConstant.textColor)
                                          : MyText(
                                              value:
                                                  "editprofil_label_sharename"
                                                      .tr(),
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
                            CustomSwitch(
                              activeColor: Color(0xff34C759),
                              value: profile
                                          .userGeneralInfo
                                          .subUsers[widget.index]
                                          .userGeneralInfo
                                          .preferenceUser
                                          .shareChildName
                                          .value ==
                                      "1"
                                  ? true
                                  : false,
                              onChanged: (value) {
                                profile.userGeneralInfo.update = true;

                                setState(() {
                                  profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .userGeneralInfo
                                      .preferenceUser
                                      .shareChildName
                                      .value = value == true ? '1' : '0';

                                  _switchIncludePhone = value;
                                });
                              },
                            ),
                            SizedBox(
                              width: 14,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 11, right: 21),
                                      child: profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .firstName !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .firstName !=
                                                  ''
                                          ? MyText(
                                              value: "pets_label_share".tr() +
                                                  " " +
                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .firstName +
                                                  "reminders_label_spicture"
                                                      .tr(),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: ColorConstant.textColor)
                                          : MyText(
                                              value:
                                                  "editprofil_label_sharepicture"
                                                      .tr(),
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
                            CustomSwitch(
                              activeColor: Color(0xff34C759),
                              value: profile
                                          .userGeneralInfo
                                          .subUsers[widget.index]
                                          .userGeneralInfo
                                          .preferenceUser
                                          .shareChildPicture
                                          .value ==
                                      '1'
                                  ? true
                                  : false,
                              onChanged: (value) {
                                profile.userGeneralInfo.update = true;

                                setState(() {
                                  profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .userGeneralInfo
                                      .preferenceUser
                                      .shareChildPicture
                                      .value = value == true ? '1' : '0';

                                  _switchIncludePhone = value;
                                });
                              },
                            ),
                            SizedBox(
                              width: 14,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
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

  //
  // family members
  _Memebrs(Profile profile, int index) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              border: memebrs || _FamilyMmebreStatus(profile, widget.index)
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
              color: memebrs || _FamilyMmebreStatus(profile, widget.index)
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
                  _scrollController.jumpTo(175);

                  memebrs = !memebrs;
                  medicInfo = false;
                  persInfo = false;
                  medicalTag = false;
                  viewExport = false;
                  emegInfo = false;
                  advancedSettings = false;
                  alsoInfo = false;
                  contact = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: Image.asset("Assets/Images/members.png",
                          height: 32,
                          width: 31,
                          color: memebrs ||
                                  _FamilyMmebreStatus(profile, widget.index)
                              ? null
                              : ColorConstant.textBlockVide),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                                value: "editprofil_label_familymembers".tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: memebrs ||
                                        _FamilyMmebreStatus(
                                            profile, widget.index)
                                    ? ColorConstant.whiteTextColor
                                    : ColorConstant.textBlockVide),
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
                    memebrs
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
        memebrs
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
                        _userList(profile, index),
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

  _userList(Profile profile, int index) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0, color: ColorConstant.boxColor),
            color: ColorConstant.boxColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            )),
        child: Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: MyText(
                                value: "editprofil_label_addmember".tr(),
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
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    profile.userGeneralInfo.subUsers[index].userGeneralInfo
                                .subUsers ==
                            null
                        ? Container()
                        : Container(
                            height: 300,
                            child: profile.userGeneralInfo.subUsers[index]
                                        .userGeneralInfo.subUsers ==
                                    null
                                ? MyText(
                                    value:
                                        "editprofil_label_nofamilymembers".tr())
                                : GridView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 5.0,
                                            mainAxisSpacing: 5.0,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        1.35)),
                                    itemCount: profile
                                            .userGeneralInfo
                                            .subUsers[index]
                                            .userGeneralInfo
                                            .subUsers
                                            .length +
                                        1,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          if (index == 0)
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  memebrs = false;
                                                });
                                                Navigator.of(context).push(
                                                  Scan4Dialog(profile
                                                      .userGeneralInfo
                                                      .subUsers[index]),
                                                );
                                              },
                                              child: Container(
                                                height: 150,
                                                width: screenWidth * 0.26,
                                                decoration: BoxDecoration(
                                                    color:
                                                        ColorConstant.lightGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    boxShadow: [
                                                      new BoxShadow(
                                                        color: Colors.black26,
                                                        offset:
                                                            Offset(1.0, 4.0),
                                                        //  spreadRadius: 7.0,
                                                        blurRadius: 5.0,
                                                      ),
                                                    ]),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                          "Assets/Images/add.png",
                                                          color: ColorConstant
                                                              .pinkColor,
                                                          height: 40.86,
                                                          width: 40.86),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      MyText(
                                                          value:
                                                              "objecttag_btn_addnew"
                                                                  .tr(),
                                                          fontSize: 10,
                                                          color: ColorConstant
                                                              .pinkColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      //Container(height: 15,width: 15,color:Colors.green),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (index != 0)
                                            Expanded(
                                              child: Container(
                                                width: screenWidth * 0.27,
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
                                                        offset:
                                                            Offset(1.0, 4.0),
                                                        //  spreadRadius: 7.0,
                                                        blurRadius: 5.0,
                                                      ),
                                                    ]),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    profile.userGeneralInfo
                                                            .linkedMedicalRecord
                                                            .contains(
                                                      profile
                                                          .userGeneralInfo
                                                          .subUsers[index]
                                                          .userGeneralInfo
                                                          .subUsers[index - 1]
                                                          .userGeneralInfo
                                                          .idMember,
                                                    )
                                                        ? Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                              screenWidth *
                                                                  0.02,
                                                              screenHeight *
                                                                  0.008,
                                                              screenWidth *
                                                                  0.02,
                                                              0,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Image.asset(
                                                                  "Assets/Images/Medical-Icon.png",
                                                                  height: 16,
                                                                  width: 16,
                                                                ),
                                                                Image.asset(
                                                                  "Assets/Images/Icon-awesome-link.png",
                                                                  height: 16,
                                                                  width: 16,
                                                                ),
                                                              ],
                                                            ))
                                                        : Container(),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom:
                                                            screenHeight * 0.01,
                                                      ),
                                                      child: Container(
                                                        height: (screenWidth *
                                                                19.2) /
                                                            100,
                                                        width: (screenWidth *
                                                                19.2) /
                                                            100,
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 3.0),
                                                                boxShadow: [
                                                                  new BoxShadow(
                                                                    color: Colors
                                                                        .black,
                                                                    blurRadius:
                                                                        2.0,
                                                                    spreadRadius:
                                                                        0.01,
                                                                  ),
                                                                ],
                                                                image: DecorationImage(
                                                                    image: NetworkImage(profile
                                                                        .userGeneralInfo
                                                                        .subUsers[
                                                                            index]
                                                                        .userGeneralInfo
                                                                        .subUsers[
                                                                            index -
                                                                                1]
                                                                        .userGeneralInfo
                                                                        .profilePictureUrl),
                                                                    fit: BoxFit
                                                                        .cover)),
                                                      ),
                                                    ),
                                                    Flexible(
                                                        child: MyText(
                                                      value: profile
                                                              .userGeneralInfo
                                                              .subUsers[index]
                                                              .userGeneralInfo
                                                              .subUsers[
                                                                  index - 1]
                                                              .userGeneralInfo
                                                              .firstName ??
                                                          '' +
                                                              ' ' +
                                                              profile
                                                                  .userGeneralInfo
                                                                  .subUsers[
                                                                      index]
                                                                  .userGeneralInfo
                                                                  .subUsers[
                                                                      index - 1]
                                                                  .userGeneralInfo
                                                                  .lastName ??
                                                          '',
                                                      color: profile
                                                              .userGeneralInfo
                                                              .linkedMedicalRecord
                                                              .contains(
                                                        profile
                                                            .userGeneralInfo
                                                            .subUsers[index]
                                                            .userGeneralInfo
                                                            .subUsers[index - 1]
                                                            .userGeneralInfo
                                                            .idMember,
                                                      )
                                                          ? ColorConstant
                                                              .whiteTextColor
                                                          : ColorConstant
                                                              .pinkColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                                    profile.userGeneralInfo
                                                            .linkedMedicalRecord
                                                            .contains(
                                                      profile
                                                          .userGeneralInfo
                                                          .subUsers[index]
                                                          .userGeneralInfo
                                                          .subUsers[index - 1]
                                                          .userGeneralInfo
                                                          .idMember,
                                                    )
                                                        ? SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.03,
                                                          )
                                                        : SizedBox(),
                                                    // Flexible(
                                                    //   child: Text(
                                                    //     profile
                                                    //             .userGeneralInfo
                                                    //             .subUsers[index]
                                                    //             .userGeneralInfo
                                                    //             .subUsers[index - 1]
                                                    //             .userGeneralInfo
                                                    //             .firstName +
                                                    //         ' ' +
                                                    //         profile
                                                    //             .userGeneralInfo
                                                    //             .subUsers[index]
                                                    //             .userGeneralInfo
                                                    //             .subUsers[index - 1]
                                                    //             .userGeneralInfo
                                                    //             .lastName,
                                                    //     maxLines: 1,
                                                    //     overflow: TextOverflow.ellipsis,
                                                    //     style: TextStyle(
                                                    //       color: ColorConstant.pinkColor,
                                                    //       fontSize: 10,
                                                    //       fontWeight: FontWeight.w600,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                  ],
                ))));
  }

  //MEDICAL
  _medicalTags(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
            height: 49,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black26,

                    offset: Offset(1.0, 3.0),
                    //  spreadRadius: 7.0,
                    blurRadius: 3.0,
                  ),
                ],
                color: medicalTag || _medicalTagStatus(profile, widget.index)
                    ? ColorConstant.primaryColor
                    : ColorConstant.colorBlockVide,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Container(
                height: 49,
                padding: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                  color: medicalTag || _medicalTagStatus(profile, widget.index)
                      ? ColorConstant.separatedColor
                      : ColorConstant.boxColor,
                ),
                child: Container(
                  height: 49,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    color:
                        medicalTag || _medicalTagStatus(profile, widget.index)
                            ? ColorConstant.pinkColor
                            : ColorConstant.colorBlockVide,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _scrollController.jumpTo(240);

                          medicalTag = !medicalTag;
                          viewExport = false;
                          medicInfo = false;
                          emegInfo = false;
                          persInfo = false;
                          memebrs = false;
                          advancedSettings = false;
                          alsoInfo = false;
                          contact = false;
                        });
                      },
                      child: Container(
                        height: 49,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 11, right: 21),
                              child: Image.asset(
                                "Assets/Images/Medicalb.png",
                                color: medicalTag ||
                                        _medicalTagStatus(profile, widget.index)
                                    ? null
                                    : ColorConstant.textBlockVide,
                                height: 32,
                                width: 31,
                              ),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: MyText(
                                        value: "listingtags_title_medical".tr(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: medicalTag ||
                                                _medicalTagStatus(
                                                    profile, widget.index)
                                            ? ColorConstant.whiteTextColor
                                            : ColorConstant
                                                .textBlockVide) /*Text(
                              "listingtags_title_medical".tr(),
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorConstant.whiteTextColor),
                            )*/
                                    ,
                                  ),
                                  SizedBox(
                                    width: 17,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            medicalTag
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
                ))),
        medicalTag
            ? SizedBox(
                height: 15,
              )
            : SizedBox(
                height: 0,
              ),
        medicalTag
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
                    color: ColorConstant.primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    )),
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
                          SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder:
                                  (BuildContext context, int index) => Divider(
                                        color: ColorConstant.darkGray,
                                        height: 0,
                                      ),
                              itemCount: userMedicalTags.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(top: 7.0, bottom: 7.0),
                                  child: Container(
                                    height: 42,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 42,
                                          width: 42,
                                          decoration: BoxDecoration(
                                            color: ColorConstant
                                                .imgBackgroundColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                userMedicalTags[index]
                                                        .tagInfo
                                                        .pictureUrl ??
                                                    "https://cdn.shopify.com/s/files/1/1718/5935/products/IMG_4801_1024x1024.JPG?v=1492139527",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText(
                                                  value: userMedicalTags[index]
                                                          .tagInfo
                                                          .tagLabel ??
                                                      " ",
                                                  color: userMedicalTags[index]
                                                              .tagInfo
                                                              .emergency ==
                                                          0
                                                      ? ColorConstant
                                                          .blockTextColor
                                                      : ColorConstant.textColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600),
                                              MyText(
                                                  value:
                                                      "pets_label_code".tr() +
                                                          ":" +
                                                          userMedicalTags[index]
                                                              .tagInfo
                                                              .serialNumber,
                                                  color: userMedicalTags[index]
                                                              .tagInfo
                                                              .emergency ==
                                                          0
                                                      ? ColorConstant
                                                          .blockTextColor
                                                      : ColorConstant.textColor,
                                                  fontSize: 7,
                                                  fontWeight: FontWeight.w400),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Stack(
                                                    children: [
                                                      CustomSwitch(
                                                        key: Key(
                                                            userMedicalTags[
                                                                    index]
                                                                .tagInfo
                                                                .emergency
                                                                .toString()),
                                                        activeColor:
                                                            Color(0xff34C759),
                                                        value: userMedicalTags[
                                                                        index]
                                                                    .tagInfo
                                                                    .emergency ==
                                                                1
                                                            ? true
                                                            : false,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            userMedicalTags[
                                                                        index]
                                                                    .tagInfo
                                                                    .emergency =
                                                                value == true
                                                                    ? 1
                                                                    : 0;

                                                            // if (!value) {
                                                            //   return maxColumnTags();
                                                            // }
                                                          });
                                                        },
                                                      ),
                                                      userMedicalTags[index]
                                                                  .tagInfo
                                                                  .emergency ==
                                                              1
                                                          ? Positioned(
                                                              top: 4,
                                                              right: 4,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    userMedicalTags[
                                                                            index]
                                                                        .tagInfo
                                                                        .emergency = 0;
                                                                  });
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  "Assets/Images/Medical.png",
                                                                  height: 16.7,
                                                                  width: 16,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                                iconAttachmentMedicalTag()
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 6.7),
                                                        child: Image.asset(
                                                          "Assets/Images/attachment-green.png",
                                                          height: 16,
                                                          width: 16,
                                                        ),
                                                      )
                                                    : Container(),
                                                iconReminderMedicalTag()
                                                    ? Image.asset(
                                                        "Assets/Images/alarm.png",
                                                        height: 16,
                                                        width: 16,
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            userMedicalTags[
                                                            index]
                                                        .tagInfo
                                                        .emergency ==
                                                    1
                                                ? MyText(
                                                    value:
                                                        "editprofil_medical_btn_active"
                                                            .tr(),
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w500)
                                                : MyText(
                                                    value:
                                                        "editprofil_medical_btn_blocked"
                                                            .tr(),
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(height: 12),
                          Container(
                              height: 0.45, color: ColorConstant.dividerColor),
                          SizedBox(height: 12),
                          MyButton(
                            title: "editprofil_general_btn_addnew".tr() +
                                "editprofil_medical_subtitle_medicaltag".tr(),
                            height: 36,
                            titleSize: 14,
                            fontWeight: FontWeight.w500,
                            titleColor: ColorConstant.primaryColor,
                            cornerRadius: 5.0,
                            btnBgColor: Colors.white,
                            onPressed: () {
                              profile.parameters.location = "Add Tag";
                              Navigator.of(context).pushReplacementNamed(
                                '/tagsProvider',
                                arguments: profile,
                              );
                            },
                          )
                        ]),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

//Personnal Information
  _PersInfo(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
            height: 49,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black26,

                    offset: Offset(1.0, 3.0),
                    //  spreadRadius: 7.0,
                    blurRadius: 3.0,
                  ),
                ],
                color: persInfo ||
                        _PersonalInformationStatus(profile, widget.index)
                    ? ColorConstant.primaryColor
                    : ColorConstant.colorBlockVide,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Container(
                height: 49,
                padding: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                  color: persInfo ||
                          _PersonalInformationStatus(profile, widget.index)
                      ? ColorConstant.separatedColor
                      : ColorConstant.boxColor,
                ),
                child: Container(
                  height: 49,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    color: persInfo ||
                            _PersonalInformationStatus(profile, widget.index)
                        ? ColorConstant.pinkColor
                        : ColorConstant.colorBlockVide,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _scrollController.jumpTo(300);

                          persInfo = !persInfo;
                          medicInfo = false;
                          medicalTag = false;
                          viewExport = false;
                          emegInfo = false;
                          memebrs = false;
                          advancedSettings = false;
                          alsoInfo = false;
                          contact = false;
                          gender = false;
                          insuranceInformation = false;
                          height = false;
                          dob = false;
                          language = false;
                          distinctiveSigns = false;
                          eye = false;
                          maritalStatus = false;
                          religion = false;
                          petsHome = false;
                          miscelaneous = false;
                        });
                      },
                      child: Container(
                        height: 49,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 11, right: 21),
                              child: Image.asset(
                                "Assets/Images/personnalb.png",
                                height: 32,
                                width: 31,
                                color: persInfo ||
                                        _PersonalInformationStatus(
                                            profile, widget.index)
                                    ? ColorConstant.whiteTextColor
                                    : ColorConstant.textBlockVide,
                              ),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: MyText(
                                          value:
                                              'editprofil_medical_subtitle_personalinfo'
                                                  .tr(),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: persInfo ||
                                                  _PersonalInformationStatus(
                                                      profile, widget.index)
                                              ? ColorConstant.whiteTextColor
                                              : ColorConstant.textBlockVide)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            persInfo
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
                ))),
        persInfo
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
                        _insuranceInformation(profile),
                        SizedBox(height: 12),
                        _heightAndWeight(profile),
                        SizedBox(height: 12),
                        _dateOfBirth(profile),
                        SizedBox(height: 12),
                        _language(profile),
                        SizedBox(height: 12),
                        _distinctiveSigns(profile),
                        SizedBox(height: 12),
                        _eyeColor(profile),
                        SizedBox(height: 12),
                        _maritalStatus(profile),
                        SizedBox(height: 12),
                        _gender(profile),
                        SizedBox(height: 12),
                        _religion(profile),
                        SizedBox(height: 12),
                        _petsAtHome(profile),
                        SizedBox(height: 12),
                        _miscelaneous(profile),
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

  _gender(Profile profile) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              gender = !gender;
              insuranceInformation = false;
              height = false;
              dob = false;
              language = false;
              distinctiveSigns = false;
              eye = false;
              maritalStatus = false;
              religion = false;
              petsHome = false;
              miscelaneous = false;
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
                  color: gender || _GenderStatus(profile, widget.index)
                      ? ColorConstant.primaryColor
                      : ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(gender ? 0 : 5.00),
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(gender ? 0 : 5.0))),
              child: InkWell(
                onTap: () {
                  setState(() {
                    gender = !gender;
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
                          "Assets/Images/genderr.png",
                          height: 24,
                          width: 32,
                          color: gender || _GenderStatus(profile, widget.index)
                              ? ColorConstant.primaryColor
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
                                  color: gender ||
                                          _GenderStatus(profile, widget.index)
                                      ? ColorConstant.textColor
                                      : ColorConstant.darkGray),
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
                              "Assets/Images/arrow-up.png",
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
                    color: ColorConstant.primaryColor,
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
                                                  color:
                                                      ColorConstant.textColor),
                                              value: value,
                                            ))
                                        .toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        genderData = newVal;

                                        profile
                                            .userGeneralInfo
                                            .subUsers[widget.index]
                                            .medicalRecord
                                            .idGender = newVal['id'];
                                      });
                                    },
                                    isExpanded: true,
                                    value: genderData,
                                    hint: MyText(
                                        value: profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .idGender !=
                                                null
                                            ? profile.parameters.genderList[
                                                profile
                                                        .userGeneralInfo
                                                        .subUsers[widget.index]
                                                        .medicalRecord
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
                                  borderRadius: BorderRadius.circular(5.0),
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

  _insuranceInformation(Profile profile) {
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
              color: insuranceInformation ||
                      _InsuranceInformationStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(insuranceInformation ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: GestureDetector(
            onTap: () {
              setState(() {
                insuranceInformation = !insuranceInformation;
                gender = false;
                height = false;
                dob = false;
                language = false;
                distinctiveSigns = false;
                eye = false;
                maritalStatus = false;
                religion = false;
                petsHome = false;
                miscelaneous = false;
              });
            },
            child: Container(
              height: 49.5,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight:
                          Radius.circular(insuranceInformation ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 21),
                          child: Image.asset(
                            "Assets/Images/insu.png",
                            height: 24,
                            width: 32,
                            color: insuranceInformation ||
                                    _InsuranceInformationStatus(
                                        profile, widget.index)
                                ? ColorConstant.primaryColor
                                : ColorConstant.darkGray,
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1, right: 5),
                            child: MyText(
                                value: "editprofil_medical_subtitle_insurance"
                                    .tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: insuranceInformation ||
                                        _InsuranceInformationStatus(
                                            profile, widget.index)
                                    ? ColorConstant.textColor
                                    : ColorConstant.darkGray),
                            // child: Image.asset("assets/image/phone-no.png",height: 32,width: 32,),
                          ),
                        ),
                        Image.asset(
                          "Assets/Images/info.png",
                          height: 14,
                          width: 14,
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                  iconAttachmentInsuranceInfo() == true
                      ? Image.asset(
                          "Assets/Images/attachment-green.png",
                          height: 16,
                          width: 16,
                        )
                      : Container(),
                  iconReminderInsuranceInfo() == true
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
                  insuranceInformation
                      ? Image.asset(
                          "Assets/Images/arrow-up.png",
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
        insuranceInformation
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: userInsuranceInfo.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Positioned(
                                  right: 5,
                                  top: 8,
                                  child: Visibility(
                                      visible: !_visiInsurance,
                                      child: Material(
                                          // pause button (round)
                                          borderRadius: BorderRadius.circular(
                                              50), // change radius size
                                          color: Colors.red, //button colour
                                          child: InkWell(
                                              splashColor: Colors
                                                  .red, // inkwell onPress colour
                                              child: SizedBox(
                                                  width: 24,
                                                  height:
                                                      24, //customisable size of 'button'
                                                  child: Center(
                                                      child: FaIcon(
                                                    FontAwesomeIcons.minus,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ))
                                                  /*Icon(Icons.delete, )*/
                                                  ),
                                              onTap: () {
                                                setState(() {
                                                  print(
                                                      userInsuranceInfo.length);
                                                  userInsuranceInfo
                                                      .removeAt(index);
                                                  print(
                                                      userInsuranceInfo.length);

                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .medicalRecord
                                                      .insuranceInfo
                                                      .removeAt(index);

                                                  nombrebolckInsurance =
                                                      userInsuranceInfo.length;
                                                  if (userInsuranceInfo
                                                          .length ==
                                                      0) {
                                                    _visiInsurance = true;
                                                  }
                                                });
                                              }))),
                                ),
                                SizedBox(width: 30),
                                ExpandableInsuranceList(
                                  key: Key(userInsuranceInfo[index]
                                      .additionalInformations),
                                  insuranceInfo: userInsuranceInfo[index],
                                  profile: profile,
                                  documents: userInsuranceInfo[index].documents,
                                  indexSubUser: widget.index,
                                  index: index,
                                  addBlockInsurrance: addBlockInsurance,
                                  // text: bloodController,
                                  visibileInsurance: _visiInsurance,
                                ),
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
                        userInsuranceInfo.length == 0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "editprofil_medical_subtitle_insuranceinfo"
                                        .tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckInsurance < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckInsurance++;
                                          addBlockInsurance.add(true);
                                          InsuranceInfo insuranceInfo =
                                              InsuranceInfo(
                                                  active: 1,
                                                  additionalInformations: '',
                                                  insuranceCampanyName: '',
                                                  documents: [],
                                                  reminders: []);
                                          userInsuranceInfo.add(insuranceInfo);

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .insuranceInfo
                                              .add(insuranceInfo);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiInsurance,
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
                                              child: MyText(
                                                value:
                                                    "editprofil_general_btn_addnew"
                                                        .tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorConstant.primaryColor,
                                              ),
                                              onPressed: nombrebolckInsurance <
                                                      nbblock
                                                  ? () {
                                                      setState(() {
                                                        nombrebolckInsurance++;
                                                        for (int i = 0;
                                                            i <
                                                                addBlockInsurance
                                                                    .length;
                                                            i++) {
                                                          if (addBlockInsurance[
                                                                  i] ==
                                                              true) {
                                                            addBlockInsurance[
                                                                i] = false;
                                                          }
                                                        }

                                                        addBlockInsurance
                                                            .add(true);
                                                        InsuranceInfo
                                                            insuranceInfo =
                                                            InsuranceInfo(
                                                                active: 1,
                                                                additionalInformations:
                                                                    '',
                                                                insuranceCampanyName:
                                                                    '',
                                                                documents: [],
                                                                reminders: []);
                                                        userInsuranceInfo
                                                            .add(insuranceInfo);

                                                        profile
                                                            .userGeneralInfo
                                                            .subUsers[
                                                                widget.index]
                                                            .medicalRecord
                                                            .insuranceInfo
                                                            .add(insuranceInfo);
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
                                  Visibility(
                                    visible: _visiInsurance,
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
                                              child: MyText(
                                                value:
                                                    "editprofil_general_btn_delete"
                                                        .tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorConstant.primaryColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _visiInsurance = false;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !_visiInsurance,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiInsurance =
                                                        !_visiInsurance;
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

  _heightAndWeight(Profile profile) {
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
                color: height || _WeightHeightStatus(profile, widget.index)
                    ? ColorConstant.primaryColor
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
                  gender = false;
                  insuranceInformation = false;
                  dob = false;
                  language = false;
                  distinctiveSigns = false;
                  eye = false;
                  maritalStatus = false;
                  religion = false;
                  petsHome = false;
                  miscelaneous = false;
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
                        "Assets/Images/ruler.png",
                        height: 24,
                        width: 32,
                        color:
                            height || _WeightHeightStatus(profile, widget.index)
                                ? ColorConstant.primaryColor
                                : ColorConstant.darkGray,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                                value:
                                    "editprofil_medical_subtitle_weightandheight"
                                        .tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: height ||
                                        _WeightHeightStatus(
                                            profile, widget.index)
                                    ? ColorConstant.textColor
                                    : ColorConstant.darkGray),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Image.asset(
                            "Assets/Images/info.png",
                            height: 14,
                            width: 14,
                          ),
                        ],
                      ),
                    ),
                    //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),

                    height
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
                    color: ColorConstant.primaryColor,
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
                                          value:
                                              "editprofil_medical_label_height"
                                                  .tr(),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      MyTextField(
                                        key: ValueKey(profile
                                            .userGeneralInfo
                                            .subUsers[widget.index]
                                            .medicalRecord
                                            .heightweight
                                            .heightFt
                                            .toString()),
                                        width: 35,
                                        keyboardType: TextInputType.number,
                                        focusNode: feetFocus,
                                        maxline: 1,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        initialValue: profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .heightweight
                                                    .heightFt !=
                                                null
                                            ? profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .medicalRecord
                                                .heightweight
                                                .heightFt
                                                .toString()
                                            : '',
                                        onChanged: (value) {
                                          widget.profile.userGeneralInfo
                                              .update = true;
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .heightweight
                                              .heightFt = double.parse(value);
                                          profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .heightweight
                                                  .heightCm =
                                              (double.parse(value) * 30.48);
                                          FocusScope.of(context)
                                              .requestFocus(feetFocus);
                                        },
                                      ),
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
                                      MyTextField(
                                        key: ObjectKey(profile
                                            .userGeneralInfo
                                            .subUsers[widget.index]
                                            .medicalRecord
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
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .heightweight
                                                    .heightInch !=
                                                null
                                            ? profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .medicalRecord
                                                .heightweight
                                                .heightInch
                                                .toString()
                                            : '',
                                        onChanged: (value) {
                                          widget.profile.userGeneralInfo
                                              .update = true;
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .heightweight
                                              .heightInch = double.parse(value);
                                          profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .heightweight
                                                  .heightCm =
                                              (double.parse(value) * 2.54);
                                          FocusScope.of(context)
                                              .requestFocus(inchFocus);
                                        },
                                        // textController: inchController,
                                      ),
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
                                      MyTextField(
                                        key: ObjectKey(profile
                                            .userGeneralInfo
                                            .subUsers[widget.index]
                                            .medicalRecord
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
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .heightweight
                                                    .heightCm !=
                                                null
                                            ? profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .medicalRecord
                                                .heightweight
                                                .heightCm
                                                .toString()
                                            : '',
                                        onChanged: (value) {
                                          widget.profile.userGeneralInfo
                                              .update = true;
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .heightweight
                                              .heightCm = double.parse(value);
                                          double inc = profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .heightweight
                                                  .heightCm /
                                              2.54;
                                          profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .heightweight
                                                  .heightFt =
                                              (inc / 12).floorToDouble();
                                          profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .heightweight
                                                  .heightInch =
                                              inc -
                                                  (12 *
                                                      profile
                                                          .userGeneralInfo
                                                          .subUsers[
                                                              widget.index]
                                                          .medicalRecord
                                                          .heightweight
                                                          .heightFt);
                                          FocusScope.of(context)
                                              .requestFocus(cmFocus);
                                        },
                                      ),
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
                                      MyTextField(
                                        key: Key(profile
                                            .userGeneralInfo
                                            .subUsers[widget.index]
                                            .medicalRecord
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
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .heightweight
                                                    .weightLbs !=
                                                null
                                            ? profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .medicalRecord
                                                .heightweight
                                                .weightLbs
                                                .toString()
                                            : '',
                                        onChanged: (value) {
                                          widget.profile.userGeneralInfo
                                              .update = true;
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .heightweight
                                              .weightLbs = double.parse(value);

                                          double kg =
                                              double.parse(value) * 0.4536;
                                          print(kg);

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .heightweight
                                              .weightKg = profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .heightweight
                                                  .weightLbs *
                                              0.4536;
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, right: 10),
                                        child: MyText(
                                            value: 'lbs',
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
                                      MyTextField(
                                        key: Key(profile
                                            .userGeneralInfo
                                            .subUsers[widget.index]
                                            .medicalRecord
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
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .heightweight
                                                    .weightKg !=
                                                null
                                            ? profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .medicalRecord
                                                .heightweight
                                                .weightKg
                                                .toString()
                                            : '',
                                        onChanged: (value) {
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .heightweight
                                              .weightKg = double.parse(value);
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .heightweight
                                              .weightKg = double.parse(value);

                                          double lbs =
                                              double.parse(value) * 2.2046;
                                          print(lbs);

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .heightweight
                                              .weightLbs = lbs;
                                        },
                                      ),
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

  _language(Profile profile) {
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
              color: language || _LanguageSpookenStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(language ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  language = !language;
                  gender = false;
                  insuranceInformation = false;
                  height = false;
                  dob = false;
                  distinctiveSigns = false;
                  eye = false;
                  maritalStatus = false;
                  religion = false;
                  petsHome = false;
                  miscelaneous = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(language ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.8, right: 21),
                      child: Image.asset(
                        "Assets/Images/language.png",
                        height: 15.6,
                        width: 31.2,
                        color: language ||
                                _LanguageSpookenStatus(profile, widget.index)
                            ? ColorConstant.primaryColor
                            : ColorConstant.darkGray,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                                value:
                                    "editprofil_medical_subtitle_language".tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: language ||
                                        _LanguageSpookenStatus(
                                            profile, widget.index)
                                    ? ColorConstant.textColor
                                    : ColorConstant.darkGray),
                          ),
                          SizedBox(
                            width: 19,
                          ),
                          Image.asset(
                            "Assets/Images/info.png",
                            height: 14,
                            width: 14,
                          ),
                        ],
                      ),
                    ),
                    language
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        language
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
                    color: ColorConstant.primaryColor,
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
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor,
                        ),
                        SizedBox(
                          height: 14.5,
                        ),
                        MyTextField(
                          initialValue: profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .medicalRecord
                                      .spokenLanguages !=
                                  null
                              ? profile.userGeneralInfo.subUsers[widget.index]
                                  .medicalRecord.spokenLanguages
                                  .toString()
                              : '',
                          inputType: TextInputType.multiline,
                          editTextBgColor: ColorConstant.textfieldColor,
                          hintTextColor: Colors.white54,
                          maxline: 5,
                          onChanged: (value) {
                            profile.userGeneralInfo.subUsers[widget.index]
                                .medicalRecord.spokenLanguages = value;
                          },
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

  _eyeColor(Profile profile) {
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
              color: eye || _EyeColorStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(eye ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
            onTap: () {
              setState(() {
                eye = !eye;
                gender = false;
                insuranceInformation = false;
                height = false;
                dob = false;
                language = false;
                distinctiveSigns = false;
                maritalStatus = false;
                religion = false;
                petsHome = false;
                miscelaneous = false;
              });
            },
            child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(eye ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.8, right: 22.4),
                      child: Image.asset(
                        "Assets/Images/eye-red.png",
                        height: 20.4,
                        width: 30.6,
                        color: eye || _EyeColorStatus(profile, widget.index)
                            ? ColorConstant.primaryColor
                            : ColorConstant.darkGray,
                      ),
                    ),
                    MyText(
                        value: "editprofil_medical_subtitle_eyecolor".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: eye || _EyeColorStatus(profile, widget.index)
                            ? ColorConstant.textColor
                            : ColorConstant.darkGray),
                    SizedBox(
                      width: 19,
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
                    eye
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
                            height: 8,
                            width: 13.18,
                          )
                        : Container(),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                )),
          ),
        ),
        eye
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
                    color: ColorConstant.primaryColor,
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
                        profile.parameters.eyeColorList != null
                            ? Container(
                                height: 24,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: profile.parameters.eyeColorList
                                        .map(
                                          (e) => DropdownMenuItem(
                                            child: MyText(
                                                value: e['eye_color_label'],
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: ColorConstant.textColor),
                                            value: e,
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        profile
                                            .userGeneralInfo
                                            .subUsers[widget.index]
                                            .medicalRecord
                                            .idEyeColor = newVal['id'];
                                      });
                                    },
                                    isExpanded: true,
                                    value: eyeData,
                                    hint: MyText(
                                        value: profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .idEyeColor !=
                                                null
                                            ? profile.parameters.eyeColorList[
                                                profile
                                                        .userGeneralInfo
                                                        .subUsers[widget.index]
                                                        .medicalRecord
                                                        .idEyeColor -
                                                    1]['eye_color_label']
                                            : '',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.darkGray),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: ColorConstant.textfieldColor,
                                  borderRadius: BorderRadius.circular(5.0),
                                  // border: Border.all(style: BorderStyle.solid, width: 0.70),
                                ),
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

  _religion(Profile profile) {
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
              color: religion || _ReligionStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(religion ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
            onTap: () {
              setState(() {
                religion = !religion;
                gender = false;
                insuranceInformation = false;
                height = false;
                dob = false;
                language = false;
                distinctiveSigns = false;
                eye = false;
                maritalStatus = false;
                petsHome = false;
                miscelaneous = false;
              });
            },
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(eye ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.8, right: 22.4),
                    child: Image.asset(
                      "Assets/Images/eye-red.png",
                      height: 20.4,
                      width: 30.6,
                      color: religion || _ReligionStatus(profile, widget.index)
                          ? ColorConstant.primaryColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "editprofil_medical_subtitle_religion".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: religion || _ReligionStatus(profile, widget.index)
                          ? ColorConstant.textColor
                          : ColorConstant.darkGray),
                  SizedBox(
                    width: 19,
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
                  religion
                      ? Image.asset(
                          "Assets/Images/arrow-up.png",
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
        religion
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
                    color: ColorConstant.primaryColor,
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
                          height: 14.5,
                        ),
                        MyTextField(
                          initialValue: profile
                              .userGeneralInfo
                              .subUsers[widget.index]
                              .medicalRecord
                              .religionLabel,
                          inputType: TextInputType.text,
//                                  textAlign: TextAlign.start,
                          maxline: 1,
                          focusNode: petsHomeFocus,

                          editTextBgColor: ColorConstant.textfieldColor,
                          hintTextColor: Colors.white54,
                          title: '',
                          onChanged: (value) {
                            profile.userGeneralInfo.update = true;
                            profile.userGeneralInfo.subUsers[widget.index]
                                .medicalRecord.religionLabel = value;
                          },
                          // textController: petsHomeController,
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

  _distinctiveSigns(Profile profile) {
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
              color: distinctiveSigns ||
                      _DistinctiveSigneStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
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
                  gender = false;
                  insuranceInformation = false;
                  height = false;
                  dob = false;
                  language = false;
                  eye = false;
                  maritalStatus = false;
                  religion = false;
                  petsHome = false;
                  miscelaneous = false;
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
                        "Assets/Images/contrast.png",
                        height: 30.5,
                        width: 30.5,
                        color: distinctiveSigns ||
                                _DistinctiveSigneStatus(profile, widget.index)
                            ? ColorConstant.primaryColor
                            : ColorConstant.darkGray,
                      ),
                    ),
                    MyText(
                        value: "editprofil_medical_subtitle_signs".tr(),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: distinctiveSigns ||
                                _DistinctiveSigneStatus(profile, widget.index)
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
                    distinctiveSigns
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
                    color: ColorConstant.primaryColor,
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
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: MyTextField(
                            initialValue: profile
                                .userGeneralInfo
                                .subUsers[widget.index]
                                .medicalRecord
                                .distitnctSign,

                            inputType: TextInputType.multiline,
//                                  textAlign: TextAlign.start,
                            focusNode: distinctiveSignsFocus,
                            editTextBgColor: ColorConstant.textfieldColor,
                            hintTextColor: Colors.white54,
                            title: '',
                            maxline: 5,
                            onChanged: (value) {
                              profile.userGeneralInfo.subUsers[widget.index]
                                  .medicalRecord.distitnctSign = value;
                            },
                            // textController: distinctiveSignsController,
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

  _dateOfBirth(Profile profile) {
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
              color: dob || _birthdayStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
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
                gender = false;
                insuranceInformation = false;
                height = false;
                language = false;
                distinctiveSigns = false;
                eye = false;
                maritalStatus = false;
                religion = false;
                petsHome = false;
                miscelaneous = false;
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
                      "Assets/Images/birthday-cake.png",
                      height: 26,
                      width: 22.73,
                      color: dob || _birthdayStatus(profile, widget.index)
                          ? ColorConstant.primaryColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "editprofil_medical_subtitle_birth".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: dob || _birthdayStatus(profile, widget.index)
                          ? ColorConstant.textColor
                          : ColorConstant.darkGray),
                  //  Image.asset("Assets/Images/arrow-up.png",height: 8,width: 13.18,),
                  SizedBox(
                    width: 14,
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

                  dob
                      ? Image.asset(
                          "Assets/Images/arrow-up.png",
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
                    color: ColorConstant.primaryColor,
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

  _maritalStatus(Profile profile) {
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
                  maritalStatus || _MaritalStatusStatus(profile, widget.index)
                      ? ColorConstant.primaryColor
                      : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(maritalStatus ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
            onTap: () {
              setState(() {
                maritalStatus = !maritalStatus;
                gender = false;
                insuranceInformation = false;
                height = false;
                dob = false;
                language = false;
                distinctiveSigns = false;
                eye = false;
                religion = false;
                petsHome = false;
                miscelaneous = false;
              });
            },
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(maritalStatus ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 9.4, right: 21),
                    child: Image.asset(
                      "Assets/Images/wedding-ring.png",
                      height: 28.6,
                      width: 31.8,
                      color: maritalStatus ||
                              _MaritalStatusStatus(profile, widget.index)
                          ? ColorConstant.primaryColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "editprofil_medical_subtitle_status".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: maritalStatus ||
                              _MaritalStatusStatus(profile, widget.index)
                          ? ColorConstant.textColor
                          : ColorConstant.darkGray),
                  SizedBox(
                    width: 19,
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
                  maritalStatus
                      ? Image.asset(
                          "Assets/Images/arrow-up.png",
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
        maritalStatus
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
                    color: ColorConstant.primaryColor,
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
                        profile.parameters.materialStatusList != null
                            ? Container(
                                height: 24,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: profile.parameters.materialStatusList
                                        .map(
                                          (e) => DropdownMenuItem(
                                            child: MyText(
                                                value:
                                                    e['marital_status_label'],
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: ColorConstant.textColor),
                                            value: e,
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        profile
                                            .userGeneralInfo
                                            .subUsers[widget.index]
                                            .medicalRecord
                                            .idMaritalStatus = newVal['id'];
                                      });
                                    },
                                    isExpanded: true,
                                    value: maritalData,
                                    hint: MyText(
                                        value: profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .idMaritalStatus !=
                                                null
                                            ? profile.parameters
                                                .materialStatusList[profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .idMaritalStatus -
                                                1]['marital_status_label']
                                            : '',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.darkGray),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: ColorConstant.textfieldColor,
                                  borderRadius: BorderRadius.circular(5.0),
                                  // border: Border.all(style: BorderStyle.solid, width: 0.70),
                                ),
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

  _petsAtHome(Profile profile) {
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
              color: petsHome || _PetStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(petsHome ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
            onTap: () {
              setState(() {
                petsHome = !petsHome;
                gender = false;
                insuranceInformation = false;
                height = false;
                dob = false;
                language = false;
                distinctiveSigns = false;
                eye = false;
                maritalStatus = false;
                religion = false;
                miscelaneous = false;
              });
            },
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(petsHome ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.8, right: 23.7),
                    child: Image.asset(
                      "Assets/Images/pets-red.png",
                      height: 23.1,
                      width: 24.3,
                      color: petsHome || _PetStatus(profile, widget.index)
                          ? ColorConstant.primaryColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "editprofil_medical_subtitle_pet".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: petsHome || _PetStatus(profile, widget.index)
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
                  petsHome
                      ? Image.asset(
                          "Assets/Images/arrow-up.png",
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
        petsHome
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
                    color: ColorConstant.primaryColor,
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
                          height: 14.5,
                        ),
                        MyTextField(
                          initialValue: profile.userGeneralInfo
                              .subUsers[widget.index].medicalRecord.petAtHome,
                          inputType: TextInputType.text,
//                                  textAlign: TextAlign.start,
                          maxline: 1,
                          focusNode: petsHomeFocus,

                          editTextBgColor: ColorConstant.textfieldColor,
                          hintTextColor: Colors.white54,
                          title: '',
                          onChanged: (value) {
                            profile.userGeneralInfo.subUsers[widget.index]
                                .medicalRecord.petAtHome = value;
                          },
                          // textController: petsHomeController,
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

  _miscelaneous(Profile profile) {
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
              color: miscelaneous || _MiscelaneousStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(miscelaneous ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: GestureDetector(
            onTap: () {
              setState(() {
                miscelaneous = !miscelaneous;
                gender = false;
                insuranceInformation = false;
                height = false;
                dob = false;
                language = false;
                distinctiveSigns = false;
                eye = false;
                maritalStatus = false;
                religion = false;
                petsHome = false;
              });
            },
            child: Container(
              height: 49.5,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(miscelaneous ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 13),
                    child: Image.asset(
                      "Assets/Images/threedot.png",
                      height: 6,
                      width: 24,
                      color: miscelaneous ||
                              _MiscelaneousStatus(profile, widget.index)
                          ? null
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "editprofil_medical_subtitle_miscelaneous".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: miscelaneous ||
                              _MiscelaneousStatus(profile, widget.index)
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
                  iconAttachmentMiscilaneous() == true
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Image.asset(
                            "Assets/Images/attachment-green.png",
                            height: 16,
                            width: 16,
                          ),
                        )
                      : Container(),
                  iconReminderMiscilaneous() == true
                      ? Padding(
                          padding: const EdgeInsets.only(right: 11.3),
                          child: Image.asset(
                            "Assets/Images/alarm.png",
                            height: 16,
                            width: 16,
                          ),
                        )
                      : Container(),
                  miscelaneous
                      ? Image.asset(
                          "Assets/Images/arrow-up.png",
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
        miscelaneous
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
                    color: ColorConstant.primaryColor,
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
                    padding: EdgeInsets.only(
                      left: 10.5,
                      right: 20.5,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 0.40,
                          color: ColorConstant.dividerColor,
                        ),
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.30)),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMiscelaneous.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 5.0, top: 10),
                                  child: Visibility(
                                    visible: !_visiMescelanous,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Material(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.red, //button colour
                                        child: InkWell(
                                            splashColor: Colors
                                                .red, // inkwell onPress colour
                                            child: SizedBox(
                                                width: 24,
                                                height:
                                                    24, //customisable size of 'button'
                                                child: Center(
                                                    child: FaIcon(
                                                  FontAwesomeIcons.minus,
                                                  color: Colors.white,
                                                  size: 16,
                                                ))),
                                            onTap: () {
                                              setState(() {
                                                print(userMiscelaneous.length);
                                                userMiscelaneous
                                                    .removeAt(index);
                                                print(userMiscelaneous.length);
                                                profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .miscilanious
                                                    .removeAt(index);

                                                nombrebolckMiscelaneous =
                                                    userMiscelaneous.length;

                                                if (userMiscelaneous.length ==
                                                    0) {
                                                  _visiMescelanous = true;
                                                }
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                ExpandableMisclaneousList(
                                    key: Key(userMiscelaneous[index].label),
                                    profile: profile,
                                    index: index,
                                    indexSubUser: widget.index,
                                    miscilanious: userMiscelaneous[index],
                                    attachment: true,
                                    alarm: true,
                                    addBlockMisc: addBlockMisc,
                                    // text: miscelaneousController,
                                    switchValue:
                                        userMiscelaneous[index].allow == 1
                                            ? true
                                            : false,
                                    dropdownValue: true,
                                    visibilite: _visiMescelanous),
                              ],
                            );
                          },
                        ),
                        Container(
                          height: .40,
                          color: ColorConstant.dividerColor.withOpacity(.30),
                        ),
                        SizedBox(height: 21),
                        userMiscelaneous.length == 0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "objecttag_bloctitle_miscellaneous".tr(),
                                height: 36.0,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckMiscelaneous < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckMiscelaneous++;
                                          addBlockMisc.add(true);
                                          Miscilanious miscilanious =
                                              Miscilanious(
                                                  allow: 1,
                                                  description: "",
                                                  documents: [],
                                                  reminders: [],
                                                  label: "");

                                          userMiscelaneous.add(miscilanious);

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .miscilanious
                                              .add(miscilanious);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiMescelanous,
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
                                              child: MyText(
                                                value:
                                                    "editprofil_general_btn_addnew"
                                                        .tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorConstant.primaryColor,
                                              ),
                                              onPressed:
                                                  nombrebolckMiscelaneous <
                                                          nbblock
                                                      ? () {
                                                          setState(() {
                                                            nombrebolckMiscelaneous++;
                                                            for (int i = 0;
                                                                i <
                                                                    addBlockMisc
                                                                        .length;
                                                                i++) {
                                                              if (addBlockMisc[
                                                                      i] ==
                                                                  true) {
                                                                addBlockMisc[
                                                                    i] = false;
                                                              }
                                                            }

                                                            addBlockMisc
                                                                .add(true);
                                                            Miscilanious
                                                                miscilanious =
                                                                Miscilanious(
                                                                    allow: 1,
                                                                    description:
                                                                        "",
                                                                    documents: [],
                                                                    reminders: [],
                                                                    label: "");

                                                            userMiscelaneous.add(
                                                                miscilanious);

                                                            profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .medicalRecord
                                                                .miscilanious
                                                                .add(
                                                                    miscilanious);
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
                                  Visibility(
                                    visible: _visiMescelanous,
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
                                              child: MyText(
                                                value:
                                                    "editprofil_general_btn_delete"
                                                        .tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorConstant.primaryColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _visiMescelanous = false;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !_visiMescelanous,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiMescelanous =
                                                        !_visiMescelanous;
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
                        SizedBox(
                          height: 21,
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

  // My emergency Contact
  // ignore: non_constant_identifier_names
  _EmegInfo(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
            height: 49,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black26,

                    offset: Offset(1.0, 3.0),
                    //  spreadRadius: 7.0,
                    blurRadius: 3.0,
                  ),
                ],
                color: emegInfo || _EmgInfoStatus(profile, widget.index)
                    ? ColorConstant.primaryColor
                    : ColorConstant.colorBlockVide,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Container(
                height: 49,
                padding: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                  color: emegInfo || _EmgInfoStatus(profile, widget.index)
                      ? ColorConstant.separatedColor
                      : ColorConstant.boxColor,
                ),
                child: Container(
                  height: 49,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                      color: emegInfo || _EmgInfoStatus(profile, widget.index)
                          ? ColorConstant.pinkColor
                          : ColorConstant.colorBlockVide),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _scrollController.jumpTo(350);

                          emegInfo = !emegInfo;
                          medicInfo = false;
                          medicalTag = false;
                          viewExport = false;
                          persInfo = false;
                          memebrs = false;
                          advancedSettings = false;
                          alsoInfo = false;
                          contact = false;
                          physicianContacts = false;
                          emergencyContacts = false;
                        });
                      },
                      child: Container(
                        height: 49,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 11, right: 21),
                              child: Image.asset("Assets/Images/Emergency.png",
                                  height: 32,
                                  width: 31,
                                  color: emegInfo ||
                                          _EmgInfoStatus(profile, widget.index)
                                      ? null
                                      : ColorConstant.textBlockVide),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: MyText(
                                        value:
                                            "editprofil_medical_subtitle_mycontact"
                                                .tr(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: emegInfo ||
                                                _EmgInfoStatus(
                                                    profile, widget.index)
                                            ? ColorConstant.whiteTextColor
                                            : ColorConstant.textBlockVide),
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
                            emegInfo
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
                ))),
        emegInfo
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
                        role == 'child'
                            ? _emergencyContactsChild(profile)
                            : _emergencyContacts(profile),
                        SizedBox(height: 12),
                        _physiciancontacts(profile),
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

  _emergencyContactsChild(Profile profile) {
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
              color: emergencyContacts ||
                      _EmergencyContactsStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(emergencyContacts ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: GestureDetector(
            onTap: () {
              setState(() {
                emergencyContacts = !emergencyContacts;
                physicianContacts = false;
              });
            },
            child: Container(
              height: 49.5,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight:
                          Radius.circular(emergencyContacts ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 11, right: 18),
                            child: MyText(
                                value:
                                    "editprofil_medical_bloctitle_contact".tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: emergencyContacts ||
                                        _EmergencyContactsStatus(
                                            profile, widget.index)
                                    ? ColorConstant.textColor
                                    : ColorConstant.darkGray),
                            // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                          ),
                        ),
                        Image.asset(
                          "Assets/Images/info.png",
                          height: 14,
                          width: 14,
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  emergencyContacts
                      ? Image.asset(
                          "Assets/Images/arrow-up.png",
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
        emergencyContacts
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
                    color: ColorConstant.primaryColor,
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
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: profile
                              .userGeneralInfo
                              .subUsers[widget.index]
                              .medicalRecord
                              .userEmergencyContact
                              .length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: false,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              profile.medicalRecord
                                                  .userEmergencyContact
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              ExpandableEmergency(
                                  key: Key(profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .medicalRecord
                                      .userEmergencyContact[index]
                                      .firstName),
                                  role: 'child',
                                  userEmergencyContactGeneral: profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .userGeneralInfo
                                      .userEmergencyContact[index],
                                  userEmergencyContact: profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .medicalRecord
                                      .userEmergencyContact[index],
                                  dropdownValue: profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .userEmergencyContact[index]
                                              .active ==
                                          1
                                      ? true
                                      : false,
                                  index: index,
                                  addBlockEmergency: addEmergencyChild,
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: RaisedButton(
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.white,
                                        color: Colors.white,
                                        textColor: ColorConstant.primaryColor,
                                        child: MyText(
                                          value: "editprofil_general_btn_addnew"
                                              .tr(),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstant.primaryColor,
                                        ),
                                        onPressed: nombrebolckAlsoContact <
                                                nbblock
                                            ? () {
                                                setState(() {
                                                  nombrebolckAlsoContact++;
                                                  for (int i = 0;
                                                      i <
                                                          addEmergencyChild
                                                              .length;
                                                      i++) {
                                                    if (addEmergencyChild[i] ==
                                                        true) {
                                                      addEmergencyChild[i] =
                                                          false;
                                                    }
                                                  }

                                                  addEmergencyChild.add(true);
                                                  UserEmergencyContact
                                                      alsoContG =
                                                      UserEmergencyContact(
                                                    id: 0,
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
                                                  UserEmergencyContact
                                                      alsoContM =
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

                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact
                                                      .add(alsoContG);
                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .medicalRecord
                                                      .userEmergencyContact
                                                      .add(alsoContM);
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
              )
            : Container(),
      ],
    );
  }

  _emergencyContacts(Profile profile) {
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
              color: emergencyContacts ||
                      _EmergencyContactsStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(emergencyContacts ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: GestureDetector(
            onTap: () {
              setState(() {
                emergencyContacts = !emergencyContacts;
                physicianContacts = false;
              });
            },
            child: Container(
              height: 49.5,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight:
                          Radius.circular(emergencyContacts ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 11, right: 18),
                            child: MyText(
                                value:
                                    "editprofil_medical_bloctitle_contact".tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: emergencyContacts ||
                                        _EmergencyContactsStatus(
                                            profile, widget.index)
                                    ? ColorConstant.textColor
                                    : ColorConstant.darkGray),
                            // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                          ),
                        ),
                        Image.asset(
                          "Assets/Images/info.png",
                          height: 14,
                          width: 14,
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  emergencyContacts
                      ? Image.asset(
                          "Assets/Images/arrow-up.png",
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
        emergencyContacts
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
                    color: ColorConstant.primaryColor,
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
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: profile
                              .userGeneralInfo
                              .subUsers[widget.index]
                              .medicalRecord
                              .userEmergencyContact
                              .length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            print(profile.userGeneralInfo.subUsers[widget.index]
                                .medicalRecord.userEmergencyContact[index]);

                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: false,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .userEmergencyContact
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              ExpandableEmergency(
                                  key: Key(profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .medicalRecord
                                      .userEmergencyContact[index]
                                      .firstName),
                                  userEmergencyContactGeneral: profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .userGeneralInfo
                                      .userEmergencyContact[index],
                                  userEmergencyContact: profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .medicalRecord
                                      .userEmergencyContact[index],
                                  index: index,
                                  addBlockEmergency: addBlockEmergency,
                                  dropdownValue: true,
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: RaisedButton(
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.white,
                                        color: Colors.white,
                                        child: MyText(
                                          value: "editprofil_general_btn_addnew"
                                              .tr(),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstant.primaryColor,
                                        ),
                                        onPressed: nombrebolckAlsoContact <
                                                nbblock
                                            ? () {
                                                setState(() {
                                                  nombrebolckAlsoContact++;

                                                  for (int i = 0;
                                                      i <
                                                          addBlockEmergency
                                                              .length;
                                                      i++) {
                                                    if (addBlockEmergency[i] ==
                                                        true) {
                                                      addBlockEmergency[i] =
                                                          false;
                                                    }
                                                  }
                                                  addBlockChild.add(false);

                                                  addBlockEmergency.add(true);
                                                  UserEmergencyContact
                                                      alsoContG =
                                                      UserEmergencyContact(
                                                    id: 0,
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
                                                  UserEmergencyContact
                                                      alsoContM =
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

                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact
                                                      .add(alsoContG);
                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .medicalRecord
                                                      .userEmergencyContact
                                                      .add(alsoContM);
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
              )
            : Container(),
      ],
    );
  }

  _physiciancontacts(Profile profile) {
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
              color: physicianContacts ||
                      _PhysicianContactsStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(physicianContacts ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: GestureDetector(
            onTap: () {
              setState(() {
                physicianContacts = !physicianContacts;
                emergencyContacts = false;
              });
            },
            child: Container(
              height: 49.5,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: ColorConstant.boxColor),
                  color: ColorConstant.boxColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight:
                          Radius.circular(physicianContacts ? 0 : 5.0))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 11, right: 18),
                            child: MyText(
                                value:
                                    "editprofil_medical_subtitle_physiciancontact"
                                        .tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: physicianContacts ||
                                        _PhysicianContactsStatus(
                                            profile, widget.index)
                                    ? ColorConstant.textColor
                                    : ColorConstant.darkGray),
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
                  physicianContacts
                      ? Image.asset(
                          "Assets/Images/arrow-up.png",
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
        physicianContacts
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
                    color: ColorConstant.primaryColor,
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
                          itemCount:
                              userMedicalPhysicianEmergencyContacts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 5.0, top: 8),
                                  child: Visibility(
                                    visible: !_visiPhysician,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Material(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.red, //button colour
                                        child: InkWell(
                                            splashColor: Colors
                                                .red, // inkwell onPress colour
                                            child: SizedBox(
                                                width: 24,
                                                height:
                                                    24, //customisable size of 'button'
                                                child: Center(
                                                    child: FaIcon(
                                                  FontAwesomeIcons.minus,
                                                  color: Colors.white,
                                                  size: 16,
                                                ))),
                                            onTap: () {
                                              setState(() {
                                                print(
                                                    userMedicalPhysicianEmergencyContacts
                                                        .length);
                                                userMedicalPhysicianEmergencyContacts
                                                    .removeAt(index);
                                                print(
                                                    userMedicalPhysicianEmergencyContacts
                                                        .length);
                                                profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .physicianContact
                                                    .removeAt(index);

                                                nombrebolckPhysicianContact =
                                                    userMedicalPhysicianEmergencyContacts
                                                        .length;
                                                if (userMedicalPhysicianEmergencyContacts
                                                        .length ==
                                                    0) {
                                                  _visiPhysician = true;
                                                }
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                ExpandablePhysicianList(
                                    key: Key(
                                        userMedicalPhysicianEmergencyContacts[
                                                index]
                                            .firstName),
                                    dropdownValue: true,
                                    index: index,
                                    addBlockPhysician: addBlockPhysician,
                                    physicianContact:
                                        userMedicalPhysicianEmergencyContacts[
                                            index],
                                    visibilite: _visiPhysician),
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
                        userMedicalPhysicianEmergencyContacts.length == 0
                            ? MyButton(
                                title: "+ " +
                                    "editprofil_medical_subtitle_addnewphysiciancontact"
                                        .tr(),
                                height: 36.0,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckPhysicianContact < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckPhysicianContact++;
                                          addBlockPhysician.add(true);
                                          PhysicianContact physicienContact =
                                              PhysicianContact(
                                                  active: 1,
                                                  allowContactMail: 0,
                                                  allowContactMobile: 0,
                                                  allowTel: 0,
                                                  firstName: '',
                                                  lastName: '',
                                                  mail: '',
                                                  mail2: '',
                                                  mobile: '',
                                                  mobile2: '',
                                                  tel: '',
                                                  tel2: "");
                                          userMedicalPhysicianEmergencyContacts
                                              .add(physicienContact);

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .physicianContact
                                              .add(physicienContact);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiPhysician,
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
                                              child: MyText(
                                                value:
                                                    "editprofil_general_btn_addnew"
                                                        .tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorConstant.primaryColor,
                                              ),
                                              onPressed:
                                                  nombrebolckPhysicianContact <
                                                          nbblock
                                                      ? () {
                                                          setState(() {
                                                            nombrebolckPhysicianContact++;
                                                            for (int i = 0;
                                                                i <
                                                                    addBlockPhysician
                                                                        .length;
                                                                i++) {
                                                              if (addBlockPhysician[
                                                                      i] ==
                                                                  true) {
                                                                addBlockPhysician[
                                                                    i] = false;
                                                              }
                                                            }

                                                            addBlockPhysician
                                                                .add(true);
                                                            PhysicianContact
                                                                physicienContact =
                                                                PhysicianContact(
                                                                    active: 1,
                                                                    allowContactMail:
                                                                        0,
                                                                    allowContactMobile:
                                                                        0,
                                                                    allowTel: 0,
                                                                    firstName:
                                                                        '',
                                                                    lastName:
                                                                        '',
                                                                    mail: '',
                                                                    mail2: '',
                                                                    mobile: '',
                                                                    mobile2: '',
                                                                    tel: '',
                                                                    tel2: "");
                                                            userMedicalPhysicianEmergencyContacts
                                                                .add(
                                                                    physicienContact);

                                                            profile
                                                                .userGeneralInfo
                                                                .subUsers[widget
                                                                    .index]
                                                                .medicalRecord
                                                                .physicianContact
                                                                .add(
                                                                    physicienContact);
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
                                  Visibility(
                                    visible: _visiPhysician,
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
                                              child: MyText(
                                                value:
                                                    "editprofil_general_btn_delete"
                                                        .tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorConstant.primaryColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _visiPhysician = false;
                                                  _visibile = _visiPhysician;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !_visiPhysician,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiPhysician =
                                                        !_visiPhysician;
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

// My Medical information
  _MedicInfo(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
            height: 49,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black26,

                    offset: Offset(1.0, 3.0),
                    //  spreadRadius: 7.0,
                    blurRadius: 3.0,
                  ),
                ],
                color: medicInfo ||
                        _MedicalInformationStatus(profile, widget.index)
                    ? ColorConstant.primaryColor
                    : ColorConstant.colorBlockVide,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Container(
                height: 49,
                padding: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                  color: medicInfo ||
                          _MedicalInformationStatus(profile, widget.index)
                      ? ColorConstant.separatedColor
                      : ColorConstant.boxColor,
                ),
                child: Container(
                  height: 49,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    color: medicInfo ||
                            _MedicalInformationStatus(profile, widget.index)
                        ? ColorConstant.pinkColor
                        : ColorConstant.colorBlockVide,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _scrollController.jumpTo(400);

                          medicInfo = !medicInfo;
                          persInfo = false;
                          medicalTag = false;
                          viewExport = false;
                          emegInfo = false;
                          memebrs = false;
                          advancedSettings = false;
                          alsoInfo = false;
                          contact = false;
                          _infectiousdiseases = false;
                          organDonor = false;
                          _dnr = false;
                          _allergies = false;
                          _implants = false;
                          _renalKidney = false;
                          cardiac = false;
                          _psychiatric = false;
                          _neurologic = false;
                          _pulmonary = false;
                          _medication = false;
                          _cancer = false;
                          blood = false;
                          other = false;
                        });
                      },
                      child: Container(
                        height: 49,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 11, right: 21),
                              child: Image.asset(
                                "Assets/Images/medinfor.png",
                                height: 32,
                                width: 31,
                                color: medicInfo ||
                                        _MedicalInformationStatus(
                                            profile, widget.index)
                                    ? null
                                    : ColorConstant.textBlockVide,
                              ),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: MyText(
                                        value: "listingtags_title_medicalinfo"
                                            .tr(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: medicInfo ||
                                                _MedicalInformationStatus(
                                                    profile, widget.index)
                                            ? ColorConstant.whiteTextColor
                                            : ColorConstant.textBlockVide),
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
                            medicInfo
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
                ))),
        medicInfo
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
                        _organDonor(profile),
                        SizedBox(height: 12),
                        _Dnr(profile),
                        SizedBox(height: 12),
                        infectiousdiseases(profile),
                        SizedBox(height: 12),
                        _Allergies(profile),
                        SizedBox(height: 12),
                        implants(profile),
                        SizedBox(height: 12),
                        _RenalKidney(profile),
                        SizedBox(height: 12),
                        _cardiac(profile),
                        SizedBox(height: 12),
                        psychiatric(profile),
                        SizedBox(height: 12),
                        _Neurologic(profile),
                        SizedBox(height: 12),
                        pulmonary(profile),
                        SizedBox(height: 12),
                        _Medication(profile),
                        SizedBox(height: 12),
                        cancer(profile),
                        SizedBox(height: 12),
                        _blood(profile),
                        SizedBox(height: 12),
                        _other(profile),
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

  infectiousdiseases(Profile profile) {
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
              color: _infectiousdiseases ||
                      _infectionDisacesStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(_infectiousdiseases ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _infectiousdiseases = !_infectiousdiseases;
                  organDonor = false;
                  _dnr = false;
                  _allergies = false;
                  _implants = false;
                  _renalKidney = false;
                  cardiac = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _medication = false;
                  _cancer = false;
                  blood = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight:
                            Radius.circular(_infectiousdiseases ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_diseases".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: _infectiousdiseases ||
                                    _infectionDisacesStatus(
                                        profile, widget.index)
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    iconAttachmentMedicalInfectious() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderMedicalInfectious() == true
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
                    _infectiousdiseases
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        _infectiousdiseases
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: userMedicalDiseacesInfectionDisaces.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visiInfection,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              userMedicalDiseacesInfectionDisaces
                                                  .removeAt(index);
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .infectionDisaces
                                                  .blocks
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);

                                              nombrebolckInfectiousDesease =
                                                  userMedicalDiseacesInfectionDisaces
                                                      .length;
                                              if (userMedicalDiseacesInfectionDisaces
                                                      .length ==
                                                  0) {
                                                _visiInfection = true;
                                              }
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              ExpandableListView(
                                  type: 'infectionDisaces',
                                  profile: profile,
                                  index: index,
                                  indexSubUser: widget.index,
                                  diseace: userMedicalDiseacesInfectionDisaces[
                                      index],
                                  title: userMedicalDiseacesInfectionDisaces[
                                          index]
                                      .label,
                                  desc: userMedicalDiseacesInfectionDisaces[
                                          index]
                                      .description,
                                  addBockDiseace: addBlockInfec,
                                  attachment:
                                      userMedicalDiseacesInfectionDisaces[index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                  documents:
                                      userMedicalDiseacesInfectionDisaces[index]
                                          .documents,
                                  alarm: userMedicalDiseacesInfectionDisaces[
                                                  index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders:
                                      userMedicalDiseacesInfectionDisaces[index]
                                          .reminders,
                                  text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: !_visiInfection),
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
                        userMedicalDiseacesInfectionDisaces.length == 0
                            ? MyButton(
                                title: "+ " +
                                    "editprofil_medical_btn_addinfection".tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed:
                                    nombrebolckInfectiousDesease < nbblock
                                        ? () {
                                            setState(() {
                                              nombrebolckInfectiousDesease++;

                                              addBlockInfec.add(true);
                                              Blocks infectiousDeases = Blocks(
                                                  description: '',
                                                  label: '',
                                                  documents: [],
                                                  reminders: []);
                                              userMedicalDiseacesInfectionDisaces
                                                  .add(infectiousDeases);

                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .infectionDisaces
                                                  .blocks
                                                  .add(infectiousDeases);
                                            });
                                          }
                                        : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiInfection,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: MyButton(
                                          title: "editprofil_general_btn_addnew"
                                              .tr(),
                                          height: 36.0,
                                          titleSize: 14,
                                          fontWeight: FontWeight.w500,
                                          titleColor:
                                              ColorConstant.primaryColor,
                                          miniWidth: 133.5,
                                          btnBgColor: Colors.white,
                                          onPressed:
                                              nombrebolckInfectiousDesease <
                                                      nbblock
                                                  ? () {
                                                      setState(() {
                                                        nombrebolckInfectiousDesease++;
                                                        for (int i = 0;
                                                            i <
                                                                addBlockInfec
                                                                    .length;
                                                            i++) {
                                                          if (addBlockInfec[
                                                                  i] ==
                                                              true) {
                                                            addBlockInfec[i] =
                                                                false;
                                                          }
                                                        }

                                                        addBlockInfec.add(true);
                                                        Blocks
                                                            infectiousDeases =
                                                            Blocks(
                                                                description: '',
                                                                label: '',
                                                                documents: [],
                                                                reminders: []);
                                                        userMedicalDiseacesInfectionDisaces
                                                            .add(
                                                                infectiousDeases);

                                                        profile
                                                            .userGeneralInfo
                                                            .subUsers[
                                                                widget.index]
                                                            .medicalRecord
                                                            .medicalDiseaces
                                                            .infectionDisaces
                                                            .blocks
                                                            .add(
                                                                infectiousDeases);
                                                      });
                                                    }
                                                  : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                      visible: _visiInfection,
                                      child: Expanded(
                                          flex: 5,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: MyButton(
                                              title:
                                                  "editprofil_general_btn_delete"
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor:
                                                  ColorConstant.primaryColor,
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiInfection = false;
                                                });
                                              },
                                            ),
                                          ))),
                                  Visibility(
                                    visible: !_visiInfection,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      ColorConstant.pinkColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiInfection =
                                                        !_visiInfection;
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

  _Allergies(Profile profile) {
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
              color: _allergies || _allergiesStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(_allergies ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _allergies = !_allergies;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _dnr = false;
                  _implants = false;
                  _renalKidney = false;
                  cardiac = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _medication = false;
                  _cancer = false;
                  blood = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(_allergies ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_allergies".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: _allergies ||
                                    _allergiesStatus(profile, widget.index)
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    iconAttachmentMedicalAllergies() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderMedicalAllergies() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 11.3),
                            child: Image.asset(
                              "Assets/Images/alarm.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    _allergies
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        _allergies
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: userMedicalDiseacesAllergies.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visiAllergies,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              userMedicalDiseacesAllergies
                                                  .removeAt(index);
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .allergies
                                                  .blocks
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                              nombrebolckAllergies =
                                                  userMedicalDiseacesAllergies
                                                      .length;
                                              if (userMedicalDiseacesAllergies
                                                      .length ==
                                                  0) {
                                                _visiAllergies = true;
                                              }
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              ExpandableListView(
                                  type: 'allergies',
                                  profile: profile,
                                  index: index,
                                  indexSubUser: widget.index,
                                  diseace: userMedicalDiseacesAllergies[index],
                                  title:
                                      userMedicalDiseacesAllergies[index].label,
                                  desc: userMedicalDiseacesAllergies[index]
                                      .description,
                                  addBockDiseace: addBlockAllerg,
                                  attachment:
                                      userMedicalDiseacesAllergies[index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                  documents: userMedicalDiseacesAllergies[index]
                                      .documents,
                                  alarm: userMedicalDiseacesAllergies[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders: userMedicalDiseacesAllergies[index]
                                      .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: !_visiAllergies),
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
                        userMedicalDiseacesAllergies.length == 0
                            ? MyButton(
                                title: "+ " +
                                    "editprofil_medical_btn_addallergie".tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckAllergies < nbblock
                                    ? () {
                                        nombrebolckAllergies++;
                                        setState(() {
                                          addBlockAllerg.add(true);
                                          Blocks allergies = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesAllergies
                                              .add(allergies);
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .medicalDiseaces
                                              .allergies
                                              .blocks
                                              .add(allergies);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiAllergies,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: MyButton(
                                          title: "editprofil_general_btn_addnew"
                                              .tr(),
                                          height: 36.0,
                                          titleSize: 14,
                                          fontWeight: FontWeight.w500,
                                          titleColor:
                                              ColorConstant.primaryColor,
                                          miniWidth: 133.5,
                                          btnBgColor: Colors.white,
                                          onPressed: nombrebolckAllergies <
                                                  nbblock
                                              ? () {
                                                  nombrebolckAllergies++;
                                                  setState(() {
                                                    for (int i = 0;
                                                        i <
                                                            addBlockAllerg
                                                                .length;
                                                        i++) {
                                                      if (addBlockAllerg[i] ==
                                                          true) {
                                                        addBlockAllerg[i] =
                                                            false;
                                                      }
                                                    }

                                                    addBlockAllerg.add(true);
                                                    Blocks allergies = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesAllergies
                                                        .add(allergies);
                                                    profile
                                                        .userGeneralInfo
                                                        .subUsers[widget.index]
                                                        .medicalRecord
                                                        .medicalDiseaces
                                                        .allergies
                                                        .blocks
                                                        .add(allergies);
                                                  });
                                                }
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                    visible: _visiAllergies,
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
                                              child: MyText(
                                                value:
                                                    "editprofil_general_btn_delete"
                                                        .tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorConstant.primaryColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _visiAllergies = false;
                                                  _visibile = _visiAllergies;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !_visiAllergies,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiAllergies =
                                                        !_visiAllergies;
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

  _Dnr(Profile profile) {
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
              color: _dnr || _DnrStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(_dnr ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _dnr = !_dnr;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _allergies = false;
                  _implants = false;
                  _renalKidney = false;
                  cardiac = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _medication = false;
                  _cancer = false;
                  blood = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(_dnr ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 11),
                      child: MyText(
                          value: "editprofil_label_donotrecusitate".tr(),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: _dnr || _DnrStatus(profile, widget.index)
                              ? ColorConstant.textColor
                              : ColorConstant.darkGray),
                    )),
                    _dnr
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        _dnr
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
                    color: ColorConstant.primaryColor,
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
                              Container(),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                ExpandableDnrView(
                                  profile: profile,

                                  index: index,
                                  indexSubUser: widget.index,
                                  // text: bloodController,
                                  resuscitateInfo: profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .medicalRecord
                                      .resuscitate,
                                  documents: profile
                                      .userGeneralInfo
                                      .subUsers[widget.index]
                                      .medicalRecord
                                      .resuscitate
                                      .documents,
                                  switchValue: true,
                                  attachment: true,

                                  visibile:
                                      false /* profile.medicalRecord.organDonar.donar==1
                                  ?true:
                                  false */
                                  ,
                                ),
                              ],
                            );
                          },
                        ),
                        Container(
                            height: 0.45,
                            color: ColorConstant.dividerColor.withOpacity(.30)),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  implants(Profile profile) {
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
              color: _implants || _implantsStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor

              /*  userMedicalDiseacesImplants.length==0 ? ColorConstant.boxColor:ColorConstant.pinkColor */,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(_implants ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _implants = !_implants;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _dnr = false;
                  _allergies = false;
                  _renalKidney = false;
                  cardiac = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _medication = false;
                  _cancer = false;
                  blood = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(_implants ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_implants".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: _implants ||
                                    _implantsStatus(profile, widget.index)
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    iconAttachmentMedicalImplant() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderMedicalImplant() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 11.3),
                            child: Image.asset(
                              "Assets/Images/alarm.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    _implants
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        _implants
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: userMedicalDiseacesImplants.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visiimplants,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              userMedicalDiseacesImplants
                                                  .removeAt(index);
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .implants
                                                  .blocks
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                              nombrebolckImplant =
                                                  userMedicalDiseacesImplants
                                                      .length;
                                              if (userMedicalDiseacesImplants
                                                      .length ==
                                                  0) {
                                                _visiimplants = true;
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
                                  indexSubUser: widget.index,
                                  type: 'Implants',
                                  diseace: userMedicalDiseacesImplants[index],
                                  title:
                                      userMedicalDiseacesImplants[index].label,
                                  desc: userMedicalDiseacesImplants[index]
                                      .description,
                                  addBockDiseace: addBlockImpl,
                                  attachment: userMedicalDiseacesImplants[index]
                                              .documents
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  documents: userMedicalDiseacesImplants[index]
                                      .documents,
                                  alarm: userMedicalDiseacesImplants[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders: userMedicalDiseacesImplants[index]
                                      .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: !_visiimplants),
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
                        userMedicalDiseacesImplants.length == 0
                            ? MyButton(
                                title: "+ " +
                                    "editprofil_medical_btn_addimplants".tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckImplant < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckImplant++;

                                          addBlockImpl.add(true);
                                          Blocks implants = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesImplants
                                              .add(implants);
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .medicalDiseaces
                                              .implants
                                              .blocks
                                              .add(implants);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                      visible: _visiimplants,
                                      child: Expanded(
                                        flex: 5,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: MyButton(
                                            title:
                                                "editprofil_general_btn_addnew"
                                                    .tr(),
                                            height: 36.0,
                                            titleSize: 14,
                                            fontWeight: FontWeight.w500,
                                            titleColor:
                                                ColorConstant.primaryColor,
                                            miniWidth: 133.5,
                                            btnBgColor: Colors.white,
                                            onPressed: nombrebolckImplant <
                                                    nbblock
                                                ? () {
                                                    setState(() {
                                                      for (int i = 0;
                                                          i <
                                                              addBlockImpl
                                                                  .length;
                                                          i++) {
                                                        if (addBlockImpl[i] ==
                                                            true) {
                                                          addBlockImpl[i] =
                                                              false;
                                                        }
                                                      }

                                                      addBlockImpl.add(true);
                                                      nombrebolckImplant++;
                                                      Blocks implants = Blocks(
                                                          description: '',
                                                          label: '',
                                                          documents: [],
                                                          reminders: []);
                                                      userMedicalDiseacesImplants
                                                          .add(implants);
                                                      profile
                                                          .userGeneralInfo
                                                          .subUsers[
                                                              widget.index]
                                                          .medicalRecord
                                                          .medicalDiseaces
                                                          .implants
                                                          .blocks
                                                          .add(implants);
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
                                    visible: _visiimplants,
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
                                              child: MyText(
                                                value:
                                                    "editprofil_general_btn_delete"
                                                        .tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorConstant.primaryColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _visiimplants = false;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !_visiimplants,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiimplants =
                                                        !_visiimplants;
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

  _RenalKidney(Profile profile) {
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
              color: _renalKidney || _RenalkendyStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(_renalKidney ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _renalKidney = !_renalKidney;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _dnr = false;
                  _allergies = false;
                  _implants = false;
                  cardiac = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _medication = false;
                  _cancer = false;
                  blood = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(_renalKidney ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_renal".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: _renalKidney ||
                                    _RenalkendyStatus(profile, widget.index)
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    iconAttachmentMedicalRenal() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderMedicalRenal() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 11.3),
                            child: Image.asset(
                              "Assets/Images/alarm.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    _renalKidney
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        _renalKidney
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: userMedicalDiseacesRenal.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visiRenal,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              userMedicalDiseacesRenal
                                                  .removeAt(index);
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .renalKenedy
                                                  .blocks
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                              nombrebolckRenal =
                                                  userMedicalDiseacesRenal
                                                      .length;
                                              if (userMedicalDiseacesRenal
                                                      .length ==
                                                  0) {
                                                _visiRenal = true;
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
                                  indexSubUser: widget.index,
                                  type: 'renalKenedy',
                                  diseace: userMedicalDiseacesRenal[index],
                                  title: userMedicalDiseacesRenal[index].label,
                                  desc: userMedicalDiseacesRenal[index]
                                      .description,
                                  addBockDiseace: addBlockRenal,
                                  attachment: userMedicalDiseacesRenal[index]
                                              .documents
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  documents:
                                      userMedicalDiseacesRenal[index].documents,
                                  alarm: userMedicalDiseacesRenal[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders:
                                      userMedicalDiseacesRenal[index].reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: !_visiRenal),
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
                        userMedicalDiseacesRenal.length == 0
                            ? MyButton(
                                title: "+ " +
                                    "editprofil_medical_btn_addrenal".tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckRenal < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckRenal++;

                                          addBlockRenal.add(true);
                                          Blocks renal = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesRenal.add(renal);

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .medicalDiseaces
                                              .renalKenedy
                                              .blocks
                                              .add(renal);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiRenal,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: MyButton(
                                          title: "editprofil_general_btn_addnew"
                                              .tr(),
                                          height: 36.0,
                                          titleSize: 14,
                                          fontWeight: FontWeight.w500,
                                          titleColor:
                                              ColorConstant.primaryColor,
                                          miniWidth: 133.5,
                                          btnBgColor: Colors.white,
                                          onPressed: nombrebolckRenal < nbblock
                                              ? () {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i <
                                                            addBlockRenal
                                                                .length;
                                                        i++) {
                                                      if (addBlockRenal[i] ==
                                                          true) {
                                                        addBlockRenal[i] =
                                                            false;
                                                      }
                                                    }

                                                    addBlockRenal.add(true);
                                                    nombrebolckRenal++;
                                                    Blocks renal = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesRenal
                                                        .add(renal);

                                                    profile
                                                        .userGeneralInfo
                                                        .subUsers[widget.index]
                                                        .medicalRecord
                                                        .medicalDiseaces
                                                        .renalKenedy
                                                        .blocks
                                                        .add(renal);
                                                  });
                                                }
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                      visible: _visiRenal,
                                      child: Expanded(
                                          flex: 5,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: MyButton(
                                              title:
                                                  "editprofil_general_btn_delete"
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor:
                                                  ColorConstant.primaryColor,
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiRenal = false;
                                                });
                                              },
                                            ),
                                          ))),
                                  Visibility(
                                    visible: !_visiRenal,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiRenal = !_visiRenal;
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

  _cardiac(Profile profile) {
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
              color: cardiac || _CardiacStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(cardiac ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  cardiac = !cardiac;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _dnr = false;
                  _allergies = false;
                  _implants = false;
                  _renalKidney = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _medication = false;
                  _cancer = false;
                  blood = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(cardiac ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_cardiac".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color:
                                cardiac || _CardiacStatus(profile, widget.index)
                                    ? ColorConstant.textColor
                                    : ColorConstant.darkGray),
                      ),
                    ),
                    iconAttachmentMedicalCardiac() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderMedicalCardiac() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 11.3),
                            child: Image.asset(
                              "Assets/Images/alarm.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    cardiac
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        cardiac
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: userMedicalDiseacesCardiac.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visiCardiac,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              userMedicalDiseacesCardiac
                                                  .removeAt(index);
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .cardiac
                                                  .blocks
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                              nombrebolckCardiac =
                                                  userMedicalDiseacesCardiac
                                                      .length;
                                              if (userMedicalDiseacesCardiac
                                                      .length ==
                                                  0) {
                                                _visiCardiac = true;
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
                                  type: 'cardiac',
                                  indexSubUser: widget.index,
                                  diseace: userMedicalDiseacesCardiac[index],
                                  title:
                                      userMedicalDiseacesCardiac[index].label,
                                  desc: userMedicalDiseacesCardiac[index]
                                      .description,
                                  addBockDiseace: addBlockCardiac,
                                  attachment: userMedicalDiseacesCardiac[index]
                                              .documents
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  documents: userMedicalDiseacesCardiac[index]
                                      .documents,
                                  alarm: userMedicalDiseacesCardiac[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders: userMedicalDiseacesCardiac[index]
                                      .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: !_visiCardiac),
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
                        userMedicalDiseacesCardiac.length == 0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "editprofil_medical_subtitle_cardiac".tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckCardiac < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckCardiac++;

                                          addBlockCardiac.add(true);
                                          Blocks cardiac = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesCardiac
                                              .add(cardiac);
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .medicalDiseaces
                                              .cardiac
                                              .blocks
                                              .add(cardiac);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiCardiac,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: MyButton(
                                          title: "editprofil_general_btn_addnew"
                                              .tr(),
                                          height: 36.0,
                                          titleSize: 14,
                                          fontWeight: FontWeight.w500,
                                          titleColor:
                                              ColorConstant.primaryColor,
                                          miniWidth: 133.5,
                                          btnBgColor: Colors.white,
                                          onPressed: nombrebolckCardiac <
                                                  nbblock
                                              ? () {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i <
                                                            addBlockCardiac
                                                                .length;
                                                        i++) {
                                                      if (addBlockCardiac[i] ==
                                                          true) {
                                                        addBlockCardiac[i] =
                                                            false;
                                                      }
                                                    }

                                                    addBlockCardiac.add(true);
                                                    nombrebolckCardiac++;
                                                    Blocks cardiac = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesCardiac
                                                        .add(cardiac);

                                                    profile
                                                        .userGeneralInfo
                                                        .subUsers[widget.index]
                                                        .medicalRecord
                                                        .medicalDiseaces
                                                        .cardiac
                                                        .blocks
                                                        .add(cardiac);
                                                  });
                                                }
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                      visible: _visiCardiac,
                                      child: Expanded(
                                          flex: 5,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: MyButton(
                                              title:
                                                  "editprofil_general_btn_delete"
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor:
                                                  ColorConstant.primaryColor,
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiCardiac = false;
                                                });
                                              },
                                            ),
                                          ))),
                                  Visibility(
                                    visible: !_visiCardiac,
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
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiCardiac =
                                                        !_visiCardiac;
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

  psychiatric(Profile profile) {
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
              color: _psychiatric || _PsychiatricStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(_psychiatric ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _psychiatric = !_psychiatric;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _dnr = false;
                  _allergies = false;
                  _implants = false;
                  _renalKidney = false;
                  cardiac = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _medication = false;
                  _cancer = false;
                  blood = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(_psychiatric ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value:
                                "editprofil_medical_subtitle_psychiatric".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: _psychiatric ||
                                    _psychiatric ||
                                    _PsychiatricStatus(profile, widget.index)
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    iconAttachmentMedicalPsy() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderMedicalPsy() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 11.3),
                            child: Image.asset(
                              "Assets/Images/alarm.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    _psychiatric
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        _psychiatric
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: userMedicalDiseacesPsychiatric.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visiPsych,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              userMedicalDiseacesPsychiatric
                                                  .removeAt(index);
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .psychiatric
                                                  .blocks
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                              nombrebolckPsychiatric =
                                                  userMedicalDiseacesPsychiatric
                                                      .length;
                                              if (userMedicalDiseacesPsychiatric
                                                      .length ==
                                                  0) {
                                                _visiPsych = true;
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
                                  indexSubUser: widget.index,
                                  index: index,
                                  type: 'psychiatric',
                                  addBockDiseace: addBlockPsy,
                                  diseace:
                                      userMedicalDiseacesPsychiatric[index],
                                  title:
                                      userMedicalDiseacesPsychiatric[index]
                                          .label,
                                  desc:
                                      userMedicalDiseacesPsychiatric[index]
                                          .description,
                                  attachment:
                                      userMedicalDiseacesPsychiatric[index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                  documents:
                                      userMedicalDiseacesPsychiatric[
                                              index]
                                          .documents,
                                  alarm: userMedicalDiseacesPsychiatric[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders:
                                      userMedicalDiseacesPsychiatric[index]
                                          .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: !_visiPsych),
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
                        userMedicalDiseacesPsychiatric.length == 0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "editprofil_medical_subtitle_psychiatric"
                                        .tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckPsychiatric < nbblock
                                    ? () {
                                        setState(() {
                                          addBlockPsy.add(true);
                                          nombrebolckPsychiatric++;
                                          Blocks psychiatric = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesPsychiatric
                                              .add(psychiatric);

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .medicalDiseaces
                                              .psychiatric
                                              .blocks
                                              .add(psychiatric);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiPsych,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: MyButton(
                                          title: "editprofil_general_btn_addnew"
                                              .tr(),
                                          height: 36.0,
                                          titleSize: 14,
                                          fontWeight: FontWeight.w500,
                                          titleColor:
                                              ColorConstant.primaryColor,
                                          miniWidth: 133.5,
                                          btnBgColor: Colors.white,
                                          onPressed: nombrebolckPsychiatric <
                                                  nbblock
                                              ? () {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i < addBlockPsy.length;
                                                        i++) {
                                                      if (addBlockPsy[i] ==
                                                          true) {
                                                        addBlockPsy[i] = false;
                                                      }
                                                    }

                                                    addBlockPsy.add(true);
                                                    nombrebolckPsychiatric++;
                                                    Blocks psychiatric = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesPsychiatric
                                                        .add(psychiatric);

                                                    profile
                                                        .userGeneralInfo
                                                        .subUsers[widget.index]
                                                        .medicalRecord
                                                        .medicalDiseaces
                                                        .psychiatric
                                                        .blocks
                                                        .add(psychiatric);
                                                  });
                                                }
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                      visible: _visiPsych,
                                      child: Expanded(
                                          flex: 5,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: MyButton(
                                              title:
                                                  "editprofil_general_btn_delete"
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor:
                                                  ColorConstant.primaryColor,
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiPsych = false;
                                                });
                                              },
                                            ),
                                          ))),
                                  Visibility(
                                    visible: !_visiPsych,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiPsych = !_visiPsych;
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

  _Neurologic(Profile profile) {
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
              color: _neurologic || _NeurologicStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(_neurologic ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _neurologic = !_neurologic;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _dnr = false;
                  _allergies = false;
                  _implants = false;
                  _renalKidney = false;
                  cardiac = false;
                  _psychiatric = false;
                  _pulmonary = false;
                  _medication = false;
                  _cancer = false;
                  blood = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(_neurologic ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value:
                                "editprofil_medical_subtitle_neurologic".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: _neurologic ||
                                    _NeurologicStatus(profile, widget.index)
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    iconAttachmentMedicalNeuro() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderMedicalNeuro() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 11.3),
                            child: Image.asset(
                              "Assets/Images/alarm.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    _neurologic
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        _neurologic
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: userMedicalDiseacesNeurologic.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visiNeuro,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              userMedicalDiseacesNeurologic
                                                  .removeAt(index);
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .neuroligic
                                                  .blocks
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);

                                              nombrebolckNeurologic =
                                                  userMedicalDiseacesNeurologic
                                                      .length;
                                              if (userMedicalDiseacesNeurologic
                                                      .length ==
                                                  0) {
                                                _visiNeuro = true;
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
                                  indexSubUser: widget.index,
                                  index: index,
                                  type: 'neuroligic',
                                  addBockDiseace: addBlockNeuro,
                                  diseace: userMedicalDiseacesNeurologic[index],
                                  title: userMedicalDiseacesNeurologic[index]
                                      .label,
                                  desc: userMedicalDiseacesNeurologic[index]
                                      .description,
                                  attachment:
                                      userMedicalDiseacesNeurologic[index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                  documents:
                                      userMedicalDiseacesNeurologic[index]
                                          .documents,
                                  alarm: userMedicalDiseacesNeurologic[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders:
                                      userMedicalDiseacesNeurologic[index]
                                          .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: !_visiNeuro),
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
                        userMedicalDiseacesNeurologic.length == 0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "editprofil_medical_subtitle_neurologic"
                                        .tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckNeurologic < nbblock
                                    ? () {
                                        setState(() {
                                          addBlockNeuro.add(true);
                                          nombrebolckNeurologic++;
                                          Blocks neuroligic = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesNeurologic
                                              .add(neuroligic);

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .medicalDiseaces
                                              .neuroligic
                                              .blocks
                                              .add(neuroligic);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiNeuro,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: MyButton(
                                          title: "editprofil_general_btn_addnew"
                                              .tr(),
                                          height: 36.0,
                                          titleSize: 14,
                                          fontWeight: FontWeight.w500,
                                          titleColor:
                                              ColorConstant.primaryColor,
                                          miniWidth: 133.5,
                                          btnBgColor: Colors.white,
                                          onPressed: nombrebolckNeurologic <
                                                  nbblock
                                              ? () {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i <
                                                            addBlockNeuro
                                                                .length;
                                                        i++) {
                                                      if (addBlockNeuro[i] ==
                                                          true) {
                                                        addBlockNeuro[i] =
                                                            false;
                                                      }
                                                    }

                                                    addBlockNeuro.add(true);
                                                    nombrebolckNeurologic++;
                                                    Blocks neuroligic = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesNeurologic
                                                        .add(neuroligic);

                                                    profile
                                                        .userGeneralInfo
                                                        .subUsers[widget.index]
                                                        .medicalRecord
                                                        .medicalDiseaces
                                                        .neuroligic
                                                        .blocks
                                                        .add(neuroligic);
                                                  });
                                                }
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                      visible: _visiNeuro,
                                      child: Expanded(
                                          flex: 5,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: MyButton(
                                              title:
                                                  "editprofil_general_btn_delete"
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor:
                                                  ColorConstant.primaryColor,
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiNeuro = false;
                                                });
                                              },
                                            ),
                                          ))),
                                  Visibility(
                                    visible: !_visiNeuro,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiNeuro = !_visiNeuro;
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

  pulmonary(Profile profile) {
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
              color: _pulmonary || _PulmonaryStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(_pulmonary ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _pulmonary = !_pulmonary;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _dnr = false;
                  _allergies = false;
                  _implants = false;
                  _renalKidney = false;
                  cardiac = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _medication = false;
                  _cancer = false;
                  blood = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(_pulmonary ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_pulmonary".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: _pulmonary ||
                                    _PulmonaryStatus(profile, widget.index)
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    iconAttachmentMedicalPulmo() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderMedicalPulmo() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 11.3),
                            child: Image.asset(
                              "Assets/Images/alarm.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    _pulmonary
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        _pulmonary
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: userMedicalDiseacesPlumonary.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visiPul,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              userMedicalDiseacesPlumonary
                                                  .removeAt(index);
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .plumonary
                                                  .blocks
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);

                                              nombrebolckPulmonary =
                                                  userMedicalDiseacesPlumonary
                                                      .length;
                                              if (userMedicalDiseacesPlumonary
                                                      .length ==
                                                  0) {
                                                _visiPul = true;
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
                                  indexSubUser: widget.index,
                                  type: 'plumonary',
                                  addBockDiseace: addBlockPulmo,
                                  diseace: userMedicalDiseacesPlumonary[index],
                                  title:
                                      userMedicalDiseacesPlumonary[index].label,
                                  desc: userMedicalDiseacesPlumonary[index]
                                      .description,
                                  attachment:
                                      userMedicalDiseacesPlumonary[index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                  documents: userMedicalDiseacesPlumonary[index]
                                      .documents,
                                  alarm: userMedicalDiseacesPlumonary[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders: userMedicalDiseacesPlumonary[index]
                                      .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: !_visiPul),
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
                        userMedicalDiseacesPlumonary.length == 0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "editprofil_medical_subtitle_pulmonary"
                                        .tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckPulmonary < nbblock
                                    ? () {
                                        setState(() {
                                          addBlockPulmo.add(true);
                                          nombrebolckPulmonary++;
                                          Blocks plumonary = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesPlumonary
                                              .add(plumonary);

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .medicalDiseaces
                                              .plumonary
                                              .blocks
                                              .add(plumonary);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiPul,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: MyButton(
                                          title: "editprofil_general_btn_addnew"
                                              .tr(),
                                          height: 36.0,
                                          titleSize: 14,
                                          fontWeight: FontWeight.w500,
                                          titleColor:
                                              ColorConstant.primaryColor,
                                          miniWidth: 133.5,
                                          btnBgColor: Colors.white,
                                          onPressed: nombrebolckPulmonary <
                                                  nbblock
                                              ? () {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i <
                                                            addBlockPulmo
                                                                .length;
                                                        i++) {
                                                      if (addBlockPulmo[i] ==
                                                          true) {
                                                        addBlockPulmo[i] =
                                                            false;
                                                      }
                                                    }

                                                    addBlockPulmo.add(true);
                                                    nombrebolckPulmonary++;
                                                    Blocks plumonary = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesPlumonary
                                                        .add(plumonary);

                                                    profile
                                                        .userGeneralInfo
                                                        .subUsers[widget.index]
                                                        .medicalRecord
                                                        .medicalDiseaces
                                                        .plumonary
                                                        .blocks
                                                        .add(plumonary);
                                                  });
                                                }
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                      visible: _visiPul,
                                      child: Expanded(
                                          flex: 5,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: MyButton(
                                              title:
                                                  "editprofil_general_btn_delete"
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor:
                                                  ColorConstant.primaryColor,
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiPul = false;
                                                });
                                              },
                                            ),
                                          ))),
                                  Visibility(
                                    visible: !_visiPul,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiPul = !_visiPul;
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

  _Medication(Profile profile) {
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
              color: _medication || _MedicationStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(_medication ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _medication = !_medication;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _dnr = false;
                  _allergies = false;
                  _implants = false;
                  _renalKidney = false;
                  cardiac = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _cancer = false;
                  blood = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(_medication ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value:
                                "editprofil_medical_subtitle_medication".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: _medication ||
                                    _MedicationStatus(profile, widget.index)
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    iconAttachmentMedicalMedication() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderMedicalMedication() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 11.3),
                            child: Image.asset(
                              "Assets/Images/alarm.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    _medication
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        _medication
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: userMedicalDiseacesMedication.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visiMedication,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              userMedicalDiseacesMedication
                                                  .removeAt(index);
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .medication
                                                  .blocks
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);

                                              nombrebolckMedication =
                                                  userMedicalDiseacesMedication
                                                      .length;
                                              if (userMedicalDiseacesMedication
                                                      .length ==
                                                  0) {
                                                _visiMedication = true;
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
                                  indexSubUser: widget.index,
                                  addBockDiseace: addBlockMedica,
                                  type: 'medication',
                                  diseace: userMedicalDiseacesMedication[index],
                                  title: userMedicalDiseacesMedication[index]
                                      .label,
                                  desc: userMedicalDiseacesMedication[index]
                                      .description,
                                  attachment:
                                      userMedicalDiseacesMedication[index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                  documents:
                                      userMedicalDiseacesMedication[index]
                                          .documents,
                                  alarm: userMedicalDiseacesMedication[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders:
                                      userMedicalDiseacesMedication[index]
                                          .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: !_visiMedication),
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
                        userMedicalDiseacesMedication.length == 0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "editprofil_medical_subtitle_medication"
                                        .tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckMedication < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckMedication++;

                                          addBlockMedica.add(true);
                                          Blocks medication = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesMedication
                                              .add(medication);

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .medicalDiseaces
                                              .medication
                                              .blocks
                                              .add(medication);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiMedication,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: MyButton(
                                          title: "editprofil_general_btn_addnew"
                                              .tr(),
                                          height: 36.0,
                                          titleSize: 14,
                                          fontWeight: FontWeight.w500,
                                          titleColor:
                                              ColorConstant.primaryColor,
                                          miniWidth: 133.5,
                                          btnBgColor: Colors.white,
                                          onPressed: nombrebolckMedication <
                                                  nbblock
                                              ? () {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i <
                                                            addBlockMedica
                                                                .length;
                                                        i++) {
                                                      if (addBlockMedica[i] ==
                                                          true) {
                                                        addBlockMedica[i] =
                                                            false;
                                                      }
                                                    }

                                                    addBlockMedica.add(true);
                                                    nombrebolckMedication++;
                                                    Blocks medication = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesMedication
                                                        .add(medication);

                                                    profile
                                                        .userGeneralInfo
                                                        .subUsers[widget.index]
                                                        .medicalRecord
                                                        .medicalDiseaces
                                                        .medication
                                                        .blocks
                                                        .add(medication);
                                                  });
                                                }
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                      visible: _visiMedication,
                                      child: Expanded(
                                          flex: 5,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: MyButton(
                                              title:
                                                  "editprofil_general_btn_delete"
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor:
                                                  ColorConstant.primaryColor,
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiMedication = false;
                                                });
                                              },
                                            ),
                                          ))),
                                  Visibility(
                                    visible: !_visiMedication,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiMedication =
                                                        !_visiMedication;
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

  cancer(Profile profile) {
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
              color: _cancer || _CancerStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(_cancer ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _cancer = !_cancer;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _dnr = false;
                  _allergies = false;
                  _implants = false;
                  _renalKidney = false;
                  cardiac = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _medication = false;
                  blood = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(cardiac ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_cancer".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color:
                                _cancer || _CancerStatus(profile, widget.index)
                                    ? ColorConstant.textColor
                                    : ColorConstant.darkGray),
                      ),
                    ),
                    iconAttachmentMedicalCancer() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderMedicalCancer() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 11.3),
                            child: Image.asset(
                              "Assets/Images/alarm.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    _cancer
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        _cancer
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: userMedicalDiseacesCancer.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                                child: Visibility(
                                  visible: !_visiCancer,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red, //button colour
                                      child: InkWell(
                                          splashColor: Colors
                                              .red, // inkwell onPress colour
                                          child: SizedBox(
                                              width: 24,
                                              height:
                                                  24, //customisable size of 'button'
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: Colors.white,
                                                size: 16,
                                              ))),
                                          onTap: () {
                                            setState(() {
                                              userMedicalDiseacesCancer
                                                  .removeAt(index);
                                              profile
                                                  .userGeneralInfo
                                                  .subUsers[widget.index]
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .cancer
                                                  .blocks
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);

                                              nombrebolckCancer =
                                                  userMedicalDiseacesCancer
                                                      .length;
                                              if (userMedicalDiseacesCancer
                                                      .length ==
                                                  0) {
                                                _visiCancer = true;
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
                                  indexSubUser: widget.index,
                                  type: 'cancer',
                                  diseace: userMedicalDiseacesCancer[index],
                                  title: userMedicalDiseacesCancer[index].label,
                                  desc: userMedicalDiseacesCancer[index]
                                      .description,
                                  addBockDiseace: addBlockCancer,
                                  attachment: userMedicalDiseacesCancer[index]
                                              .documents
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  documents: userMedicalDiseacesCancer[index]
                                      .documents,
                                  alarm: userMedicalDiseacesCancer[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders: userMedicalDiseacesCancer[index]
                                      .reminders,
                                  text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: !_visiCancer),
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
                        userMedicalDiseacesCancer.length == 0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "editprofil_medical_subtitle_cancer".tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckCancer < nbblock
                                    ? () {
                                        setState(() {
                                          addBlockCancer.add(true);
                                          nombrebolckCancer++;
                                          Blocks cancer = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesCancer.add(cancer);

                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .medicalDiseaces
                                              .cancer
                                              .blocks
                                              .add(cancer);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiCancer,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: MyButton(
                                          title: "editprofil_general_btn_addnew"
                                              .tr(),
                                          height: 36.0,
                                          titleSize: 14,
                                          fontWeight: FontWeight.w500,
                                          titleColor:
                                              ColorConstant.primaryColor,
                                          miniWidth: 133.5,
                                          btnBgColor: Colors.white,
                                          onPressed: nombrebolckCancer < nbblock
                                              ? () {
                                                  setState(() {
                                                    nombrebolckCancer++;
                                                    for (int i = 0;
                                                        i <
                                                            addBlockCancer
                                                                .length;
                                                        i++) {
                                                      if (addBlockCancer[i] ==
                                                          true) {
                                                        addBlockCancer[i] =
                                                            false;
                                                      }
                                                    }

                                                    addBlockCancer.add(true);
                                                    Blocks cancer = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesCancer
                                                        .add(cancer);

                                                    profile
                                                        .userGeneralInfo
                                                        .subUsers[widget.index]
                                                        .medicalRecord
                                                        .medicalDiseaces
                                                        .cancer
                                                        .blocks
                                                        .add(cancer);
                                                  });
                                                }
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                      visible: _visiCancer,
                                      child: Expanded(
                                          flex: 5,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: MyButton(
                                              title:
                                                  "editprofil_general_btn_delete"
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor:
                                                  ColorConstant.primaryColor,
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiCancer = false;
                                                });
                                              },
                                            ),
                                          ))),
                                  Visibility(
                                    visible: !_visiCancer,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiCancer = !_visiCancer;
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

  _blood(Profile profile) {
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
              color: blood || _BoooldStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(blood ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  blood = !blood;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _dnr = false;
                  _allergies = false;
                  _implants = false;
                  _renalKidney = false;
                  cardiac = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _medication = false;
                  _cancer = false;
                  other = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(blood ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_blood".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: blood || _BoooldStatus(profile, widget.index)
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    iconAttachmentMedicalBlood() == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container(),
                    iconReminderMedicalBlood() == true
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
                    blood
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        blood
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
                    color: ColorConstant.primaryColor,
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
                        SizedBox(
                          height: 18.5,
                        ),
                        Row(
                          children: [
                            MyText(
                                value:
                                    "editprofil_medical_label_bloodtype".tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: ColorConstant.textColor),
                            SizedBox(
                              width: 23,
                            ),
                            Container(
                              height: 24,
                              width: 80,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  items: profile.parameters.bloodList
                                          .map(
                                            (e) => DropdownMenuItem(
                                              child: MyText(
                                                  value: e['type'],
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ColorConstant.textColor),
                                              value: e,
                                            ),
                                          )
                                          .toList() ??
                                      [],
                                  onChanged: (newVal) {
                                    setState(() {
                                      profile
                                          .userGeneralInfo
                                          .subUsers[widget.index]
                                          .medicalRecord
                                          .bloodInfo
                                          .idBloodType = newVal['id'];
                                    });
                                  },
                                  isExpanded: true,
                                  value: bloodData,
                                  hint: profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .bloodInfo
                                              .idBloodType !=
                                          null
                                      ? MyText(
                                          value: profile.parameters.bloodList[
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .medicalRecord
                                                      .bloodInfo
                                                      .idBloodType -
                                                  1]['type'],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: ColorConstant.textColor)
                                      : MyText(
                                          value: ' ',
                                        ),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: ColorConstant.textfieldColor,
                                borderRadius: BorderRadius.circular(5.0),
                                // border: Border.all(style: BorderStyle.solid, width: 0.70),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        MyText(
                            value: '',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorConstant.textColor),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      value:
                                          "editprofil_medical_label_bloodsystolic"
                                              .tr(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: ColorConstant.textColor),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 24,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        items: systolicList
                                            .map((value) => DropdownMenuItem(
                                                  child: MyText(
                                                      value: value,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ColorConstant
                                                          .textColor),
                                                  value: value,
                                                ))
                                            .toList(),
                                        onChanged: (newVal) {
                                          setState(() {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .medicalRecord
                                                .bloodInfo
                                                .bloodSystolic = newVal;
                                            systolicData = newVal;
                                          });
                                        },
                                        isExpanded: true,
                                        value: systolicData,
                                        hint: MyText(
                                            value: profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .bloodInfo
                                                    .bloodSystolic ??
                                                " ",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.darkGray),
                                      ),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.textfieldColor,
                                      borderRadius: BorderRadius.circular(5.0),
                                      // border: Border.all(style: BorderStyle.solid, width: 0.70),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      value:
                                          "editprofil_medical_label_blooddiastolic"
                                              .tr(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: ColorConstant.textColor),
                                  SizedBox(height: 5),
                                  Container(
                                    height: 24,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        items: diastolicList
                                            .map((value) => DropdownMenuItem(
                                                  child: MyText(
                                                      value: value,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ColorConstant
                                                          .textColor),
                                                  value: value,
                                                ))
                                            .toList(),
                                        onChanged: (newVal) {
                                          setState(() {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .medicalRecord
                                                .bloodInfo
                                                .bloodDiastolic = newVal;
                                            diastolicData = newVal;
                                          });
                                        },
                                        isExpanded: true,
                                        value: diastolicData,
                                        hint: MyText(
                                            value: profile
                                                    .userGeneralInfo
                                                    .subUsers[widget.index]
                                                    .medicalRecord
                                                    .bloodInfo
                                                    .bloodDiastolic ??
                                                ' ',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.darkGray),
                                      ),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.textfieldColor,
                                      borderRadius: BorderRadius.circular(5.0),
                                      // border: Border.all(style: BorderStyle.solid, width: 0.70),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 17),
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.30)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMedicalBloodDiabates.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5.0, top: 8),
                                    child: Visibility(
                                      visible: !_visiBoold,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.red, //button colour
                                          child: InkWell(
                                              splashColor: Colors
                                                  .red, // inkwell onPress colour
                                              child: SizedBox(
                                                  width: 24,
                                                  height:
                                                      24, //customisable size of 'button'
                                                  child: Center(
                                                      child: FaIcon(
                                                    FontAwesomeIcons.minus,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ))),
                                              onTap: () {
                                                setState(() {
                                                  print(userMedicalBloodDiabates
                                                      .length);
                                                  userMedicalBloodDiabates
                                                      .removeAt(index);
                                                  print(userMedicalBloodDiabates
                                                      .length);
                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .medicalRecord
                                                      .bloodInfo
                                                      .diabates
                                                      .removeAt(index);

                                                  nombrebolckBlood =
                                                      userMedicalBloodDiabates
                                                          .length;
                                                  if (userMedicalBloodDiabates
                                                          .length ==
                                                      0) {
                                                    _visiBoold = true;
                                                  }
                                                });
                                              }),
                                        ),
                                      ),
                                    )),
                                ExpandableListViewBlood(
                                  key: Key(userMedicalBloodDiabates[index]
                                      .diabeteDescription),
                                  profile: profile,
                                  indexSubUser: widget.index,
                                  index: index,
                                  addBlockBlood: addBlockBlood,
                                  diseace: userMedicalBloodDiabates[index],
                                  visible: _visiBoold,

                                  // text: bloodController,
                                  switchValue:
                                      userMedicalBloodDiabates[index].active ==
                                              1
                                          ? true
                                          : false,
                                  dropdownValue: true,
                                ),
                              ],
                            );
                          },
                        ),
                        Container(
                            height: 0.45,
                            color: ColorConstant.dividerColor.withOpacity(.30)),
                        SizedBox(
                          height: 16.5,
                        ),
                        userMedicalBloodDiabates.length == 0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "editprofil_medical_subtitle_blood".tr(),
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckBlood < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckBlood++;

                                          addBlockBlood.add(true);
                                          Diabates diabates = Diabates(
                                              active: 1,
                                              diabeteDescription: '',
                                              diabeteLabel: '',
                                              documents: [],
                                              reminder: []);
                                          userMedicalBloodDiabates
                                              .add(diabates);
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .bloodInfo
                                              .diabates
                                              .add(diabates);
                                        });
                                      }
                                    : null,
                              )
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _visiBoold,
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
                                            child: MyButton(
                                              title:
                                                  "editprofil_general_btn_addnew"
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor:
                                                  ColorConstant.primaryColor,
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: nombrebolckBlood <
                                                      nbblock
                                                  ? () {
                                                      setState(() {
                                                        nombrebolckBlood++;
                                                        for (int i = 0;
                                                            i <
                                                                addBlockBlood
                                                                    .length;
                                                            i++) {
                                                          if (addBlockBlood[
                                                                  i] ==
                                                              true) {
                                                            addBlockBlood[i] =
                                                                false;
                                                          }
                                                        }

                                                        addBlockBlood.add(true);
                                                        Diabates diabates =
                                                            Diabates(
                                                                active: 1,
                                                                diabeteDescription:
                                                                    '',
                                                                diabeteLabel:
                                                                    '',
                                                                documents: [],
                                                                reminder: []);
                                                        userMedicalBloodDiabates
                                                            .add(diabates);
                                                        profile
                                                            .userGeneralInfo
                                                            .subUsers[
                                                                widget.index]
                                                            .medicalRecord
                                                            .bloodInfo
                                                            .diabates
                                                            .add(diabates);
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
                                  Visibility(
                                    visible: _visiBoold,
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
                                            child: MyButton(
                                              title:
                                                  "editprofil_general_btn_delete"
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor:
                                                  ColorConstant.primaryColor,
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiBoold = false;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !_visiBoold,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiBoold = !_visiBoold;
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

  _organDonor(Profile profile) {
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
              color: organDonor || _OrganDonarStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(organDonor ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  organDonor = !organDonor;
                  _infectiousdiseases = false;
                  _dnr = false;
                  _allergies = false;
                  _implants = false;
                  _renalKidney = false;
                  cardiac = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _medication = false;
                  _cancer = false;
                  blood = false;
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
                        bottomRight: Radius.circular(organDonor ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11, right: 13),
                        child: MyText(
                            value:
                                "editprofil_medical_subtitle_organdonor".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: organDonor ||
                                    _OrganDonarStatus(profile, widget.index)
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                        // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                      ),
                    ),
                    organDonor
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
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
        organDonor
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
                    color: ColorConstant.primaryColor,
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
                        Stack(
                          children: [
                            profile.userGeneralInfo.subUsers[widget.index]
                                        .medicalRecord.organDonar !=
                                    null
                                ? ExpandableDonorView(
                                    profile: profile,

                                    // text: bloodController,
                                    donorinfo: profile
                                        .userGeneralInfo
                                        .subUsers[widget.index]
                                        .medicalRecord
                                        .organDonar,
                                    switchValue: true,
                                    documents: profile
                                        .userGeneralInfo
                                        .subUsers[widget.index]
                                        .medicalRecord
                                        .organDonar
                                        .documents,
                                    indexSubUser: widget.index,
                                    visibile:
                                        false /* profile.medicalRecord.organDonar.donar==1
                                  ?true:
                                  false */
                                    ,
                                  )
                                : Container(),
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

  _other(Profile profile) {
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
              color: other || _otherStatus(profile, widget.index)
                  ? ColorConstant.primaryColor
                  : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(other ? 0 : .0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  other = !other;
                  _infectiousdiseases = false;
                  organDonor = false;
                  _dnr = false;
                  _allergies = false;
                  _implants = false;
                  _renalKidney = false;
                  cardiac = false;
                  _psychiatric = false;
                  _neurologic = false;
                  _pulmonary = false;
                  _medication = false;
                  _cancer = false;
                  blood = false;
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
                          "Assets/Images/threedot.png",
                          height: 6,
                          width: 24,
                          color: other || _otherStatus(profile, widget.index)
                              ? null
                              : ColorConstant.darkGray,
                        ) /**/
                        // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                        ),
                    MyText(
                        value: "editprofil_medical_label_other".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: other || _otherStatus(profile, widget.index)
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
                            "Assets/Images/arrow-up.png",
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
                    color: ColorConstant.primaryColor,
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
                          itemCount: profile
                              .userGeneralInfo
                              .subUsers[widget.index]
                              .medicalRecord
                              .otherMedicalRecordInfo
                              .length,
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
                                          color: Colors.red, //button colour
                                          child: InkWell(
                                              splashColor: Colors
                                                  .red, // inkwell onPress colour
                                              child: SizedBox(
                                                  width: 24,
                                                  height:
                                                      24, //customisable size of 'button'
                                                  child: Center(
                                                      child: FaIcon(
                                                    FontAwesomeIcons.minus,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ))),
                                              onTap: () {
                                                setState(() {
                                                  profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .medicalRecord
                                                      .otherMedicalRecordInfo
                                                      .removeAt(index);
                                                  nombrebolckOther = profile
                                                      .userGeneralInfo
                                                      .subUsers[widget.index]
                                                      .medicalRecord
                                                      .otherMedicalRecordInfo
                                                      .length;
                                                  if (profile
                                                          .userGeneralInfo
                                                          .subUsers[
                                                              widget.index]
                                                          .medicalRecord
                                                          .otherMedicalRecordInfo
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
                                  child: new ExpandableOtherList(
                                    profile: profile,
                                    index: index,
                                    other: profile
                                        .userGeneralInfo
                                        .subUsers[widget.index]
                                        .medicalRecord
                                        .otherMedicalRecordInfo[index],
                                    title: profile
                                        .userGeneralInfo
                                        .subUsers[widget.index]
                                        .medicalRecord
                                        .otherMedicalRecordInfo[index]
                                        .label,
                                    desc: profile
                                        .userGeneralInfo
                                        .subUsers[widget.index]
                                        .medicalRecord
                                        .otherMedicalRecordInfo[index]
                                        .description,
                                    attachments: profile
                                        .userGeneralInfo
                                        .subUsers[widget.index]
                                        .medicalRecord
                                        .otherMedicalRecordInfo[index]
                                        .documents,
                                    reminders: profile
                                        .userGeneralInfo
                                        .subUsers[widget.index]
                                        .medicalRecord
                                        .otherMedicalRecordInfo[index]
                                        .reminder,
                                    addBlockOther: addBlockOther,
                                    indexSubUser: widget.index,
                                    switchValue: profile
                                                .userGeneralInfo
                                                .subUsers[widget.index]
                                                .medicalRecord
                                                .otherMedicalRecordInfo[index]
                                                .allow ==
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
                        profile
                                    .userGeneralInfo
                                    .subUsers[widget.index]
                                    .medicalRecord
                                    .otherMedicalRecordInfo
                                    .length ==
                                0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "editprofil_medical_label_other".tr(),
                                height: 36.0,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckOther < nbblock
                                    ? () {
                                        setState(() {
                                          addBlockOther.add(true);
                                          OtherMedicalRecordInfo
                                              otherMedicalRecordInfo =
                                              OtherMedicalRecordInfo(
                                                  allow: 1,
                                                  description: "",
                                                  label: '',
                                                  documents: [],
                                                  reminder: []);
                                          profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .otherMedicalRecordInfo
                                              .add(otherMedicalRecordInfo);
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
                                            title:
                                                "editprofil_general_btn_addnew"
                                                    .tr(),
                                            height: 36.0,
                                            titleSize: 14,
                                            fontWeight: FontWeight.w500,
                                            titleColor:
                                                ColorConstant.primaryColor,
                                            miniWidth: 133.5,
                                            btnBgColor: Colors.white,
                                            onPressed: nombrebolckOther <
                                                    nbblock
                                                ? () {
                                                    setState(() {
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
                                                      OtherMedicalRecordInfo
                                                          otherMedicalRecordInfo =
                                                          OtherMedicalRecordInfo(
                                                              allow: 1,
                                                              description: "",
                                                              label: '',
                                                              documents: [],
                                                              reminder: []);
                                                      profile
                                                          .userGeneralInfo
                                                          .subUsers[
                                                              widget.index]
                                                          .medicalRecord
                                                          .otherMedicalRecordInfo
                                                          .add(
                                                              otherMedicalRecordInfo);
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
                                              child: MyText(
                                                value:
                                                    "editprofil_general_btn_delete"
                                                        .tr(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorConstant.primaryColor,
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
                                                child: MyText(
                                                  value:
                                                      'editprofil_general_btn_done'
                                                          .tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .primaryColor,
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

  // ignore: non_constant_identifier_names
  _ViewExport(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
            height: 49,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black26,

                    offset: Offset(1.0, 3.0),
                    //  spreadRadius: 7.0,
                    blurRadius: 3.0,
                  ),
                ],
                color: ColorConstant.primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Container(
                height: 49,
                padding: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(color: ColorConstant.separatedColor),
                child: Container(
                  height: 49,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.pinkColor,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _scrollController.jumpTo(450);

                          viewExport = !viewExport;
                          medicInfo = false;
                          emegInfo = false;
                          persInfo = false;
                          medicalTag = false;
                          memebrs = false;
                          advancedSettings = false;
                          alsoInfo = false;
                          contact = false;
                        });
                      },
                      child: Container(
                        height: 49,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 11, right: 21),
                              child: Image.asset(
                                "Assets/Images/view.png",
                                height: 32,
                                width: 31,
                              ),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: MyText(
                                        value: "pets_label_viewexport".tr(),
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
                            viewExport
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
                ))),
        viewExport
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
                        _generalAndMedical(profile),
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

  _generalAndMedical(Profile profile) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                if (profile.userGeneralInfo.update == false) {
                  dispatchViewProfile(profile, widget.index);
                } else {
                  showOverlayUpdate(
                      context,
                      "messages_label_confirmationleave".tr(),
                      "messages_label_confirmationdesc".tr(),
                      profile,
                      widget.index);
                }
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
                        color: _viewRecord
                            ? ColorConstant.pinkColor
                            : ColorConstant.boxColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
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
                      value: "editprofil_medical_btn_viewprofile".tr(),
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
                  // _printRecord = !_printRecord;
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
                            : ColorConstant.boxColor,
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
                      value: "editprofil_general_label_print".tr(),
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
                  //  _emailRecord = !_emailRecord;
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
                      color: _emailRecord
                          ? ColorConstant.pinkColor
                          : ColorConstant.boxColor,
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
                      value: "editprofil_general_subtitle_email".tr(),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.textColor)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dispatchEditProfile(Profile profile, int index) {
    BlocProvider.of<UsersBloc>(context).dispatch(
      EditProfileEvent(profile: profile, index: index),
    );
  }

  void dispatchDeleteProfile(Profile profile, int index) {
    BlocProvider.of<UsersBloc>(context).dispatch(
      DeleteProfileSubUserEvent(profile: profile, index: index),
    );
  }

  void dispatchUploadFile(Profile profile, int index) {
    BlocProvider.of<UsersBloc>(context).dispatch(
      UploadFileEvent(profile: profile, index: index),
    );
  }

  void dispatchViewProfile(Profile profile, int index) {
    BlocProvider.of<UsersBloc>(context).dispatch(
      GoToViewProfileSubUserEvent(profile: profile, index: index),
    );
  }

  //
  bool _otherStatus(Profile profile, int index) {
    bool ok = false;

    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .otherMedicalRecordInfo.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord
                      .otherMedicalRecordInfo[i].label !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .otherMedicalRecordInfo[i].label !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord
                      .otherMedicalRecordInfo[i].description !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .otherMedicalRecordInfo[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord
            .otherMedicalRecordInfo.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _BoooldStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.bloodInfo
                .idBloodType !=
            null ||
        profile.userGeneralInfo.subUsers[index].medicalRecord.bloodInfo
                .bloodSystolic !=
            null ||
        profile.userGeneralInfo.subUsers[index].medicalRecord.bloodInfo
                .bloodDiastolic !=
            null) {
      return true;
    }
    return false;
  }

  bool _nameChild(Profile profile, int index) {
    if ((profile.userGeneralInfo.subUsers[index].userGeneralInfo.firstName !=
                null &&
            profile.userGeneralInfo.subUsers[index].userGeneralInfo.firstName !=
                '') ||
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.lastName !=
                null &&
            profile.userGeneralInfo.subUsers[index].userGeneralInfo.lastName !=
                '') {
      return true;
    }
    return false;
  }

  bool _CancerStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .medicalDiseaces.cancer.blocks.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .cancer.blocks[i].label !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.cancer.blocks[i].label !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .cancer.blocks[i].description !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.cancer.blocks[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
            .cancer.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _MedicationStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .medicalDiseaces.medication.blocks.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .medication.blocks[i].label !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.medication.blocks[i].label !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .medication.blocks[i].description !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.medication.blocks[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
            .medication.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _PulmonaryStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .medicalDiseaces.plumonary.blocks.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .plumonary.blocks[i].label !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.plumonary.blocks[i].label !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .plumonary.blocks[i].description !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.plumonary.blocks[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
            .plumonary.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _NeurologicStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .medicalDiseaces.neuroligic.blocks.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .neuroligic.blocks[i].label !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.neuroligic.blocks[i].label !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .neuroligic.blocks[i].description !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.neuroligic.blocks[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
            .neuroligic.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _PsychiatricStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .medicalDiseaces.psychiatric.blocks.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .psychiatric.blocks[i].label !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.psychiatric.blocks[i].label !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .psychiatric.blocks[i].description !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.psychiatric.blocks[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
            .psychiatric.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _CardiacStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .medicalDiseaces.cardiac.blocks.length;
        i++) {
      print(profile.userGeneralInfo.subUsers[index].medicalRecord
          .medicalDiseaces.cardiac.blocks[i].label);
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .cardiac.blocks[i].label !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.cardiac.blocks[i].label !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .cardiac.blocks[i].description !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.cardiac.blocks[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
            .cardiac.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _RenalkendyStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .medicalDiseaces.renalKenedy.blocks.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .renalKenedy.blocks[i].label !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.renalKenedy.blocks[i].label !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .renalKenedy.blocks[i].description !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.renalKenedy.blocks[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
            .renalKenedy.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _implantsStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .medicalDiseaces.implants.blocks.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .implants.blocks[i].label !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.implants.blocks[i].label !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .implants.blocks[i].description !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.implants.blocks[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
            .implants.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _allergiesStatus(Profile profile, int index) {
    bool ok = false;

    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .medicalDiseaces.allergies.blocks.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .allergies.blocks[i].label !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.allergies.blocks[i].label !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .allergies.blocks[i].description !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.allergies.blocks[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
            .allergies.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _infectionDisacesStatus(Profile profile, int index) {
    bool ok = false;

    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .medicalDiseaces.infectionDisaces.blocks.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .infectionDisaces.blocks[i].label !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.infectionDisaces.blocks[i].label !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
                      .infectionDisaces.blocks[i].description !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .medicalDiseaces.infectionDisaces.blocks[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.medicalDiseaces
            .infectionDisaces.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _DnrStatus(Profile profile, int index) {
    print(profile
        .userGeneralInfo.subUsers[index].medicalRecord.resuscitate.allow);
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.resuscitate
                .allow !=
            0 &&
        profile.userGeneralInfo.subUsers[index].medicalRecord.resuscitate
                .allow !=
            null) {
      return true;
    }
    return false;
  }

  bool _OrganDonarStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.organDonar
                .donar !=
            0 &&
        profile.userGeneralInfo.subUsers[index].medicalRecord.organDonar
                .donar !=
            null) {
      return true;
    }
    return false;
  }

  bool _MedicalInformationStatus(Profile profile, int index) {
    if (_otherStatus(profile, index) ||
        _DnrStatus(profile, index) ||
        _OrganDonarStatus(profile, index) ||
        _infectionDisacesStatus(profile, index) ||
        _allergiesStatus(profile, index) ||
        _implantsStatus(profile, index) ||
        _RenalkendyStatus(profile, index) ||
        _CardiacStatus(profile, index) ||
        _PsychiatricStatus(profile, index) ||
        _NeurologicStatus(profile, index) ||
        _PulmonaryStatus(profile, index) ||
        _MedicationStatus(profile, index) ||
        _CancerStatus(profile, index) ||
        _BoooldStatus(profile, index)) {
      return true;
    }
    return false;
  }

  bool _medicalTagStatus(Profile profile, int index) {
    if (userMedicalTags.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  bool _PhysicianContactsStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .physicianContact.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord
                      .physicianContact[i].lastName !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .physicianContact[i].lastName !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord
                      .physicianContact[i].mail !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .physicianContact[i].mail !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.physicianContact
                .length !=
            0 &&
        ok) {
      return true;
    }

    return false;
  }

  bool _EmergencyContactsStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord
                .userEmergencyContact.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord
                      .userEmergencyContact[i].firstName !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .userEmergencyContact[i].firstName !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord
                      .userEmergencyContact[i].mail !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .userEmergencyContact[i].mail !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord
                .userEmergencyContact.length !=
            0 &&
        ok) {
      return true;
    }

    return false;
  }

  bool _EmgInfoStatus(Profile profile, int index) {
    if (_PhysicianContactsStatus(profile, index) ||
        _EmergencyContactsStatus(profile, index)) {
      return true;
    }
    return false;
  }

  bool _MiscelaneousStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord.miscilanious
                .length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord.miscilanious[i]
                      .label !=
                  null &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .miscilanious[i].label !=
                  "") ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord.miscilanious[i]
                      .description !=
                  null &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .miscilanious[i].description !=
                  "")) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.miscilanious
                .length !=
            0 &&
        ok) {
      return true;
    }
    return false;
  }

  bool _PetStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.petAtHome !=
            null &&
        profile.userGeneralInfo.subUsers[index].medicalRecord.petAtHome != "") {
      return true;
    }
    return false;
  }

  bool _ReligionStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.religionLabel !=
            null &&
        profile.userGeneralInfo.subUsers[index].medicalRecord.religionLabel !=
            "") {
      return true;
    }
    return false;
  }

  bool _GenderStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.idGender !=
        null) {
      return true;
    }
    return false;
  }

  bool _MaritalStatusStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.idMaritalStatus !=
        null) {
      return true;
    }
    return false;
  }

  bool _EyeColorStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.idEyeColor !=
        null) {
      return true;
    }
    return false;
  }

  bool _DistinctiveSigneStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.distitnctSign !=
            null &&
        profile.userGeneralInfo.subUsers[index].medicalRecord.distitnctSign !=
            "") {
      return true;
    }
    return false;
  }

  bool _LanguageSpookenStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.spokenLanguages !=
            null &&
        profile.userGeneralInfo.subUsers[index].medicalRecord.spokenLanguages !=
            "") {
      return true;
    }
    return false;
  }

  bool _WeightHeightStatus(Profile profile, int index) {
    if ((profile.userGeneralInfo.subUsers[index].medicalRecord.heightweight.heightFt != 0 &&
            profile.userGeneralInfo.subUsers[index].medicalRecord.heightweight
                    .heightFt !=
                null) ||
        (profile.userGeneralInfo.subUsers[index].medicalRecord.heightweight
                    .heightInch !=
                0 &&
            profile.userGeneralInfo.subUsers[index].medicalRecord.heightweight
                    .heightInch !=
                null) ||
        (profile.userGeneralInfo.subUsers[index].medicalRecord.heightweight.heightCm != 0 &&
            profile.userGeneralInfo.subUsers[index].medicalRecord.heightweight
                    .heightCm !=
                null) ||
        (profile.userGeneralInfo.subUsers[index].medicalRecord.heightweight
                    .weightLbs !=
                0 &&
            profile.userGeneralInfo.subUsers[index].medicalRecord.heightweight
                    .weightLbs !=
                null) ||
        (profile.userGeneralInfo.subUsers[index].medicalRecord.heightweight
                    .weightKg !=
                0 &&
            profile.userGeneralInfo.subUsers[index].medicalRecord.heightweight
                    .weightKg !=
                null)) {
      return true;
    }
    return false;
  }

  bool _InsuranceInformationStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].medicalRecord.insuranceInfo
                .length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].medicalRecord
                      .insuranceInfo[i].insuranceCampanyName !=
                  null &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .insuranceInfo[i].insuranceCampanyName !=
                  "") ||
          (profile.userGeneralInfo.subUsers[index].medicalRecord
                      .insuranceInfo[i].additionalInformations !=
                  null &&
              profile.userGeneralInfo.subUsers[index].medicalRecord
                      .insuranceInfo[i].additionalInformations !=
                  "")) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].medicalRecord.insuranceInfo
                .length !=
            0 &&
        ok) {
      return true;
    }
    return false;
  }

  bool _birthdayStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.subUsers[index].userGeneralInfo.birthInfo
                .day !=
            null ||
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.birthInfo
                .year !=
            null ||
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.birthInfo
                .month !=
            null) {
      return true;
    }
    return false;
  }

  bool _PersonalInformationStatus(Profile profile, int index) {
    if (_MiscelaneousStatus(profile, index) ||
        _PetStatus(profile, index) ||
        _ReligionStatus(profile, index) ||
        _GenderStatus(profile, index) ||
        _MaritalStatusStatus(profile, index) ||
        _DistinctiveSigneStatus(profile, index) ||
        _EyeColorStatus(profile, index) ||
        _LanguageSpookenStatus(profile, index) ||
        _WeightHeightStatus(profile, index) ||
        _InsuranceInformationStatus(profile, index) ||
        _birthdayStatus(profile, index)) {
      return true;
    }
    return false;
  }

  bool _FamilyMmebreStatus(Profile profile, int index) {
    if (profile
        .userGeneralInfo.subUsers[index].userGeneralInfo.subUsers.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool _ThankYouStatus(Profile profile, int index) {
    if (profile.userGeneralInfo.subUsers[index].userGeneralInfo.custumMessage ==
            null ||
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.custumMessage ==
            "") {
      return false;
    }
    return true;
  }

  bool _alsoInfoStatus(Profile profile, int index) {
    bool ok = false;
    for (int i = 0;
        i <
            profile.userGeneralInfo.subUsers[index].userGeneralInfo
                .userEmergencyContact.length;
        i++) {
      if ((profile.userGeneralInfo.subUsers[index].userGeneralInfo
                      .userEmergencyContact[i].firstName !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].userGeneralInfo
                      .userEmergencyContact[i].firstName !=
                  null) ||
          (profile.userGeneralInfo.subUsers[index].userGeneralInfo
                      .userEmergencyContact[i].mail !=
                  "" &&
              profile.userGeneralInfo.subUsers[index].userGeneralInfo
                      .userEmergencyContact[i].mail !=
                  null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.subUsers[index].userGeneralInfo
                .userEmergencyContact.length !=
            0 &&
        ok) {
      return true;
    }

    return false;
  }

  bool _GenerlInfoStatus(Profile profile, int index) {
    if ((profile.userGeneralInfo.subUsers[index].userGeneralInfo.mail == null ||
            profile.userGeneralInfo.subUsers[index].userGeneralInfo.mail ==
                "") &&
        (profile.userGeneralInfo.subUsers[index].userGeneralInfo.mail2 == null ||
            profile.userGeneralInfo.subUsers[index].userGeneralInfo.mail2 ==
                "") &&
        (profile.userGeneralInfo.subUsers[index].userGeneralInfo.mobile == null ||
            profile.userGeneralInfo.subUsers[index].userGeneralInfo.mobile ==
                "") &&
        (profile.userGeneralInfo.subUsers[index].userGeneralInfo.codePhone == null ||
            profile.userGeneralInfo.subUsers[index].userGeneralInfo.codePhone ==
                "") &&
        (profile.userGeneralInfo.subUsers[index].userGeneralInfo.preferenceUser
                .allowShareEmails.value ==
            "0") &&
        (profile.userGeneralInfo.subUsers[index].userGeneralInfo.preferenceUser
                .includeMobile.value ==
            "0") &&
        (profile.userGeneralInfo.subUsers[index].userGeneralInfo.preferenceUser
                .allowSharePicture.value ==
            "0") &&
        (profile.userGeneralInfo.subUsers[index].userGeneralInfo.preferenceUser
                .allowShareName.value ==
            "0")) {
      return false;
    }
    return true;
  }
}
