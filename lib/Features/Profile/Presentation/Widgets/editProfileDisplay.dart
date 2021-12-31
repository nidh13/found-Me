import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Core/Utils/toolTipExample.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/Sean4Dialog.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/expandable_Alsocontact_list.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/expandable_EmergencyContact.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/expandable_insurance.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/expandable_list.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/expandable_Donor.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/expandable_Dnr.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/expandable_misclaneous_list.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/expandable_other_list.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/expandable_physician_list.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Profile/Presentation/bloc/profile_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
//import 'package:super_tooltip/super_tooltip.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popUpImage.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/customSwitchDiseable.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/AlertDialogUpdate.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/printPopup.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/sendPopup.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/date_picker.dart';
import 'package:neopolis/Core/Utils/date_hint.dart';
import 'package:neopolis/Core/Utils/nullable_valid_date.dart';
import 'package:neopolis/Core/Utils/validDate.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/animationEditProfile.dart';
import 'package:neopolis/Core/Utils/text.dart';

import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/blackpopup.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/publicPopup.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custonSwitcgAble.dart';
import 'package:easy_localization/easy_localization.dart';
class EditProfileDisplay extends StatefulWidget {
  final Profile profile;
  final String loading;
  EditProfileDisplay({Key key, @required this.profile, this.loading})
      : super(key: key);

  @override
  EditProfileDisplayState createState() => EditProfileDisplayState();
}

class EditProfileDisplayState extends State<EditProfileDisplay> {
  var screenWidth, screenHeight;
  bool petOwner = false;
  bool contact = false;
  bool _visiInsurance = true;
  bool _visiMedicalTag = true;

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
  TextEditingController phone1controller = new TextEditingController();
  bool persInfo = false;
  bool emegInfo = false;
  bool alsoInfo = false;
  bool userRights = false;
  bool memebrs = false;
  bool advancedSettings = false;
  bool medicInfo = false;
  bool viewExport = false;

  ScrollController _userScrollController = new ScrollController();
  FocusNode _thankYouFocus = FocusNode();
  bool _validate = false;
  bool _validateEmail = false;
  //General & Medical Records
  bool isMember;
  int nbblock = 5;
  List<bool> addBlock = [];
  bool _viewRecord = false;
  bool _emailRecord = false;
  bool _printRecord = false;

  //Medical information
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
  FocusNode codePhoneFocus = FocusNode();

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
  bool userRight = false;
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

  bool maritalStatus = false;
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
  bool expandFlag = false;
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
  List<Profile> subUsersList = [];
  List<Tags> userMedicalTags = [];
  List<InsuranceInfo> userInsuranceInfo = [];
  List<Miscilanious> userMiscelaneous = [];
  List<PhysicianContact> userMedicalPhysicianEmergencyContacts = [];
  List<Blocks> userMedicalDiseacesCancer = [];
  List<Blocks> userMedicalDiseacesAllergies = [];
  List<Resuscitate> userMedicalDiseacesDnr = [];
  List<Blocks> userMedicalDiseacesCardiac = [];

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

  preferenceUser() {
    widget.profile.userGeneralInfo.preferenceUser.allowLiveChat == null
        ? _switchAllowLiveChat = false
        : widget.profile.userGeneralInfo.preferenceUser.allowLiveChat.value ==
                '1'
            ? _switchAllowLiveChat = true
            : _switchAllowLiveChat = false;

    widget.profile.userGeneralInfo.preferenceUser.allowShareEmails == null
        ? _switchAllowShareEmails = false
        : widget.profile.userGeneralInfo.preferenceUser.allowShareEmails
                    .value ==
                '1'
            ? _switchAllowShareEmails = true
            : _switchAllowShareEmails = false;

    widget.profile.userGeneralInfo.preferenceUser.allowSharePhone == null
        ? _switchAllowMobile = false
        : widget.profile.userGeneralInfo.preferenceUser.allowSharePhone.value ==
                '1'
            ? _switchAllowMobile = true
            : _switchAllowMobile = false;

    widget.profile.userGeneralInfo.preferenceUser.includeMail1 == null
        ? _switchIncludeMail = false
        : widget.profile.userGeneralInfo.preferenceUser.includeMail1.value ==
                '1'
            ? _switchIncludeMail = true
            : _switchIncludeMail = false;

    widget.profile.userGeneralInfo.preferenceUser.includeMobile == null
        ? _switchIncludePhone = false
        : widget.profile.userGeneralInfo.preferenceUser.includeMobile.value ==
                '1'
            ? _switchIncludePhone = true
            : _switchIncludePhone = false;

    widget.profile.userGeneralInfo.preferenceUser.allowShareName == null
        ? _switchIncludeName = false
        : widget.profile.userGeneralInfo.preferenceUser.allowShareName.value ==
                '1'
            ? _switchIncludeName = true
            : _switchIncludeName = false;

    widget.profile.userGeneralInfo.preferenceUser.allowSharePicture == null
        ? _switchAllowPicture = false
        : widget.profile.userGeneralInfo.preferenceUser.allowSharePicture
                    .value ==
                '1'
            ? _switchAllowPicture = true
            : _switchAllowPicture = false;

    _switchOrganDonor = widget.profile.medicalRecord.organDonar != null
        ? widget.profile.medicalRecord.organDonar.donar == 1
            ? true
            : false
        : false;
  }

  userEmergencyContacts() {
    nombrebolckAlsoContact =
        widget.profile.userGeneralInfo.userEmergencyContact.length;
  }

  subUsers() {
    widget.profile.userGeneralInfo.subUsers.forEach((element) {
      subUsersList.add(element);
    });
  }

  myMedicalTags() {
    widget.profile.userGeneralInfo.tagsList.medicalTag.forEach((element) {
      if (widget.profile.userGeneralInfo.idMember == element.idMember) {
        userMedicalTags = element.tags;
      }
    });
  }

  myInsuranceInfo() {
    widget.profile.medicalRecord.insuranceInfo.forEach((element) {
      userInsuranceInfo.add(element);
      addBlockInsurance.add(false);
    });
    nombrebolckInsurance = userInsuranceInfo.length;
  }

  myMiscelaneous() {
    widget.profile.medicalRecord.miscilanious.forEach((element) {
      userMiscelaneous.add(element);
      addBlockMisc.add(false);
    });
    nombrebolckMiscelaneous = userMiscelaneous.length;
  }

  myMedicalEmergencyContacts() {
    nombrebolckEmergencyContact =
        widget.profile.medicalRecord.userEmergencyContact.length;
    widget.profile.medicalRecord.userEmergencyContact.forEach((element) {
      addBlockEmergency.add(false);
    });
  }

  myMedicalPhysicianEmergencyContacts() {
    widget.profile.medicalRecord.physicianContact.forEach((element) {
      userMedicalPhysicianEmergencyContacts.add(element);
      addBlockPhysician.add(false);
    });
    nombrebolckPhysicianContact = userMedicalPhysicianEmergencyContacts.length;
  }

  myMedicalDiseaces() {
    widget.profile.userGeneralInfo.userEmergencyContact.forEach((element) {
      addBlock.add(false);
    });
    widget.profile.medicalRecord.medicalDiseaces.cancer != null
        ? widget.profile.medicalRecord.medicalDiseaces.cancer.blocks
            .forEach((element) {
            addBlockCancer.add(false);
            userMedicalDiseacesCancer.add(element);
          })
        : Container();
    nombrebolckCancer = userMedicalDiseacesCancer.length;

    widget.profile.medicalRecord.medicalDiseaces.allergies != null
        ? widget.profile.medicalRecord.medicalDiseaces.allergies.blocks
            .forEach((element) {
            addBlockAllerg.add(false);
            userMedicalDiseacesAllergies.add(element);
          })
        : Container();
    nombrebolckAllergies = userMedicalDiseacesAllergies.length;

    nombrebolckDnr = userMedicalDiseacesDnr.length;

    widget.profile.medicalRecord.medicalDiseaces.cardiac != null
        ? widget.profile.medicalRecord.medicalDiseaces.cardiac.blocks
            .forEach((element) {
            addBlockCardiac.add(false);

            userMedicalDiseacesCardiac.add(element);
          })
        : Container();
    nombrebolckCardiac = userMedicalDiseacesCardiac.length;
    widget.profile.medicalRecord.medicalDiseaces.implants != null
        ? widget.profile.medicalRecord.medicalDiseaces.implants.blocks
            .forEach((element) {
            addBlockImpl.add(false);

            userMedicalDiseacesImplants.add(element);
          })
        : Container();
    widget.profile.medicalRecord.medicalDiseaces.medication != null
        ? widget.profile.medicalRecord.medicalDiseaces.medication.blocks
            .forEach((element) {
            addBlockMedica.add(false);

            userMedicalDiseacesMedication.add(element);
          })
        : Container();
    nombrebolckMedication = userMedicalDiseacesMedication.length;
    widget.profile.medicalRecord.medicalDiseaces.neuroligic != null
        ? widget.profile.medicalRecord.medicalDiseaces.neuroligic.blocks
            .forEach((element) {
            addBlockNeuro.add(false);

            userMedicalDiseacesNeurologic.add(element);
          })
        : Container();
    nombrebolckNeurologic = userMedicalDiseacesNeurologic.length;
    widget.profile.medicalRecord.medicalDiseaces.plumonary != null
        ? widget.profile.medicalRecord.medicalDiseaces.plumonary.blocks
            .forEach((element) {
            addBlockPulmo.add(false);

            userMedicalDiseacesPlumonary.add(element);
          })
        : Container();
    nombrebolckPulmonary = userMedicalDiseacesPlumonary.length;
    widget.profile.medicalRecord.medicalDiseaces.psychiatric != null
        ? widget.profile.medicalRecord.medicalDiseaces.psychiatric.blocks
            .forEach((element) {
            addBlockPsy.add(false);

            userMedicalDiseacesPsychiatric.add(element);
          })
        : Container();
    nombrebolckPsychiatric = userMedicalDiseacesPsychiatric.length;
    widget.profile.medicalRecord.medicalDiseaces.renalKenedy != null
        ? widget.profile.medicalRecord.medicalDiseaces.renalKenedy.blocks
            .forEach((element) {
            addBlockRenal.add(false);

            userMedicalDiseacesRenal.add(element);
          })
        : Container();
    nombrebolckRenal = userMedicalDiseacesRenal.length;
    widget.profile.medicalRecord.medicalDiseaces.infectionDisaces != null
        ? widget.profile.medicalRecord.medicalDiseaces.infectionDisaces.blocks
            .forEach((element) {
            addBlockInfec.add(false);

            userMedicalDiseacesInfectionDisaces.add(element);
          })
        : Container();
    nombrebolckInfectiousDesease = userMedicalDiseacesInfectionDisaces.length;
    widget.profile.medicalRecord.otherMedicalRecordInfo.forEach((element) {
      addBlockOther.add(false);
    });
  }

  myMedicalBloodDiabates() {
    widget.profile.medicalRecord.bloodInfo.diabates.forEach((element) {
      userMedicalBloodDiabates.add(element);
      addBlockBlood.add(false);
    });
    nombrebolckBlood = userMedicalBloodDiabates.length;
    nombrebolckOther =
        widget.profile.medicalRecord.otherMedicalRecordInfo.length;
  }

  bool iconAttachmentMedicalTag() {
    userMedicalTags.forEach((element) {
      element.otherInfo != null
          ? element.otherInfo.forEach((element) {
              if (element.documents.length != null) {
                attachmentMedical = true;
              }
            })
          : Container();
    });
    return attachmentMedical;
  }

  bool iconReminderMedicalTag() {
    userMedicalTags.forEach((element) {
      element.otherInfo != null
          ? element.otherInfo.forEach((element) {
              if (element.reminders.length != null) {
                reminderMedical = true;
              }
            })
          : Container();
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
    profile.medicalRecord.otherMedicalRecordInfo.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalOther = true;
      }
    });
    return attachmentMedicalOther;
  }

  bool iconReminderOther(Profile profile) {
    profile.medicalRecord.otherMedicalRecordInfo.forEach((element) {
      if (element.reminder != null) {
        if (element.reminder.length != 0) {
          reminderMedicalOther = true;
        }
      }
    });
    return reminderMedicalOther;
  }

  void maxColumnProfileUser(String title, String content) {
    PopupMenuP menuTags = PopupMenuP(
        backgroundColor: Colors.white,
        lineColor: ColorConstant.darkGray,
        maxColumn: 3,
        titre: title,
        content: content,
        onClickMenu: onClickMenuP,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menuTags.showP(widgetKey: btnKey2);
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  GlobalKey btnKey2 = GlobalKey();
  void onClickMenuP(MenuItemProviderP item) {
    if (item.type == "camera") {
      print("camera");
    } else if (item.type == "gallery") {
      print("gallary");
    } else
      print("file");
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
  FocusNode nbreFocus = FocusNode();

  FocusNode thankFocus = FocusNode();

  double _petItemWidth = 0.0;
  //height and weight
  bool height = false;
  Map<dynamic, dynamic> some = {};
  Map<dynamic, dynamic> someInsur = {};
  int _petIndicatorIndex = 0;

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

  bool maxNombreAdmin = false;
  nombreUserAdmin() {
    widget.profile.userGeneralInfo.subUsers.forEach((element) {
      if (element.userGeneralInfo.role == 2) {
        maxNombreAdmin = true;
      }
    });
  }

  @override
  void initState() {
    widget.profile.userGeneralInfo.role == 3
        ? isMember = true
        : isMember = false;
    nombreUserAdmin();
    preferenceUser();
    userEmergencyContacts();
    subUsers();
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
    if (widget.profile.userGeneralInfo.update == null) {
      widget.profile.userGeneralInfo.update = false;
    }
    checkerEmail1ContactInfo = widget.profile.userGeneralInfo.mail == ''
        ? true
        : regExpEmail.hasMatch(widget.profile.userGeneralInfo.mail ?? '');
    checkerEmail2ContactInfo = widget.profile.userGeneralInfo.mail2 == "" ||
            widget.profile.userGeneralInfo.mail2 == null
        ? true
        : regExpEmail.hasMatch(widget.profile.userGeneralInfo.mail2 ?? '');
    _petScrollController.addListener(scrollListenerWithItemHeight);

    super.initState();
  }

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
          //  fontFamily: "SFProText",
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

  GlobalKey btnKeyp1 = GlobalKey();
  PopupMenuP menup;
  PopupMenuP menuTags;
  void maxColumnP() {
    PopupMenuP menup = PopupMenuP(
        backgroundColor: Colors.white,
        lineColor: ColorConstant.darkGray,
        maxColumn: 3,
        titre: 'title',
        content: 'content  este ets     eeeeeeeeeeeee eeeee ',
        onClickMenu: onClickMenuP,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menup.showP(widgetKey: btnKeyp1);
  }

  bool roleAdmin;
  bool roleMember;
  bool roleChild;
  static final now = DateTime.now();
  ScrollController _scrollController = ScrollController();
  DropdownDatePicker dropdownDatePicker;
  Widget questionMarks(String title,String content){
    return Stack(
      children: [
     
        SimpleTooltip(
          ballonPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        backgroundColor: ColorConstant.textColor,
        borderColor:ColorConstant.textColor,
        //key:_toolTipKey ,
            tooltipTap: () {
            print("Tooltip tap");
            setState(() {
             taped=false;
            });
           

            },
          //  animationDuration: Duration(seconds: 3),
            show:taped,
            tooltipDirection: TooltipDirection.up,
         
            content:
                    Stack(
                      children: [
                   Positioned(right: 0,child:   Image.asset(
                                            "Assets/Images/close-white.png",
                                            color: Colors.white,
                                            height: 9,
                                            width: 9,
                                          
  ),),
  //  Positioned(bottom: 10,child:   Text(
                          
  //                                             'Email Me',
  //                                          style: TextStyle(     decoration:TextDecoration.none ,
  //                                                   fontWeight: FontWeight.w400,
  //                                                   fontSize: 14,
  //                                                   color: ColorConstant.whiteTextColor,
  //                                                   ),
  //                                                       softWrap: true,

                                          
  // ),),
                     Text.rich(TextSpan(
                                        text:title +' '+ '\n' ,
                                        style: TextStyle(
                                            fontFamily: 'SFProText',
                                            fontWeight: FontWeight.w500,
                                            decoration:TextDecoration.none ,
                                            fontSize: 14,
                                            color: ColorConstant.colorBlockVide),
                                        children: <InlineSpan>[
                                          
                                         WidgetSpan(
                                           child: Container(height: 8,),
                                     ),
                                         TextSpan(
                                        text:content,
                                        style: TextStyle(
                                            fontFamily: 'SFProText',
                                            fontWeight: FontWeight.w400,
                                            decoration:TextDecoration.none ,
                                            fontSize: 12,
                                            color: ColorConstant.colorBlockVide),)
                                        ])),],
                    ),
        
                   
                                       
             
          //    MyText(
          // value:title,
            
          //       color: Colors.white,
          //       fontSize: 14,
          //       fontWeight: FontWeight.w400,
          //       decoration: TextDecoration.none,
           
          //   ),
        
                                  //          },
                                             
                                              child: 
                                              // SimpleTooltip(
                                              //     key: GlobalKey(),
                                              //     tooltipTap: () {
                                              //       print("Tooltip tap");
                                              //     },
                                              //     // animationDuration: Duration(seconds: 3),
                                              //     show:taped,
                                              //     backgroundColor: Colors.black,
                                              //     tooltipDirection: TooltipDirection.up,
                                              //     child: 
                                                  CircleAvatar(
                                                                                                      child: Image.asset(
                                                      "Assets/Images/info.png",
                                                      height: 14,
                                                      width: 14,
                                                    ),
                                                  ),
                                                  // content: Text(
                                                  //   "Some",
                                                  //   style: TextStyle(
                                                  //     color: Colors.white,
                                                  //     fontSize: 18,
                                                  //     decoration: TextDecoration.none,
                                                  //   ),
                                                  // )),
                                        
  ),
    
  
                                    
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    PopupMenuP.context = context;

    final Profile oldProfile = widget.profile;
    Profile profile = widget.profile;
    final Map<dynamic, dynamic> someMap = {
      "visibility": _visi,
      "listofwidget": listALsoContact,
    };
    final Map<dynamic, dynamic> someinsurance = {
      "visibility": _visiInsurance,
      "listofwidget": listInsurance,
    };

    roleAdmin = profile.userGeneralInfo.role == 2 ? true : false;
    roleMember = profile.userGeneralInfo.role == 3 ? true : false;
    roleChild = profile.userGeneralInfo.role == 4 ? true : false;
    some = someMap;
    someInsur = someinsurance;
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
      initialDate: NullableValidDate(
        year: widget.profile.userGeneralInfo.birthInfo.year,
        month: convertMonth(widget.profile.userGeneralInfo.birthInfo.month),
        day: convertDay(widget.profile.userGeneralInfo.birthInfo.day),
      ), //widget.profile.userGeneralInfo.birthInfo['day']),
      firstDate: ValidDate(year: now.year - 100, month: 1, day: 1),
      lastDate: ValidDate(year: now.year, month: now.month, day: now.day),
      dateHint: DateHint(
        year: 'editprofil_medical_label_year'.tr(),
        month: 'editprofil_medical_label_month'.tr(),
        day: 'editprofil_medical_label_day'.tr(),
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
      // PopupMenuP.context = context;
      return NestedScrollView(
        floatHeaderSlivers: true,
        controller: _scrollController,
        //  physics: NeverScrollableScrollPhysics(),

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
                firstName: profile.userGeneralInfo.firstName,
                lastName: profile.userGeneralInfo.lastName,
                role: profile.userGeneralInfo.roleLabel,
                loading: widget.loading,
              ),
            ),
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
                          fontSize: 18,
                          color: ColorConstant.textColor),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _Contact(profile),
                    SizedBox(
                      height: 16,
                    ),
                    alsoInfos(
                      profile,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _AdvancedSettings(profile),
                    SizedBox(
                      height: 16,
                    ),
                    _Memebrs(profile),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: MyText(
                          value: "editprofil_general_label_medical".tr(),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: ColorConstant.textColor),
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
                    _ViewExport(profile, oldProfile),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(height: 40),
                    _editButton(
                      profile,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // _deleteButton(profile),
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
              border: contact || _GenerlInfoStatus(profile)
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
              color: contact || _GenerlInfoStatus(profile)
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
                  contact = !contact;
                  alsoInfo = false;
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
                      child: SvgPicture.asset('Assets/Images/MyContact.svg',
                          color: contact || _GenerlInfoStatus(profile)
                              ? ColorConstant.whiteTextColor
                              : ColorConstant.textBlockVide),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                                value: 'pets_label_contactinfo'.tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: contact || _GenerlInfoStatus(profile)
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
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
// SuperTooltip tooltip;

 GlobalKey _toolTipKey = GlobalKey();

   GlobalKey _toolTipK = GlobalKey();

  bool taped = false;
  _info(
    Profile profile,
  ) {
      

    
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
                  bottomLeft: Radius.circular(info ? 0 : 8.0),
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
                      bottomRight: Radius.circular(info ? 0 : 8.0))),
            ),
          ),
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
                            SizedBox(
                              height: 14.5,
                            ),
                            Center(
                              child: Row(children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        textScaleFactor: MediaQuery.of(context)
                                            .textScaleFactor
                                            .clamp(1.0, 1.0),
                                      ),
                                      child: MyTextField(
                                        maxline: 1,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        title:
                                            "editprofil_general_label_firstname"
                                                .tr(),
                                        initialValue:
                                            profile.userGeneralInfo.firstName,
                                        onChanged: (value) {
                                          setState(() {
                                            profile.userGeneralInfo.update =
                                                true;

                                            profile.userGeneralInfo.firstName =
                                                value;
                                          });
                                        },
                                      ),
                                    )),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        textScaleFactor: MediaQuery.of(context)
                                            .textScaleFactor
                                            .clamp(1.0, 1.0),
                                      ),
                                      child: MyTextField(
                                          initialValue: widget
                                              .profile.userGeneralInfo.lastName,
                                          inputType: TextInputType.number,
                                          maxline: 1,
                                          editTextBgColor:
                                              ColorConstant.textfieldColor,
                                          title:
                                              "editprofil_general_label_lastname"
                                                  .tr(),
                                          hintTextColor: Colors.white54,
                                          onChanged: (value) {
                                            setState(() {
                                              profile.userGeneralInfo.update =
                                                  true;

                                              profile.userGeneralInfo.lastName =
                                                  value;
                                            });
                                          }),
                                    ))
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
                            Text.rich(TextSpan(
                                text: "pets_label_emailme".tr(),
                                style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: ColorConstant.textColor),
                                children: <InlineSpan>[
                                  WidgetSpan(
                                      child: Container(
                                    width: 12,
                                  )),
                                  WidgetSpan(
                                    child :GestureDetector(
                                      key:_toolTipKey ,

  onTap: () {
    //_toolTipKey.currentState;
    // _toolTip.ensureTooltipVisible();
  
      
    setState(() {
       taped=true;
    });
   
  },
  child:AnimatedExamplePage(GlobalKey(),'Email me','Receive emails informing you of an emergency or loss',taped)
  ),
                                  ),
                                ])),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8.0 ?? 12.5,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 11,
                                      child: MyTextField(
                                        initialValue:
                                            profile.userGeneralInfo.mail,
                                        maxline: 1,
                                        inputType: TextInputType.multiline,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        title: "pets_label_primarymail".tr(),
                                        onChanged: (value) {
                                          profile.userGeneralInfo.update = true;

                                          setState(() {
                                            profile.userGeneralInfo.mail =
                                                value;

                                            value == ""
                                                ? checkerEmail1ContactInfo =
                                                    true
                                                : checkerEmail1ContactInfo =
                                                    regExpEmail.hasMatch(value);
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: profile.userGeneralInfo.mail ==
                                                      null ||
                                                  profile.userGeneralInfo
                                                          .mail ==
                                                      ''
                                              ? DiseableCustomSwitch(
                                                  activeColor:
                                                      Color(0xff34C759),
                                                  value: false)
                                              : CustomSwitch(
                                                  activeColor:
                                                      Color(0xff34C759),
                                                  value: profile
                                                              .userGeneralInfo
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
                                                      profile
                                                              .userGeneralInfo
                                                              .preferenceUser
                                                              .includeMail1
                                                              .value =
                                                          value == true
                                                              ? '1'
                                                              : '0';
                                                    });
                                                    _switchAllowShareEmails =
                                                        value;
                                                  },
                                                ),
                                        )),
                                  ],
                                ),
                                checkerEmail1ContactInfo
                                    ? Container()
                                    : Padding(
                                        padding:
                                            EdgeInsets.only(left: 2, top: 8.0),
                                        child: MyText(
                                          value: "registration_info_email".tr(),
                                          fontSize: 12,
                                          color: ColorConstant.redColor,
                                        ),
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
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 11,
                                      child: MyTextField(
                                        initialValue:
                                            profile.userGeneralInfo.mail2,
                                        maxline: 1,
                                        inputType: TextInputType.multiline,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        title:
                                            'editprofil_general_subtitle_secondaryemail'
                                                .tr(),
                                        onChanged: (value) {
                                          setState(() {
                                            profile.userGeneralInfo.update =
                                                true;

                                            profile.userGeneralInfo.mail2 =
                                                value;

                                            value == ""
                                                ? checkerEmail2ContactInfo =
                                                    true
                                                : checkerEmail2ContactInfo =
                                                    regExpEmail.hasMatch(value);
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: profile.userGeneralInfo
                                                          .mail2 ==
                                                      null ||
                                                  profile.userGeneralInfo
                                                          .mail2 ==
                                                      ''
                                              ? DiseableCustomSwitch(
                                                  activeColor:
                                                      Color(0xff34C759),
                                                  value: false)
                                              : CustomSwitch(
                                                  activeColor:
                                                      Color(0xff34C759),
                                                  value: widget
                                                              .profile
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
                                                      widget
                                                              .profile
                                                              .userGeneralInfo
                                                              .preferenceUser
                                                              .includeMail2
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
                                checkerEmail2ContactInfo
                                    ? Container()
                                    : Padding(
                                        padding:
                                            EdgeInsets.only(left: 2, top: 8.0),
                                        child: MyText(
                                          value: "registration_info_email".tr(),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: ColorConstant.redColor,
                                        ),
                                      ),
                                SizedBox(
                                  height: 13,
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
                                SizedBox(
                                  height: 0.0 ?? 12.5,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 11,
                                    child:
                                      Text.rich(TextSpan(
                                text: "pets_label_livechatme".tr(),
                                style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: ColorConstant.textColor),
                                children: <InlineSpan>[
                                  WidgetSpan(
                                      child: Container(
                                    width: 12,
                                  )),
                                  WidgetSpan(
                                    child :GestureDetector(
                                      key: GlobalKey(),

  onTap: () {
    //_toolTipKey.currentState;
    // _toolTip.ensureTooltipVisible();
    setState(() {
       taped=true;

    });
   taped=false;
  },
  child:AnimatedExamplePage(GlobalKey(),"pets_label_livechatme".tr(),'Receive emails informing you of an emergency or loss',taped)
  ),
                                  ),
                                ]))),
                                Expanded(
                                  flex: 4,
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: CustomSwitchAble(
                                          activeColor: Color(0xff34C759),
                                          value: true)),

                                  // Align(
                                  //     alignment: Alignment.bottomRight,
                                  //     child: (profile.userGeneralInfo.mail ==
                                  //                     null ||
                                  //                 profile.userGeneralInfo
                                  //                         .mail ==
                                  //                     '') &&
                                  //             (profile.userGeneralInfo.mail2 ==
                                  //                     '' ||
                                  //                 profile.userGeneralInfo
                                  //                         .mail2 ==
                                  //                     null)
                                  //         ? DiseableCustomSwitch(
                                  //             activeColor: Color(0xff34C759),
                                  //             value: false)
                                  //         : CustomSwitch(
                                  //             activeColor: Color(0xff34C759),
                                  //             value: profile
                                  //                         .userGeneralInfo
                                  //                         .preferenceUser
                                  //                         .allowLiveChat
                                  //                         .value ==
                                  //                     "1"
                                  //                 ? true
                                  //                 : false,
                                  //             onChanged: (value) {
                                  //               profile.userGeneralInfo.update =
                                  //                   true;

                                  //               setState(() {
                                  //                 profile
                                  //                         .userGeneralInfo
                                  //                         .preferenceUser
                                  //                         .allowLiveChat
                                  //                         .value =
                                  //                     value == true ? '1' : '0';
                                  //               });
                                  //             },
                                  //           )),
                                )
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
                              children: <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: MyText(
                                      value: "pets_label_mobilecellnumber".tr(),
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
                            SizedBox(height: 8.0),
                            Container(
                              child: KeyboardActions(
                                autoScroll: false,
                                disableScroll: true,
                                config: KeyboardActionsConfig(
                                    keyboardActionsPlatform:
                                        KeyboardActionsPlatform.ALL,
                                    actions: [
                                      KeyboardActionsItem(
                                          focusNode: codePhoneFocus),
                                      KeyboardActionsItem(focusNode: nbreFocus),
                                    ]),
                                child: Row(children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: MyTextField(
                                      maxline: 1,
                                      initialValue:
                                          profile.userGeneralInfo.codePhone,
                                      keyboardType: TextInputType.number,
                                      title: "pets_label_mobile".tr(),
                                      focusNode: codePhoneFocus,
                                      editTextBgColor:
                                          ColorConstant.textfieldColor,
                                      hintTextColor: Colors.white54,
                                      onChanged: (value) {
                                        profile.userGeneralInfo.update = true;

                                        setState(() {
                                          profile.userGeneralInfo.codePhone =
                                              value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: MyTextField(
                                        initialValue:
                                            profile.userGeneralInfo.mobile,
                                        keyboardType: TextInputType.number,
                                        focusNode: nbreFocus,
                                        title: "pets_label_cellnumber".tr(),
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {
                                          profile.userGeneralInfo.update = true;

                                          setState(() {
                                            profile.userGeneralInfo.mobile =
                                                value;
                                            profile.userGeneralInfo.tel = value;
                                          });
                                        }),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  profile.userGeneralInfo.mobile == null ||
                                          profile.userGeneralInfo.mobile == ''
                                      ? DiseableCustomSwitch(
                                          activeColor: Color(0xff34C759),
                                          value: false)
                                      : CustomSwitch(
                                          activeColor: Color(0xff34C759),
                                          value: _switchAllowMobile,
                                          onChanged: (value) {
                                            profile.userGeneralInfo.update =
                                                true;

                                            setState(() {
                                              widget
                                                      .profile
                                                      .userGeneralInfo
                                                      .preferenceUser
                                                      .allowSharePhone
                                                      .value =
                                                  value == true ? '1' : '0';
                                              _switchAllowMobile = value;
                                            });
                                          },
                                        ),
                                ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  profile.userGeneralInfo.role == 2
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
                                      fontSize: 14,
                                      color: ColorConstant.textColor),
                                  SizedBox(
                                    height: 14.5,
                                  ),
                                  Container(
                                    height: 0.40,
                                    color: ColorConstant.dividerColor,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  _includeEmail(profile),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 0.40,
                                    color: ColorConstant.dividerColor,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  _includePhone(profile),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 0.40,
                                    color: ColorConstant.dividerColor,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  _includeName(profile),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 0.40,
                                    color: ColorConstant.dividerColor,
                                  ),
                                  SizedBox(
                                    height: 8,
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
                CustomSwitch(
                  activeColor: Color(0xff34C759),
                  value: _switchAllowPicture,
                  onChanged: (value) {
                    profile.userGeneralInfo.update = true;

                    setState(() {
                      profile.userGeneralInfo.preferenceUser.allowSharePicture
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
          height: 45,
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
                CustomSwitch(
                  activeColor: Color(0xff34C759),
                  value: _switchIncludeName,
                  onChanged: (value) {
                    profile.userGeneralInfo.update = true;

                    setState(() {
                      profile.userGeneralInfo.preferenceUser.allowShareName
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
          height: 45,
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
                CustomSwitch(
                  activeColor: Color(0xff34C759),
                  value: profile.userGeneralInfo.preferenceUser.allowShareEmails
                              .value ==
                          '1'
                      ? true
                      : false,
                  onChanged: (value) {
                    profile.userGeneralInfo.update = true;

                    setState(() {
                      profile.userGeneralInfo.preferenceUser.allowShareEmails
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
          height: 45,
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
                          padding: EdgeInsets.only(left: 11, right: 21),
                          child: MyText(
                              value: "pets_label_sharephone".tr(),
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
                  value: _switchIncludePhone,
                  onChanged: (value) {
                    profile.userGeneralInfo.update = true;

                    setState(() {
                      profile.userGeneralInfo.preferenceUser.includeMobile
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

  static showOverlay(
      BuildContext context, String headerMessage, String message) {
    Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  bool checkerEmail1ContactInfo;
  bool checkerEmail2ContactInfo;

  String message;
  bool checkerFirstName = true;
  bool checkerEmail1 = true;
  bool checkerEmail2 = true;
  bool checkerTel = true;
  int i;

  _editButton(
    Profile profile,
  ) {
    return MyButton(
      title: "pets_label_save".tr(),
      height: 46.0,
      titleSize: 14,
      cornerRadius: 8,
      fontWeight: FontWeight.w600,
      titleColor: ColorConstant.primaryColor,
      btnBgColor: ColorConstant.boxColor,
      onPressed: () {
        message = '';
        checkerFirstName = true;
        checkerEmail1 = true;
        checkerEmail2 = true;
        checkerTel = true;
        i = 0;

        for (int p = 0; p < 5; p++) {
          if (profile.userGeneralInfo.firstName != null &&
              profile.userGeneralInfo.firstName != '') {
            if (regExpName.hasMatch(profile.userGeneralInfo.firstName) !=
                true) {
              checkerFirstName = false;
              message = "pets_label_verifyname".tr();
            }
          } else {
            checkerFirstName = false;
            message = "pets_label_verifyname".tr();
          }

          // MAIL
          if (profile.userGeneralInfo.mail != null &&
              profile.userGeneralInfo.mail != '') {
            if (regExpEmail.hasMatch(profile.userGeneralInfo.mail) != true) {
              checkerEmail1 = false;
              message = "pets_label_verifyprimarymail".tr();
            }
          } else {
            checkerEmail1 = false;
            message = "pets_label_verifyprimarymail".tr();
          }

          if (profile.userGeneralInfo.mail2 != null &&
              profile.userGeneralInfo.mail2 != '') {
            if (regExpEmail.hasMatch(profile.userGeneralInfo.mail2) != true) {
              checkerEmail2 = false;
              message = "pets_label_verifysecondarymail".tr();
            }
          }

          if (profile.userGeneralInfo.mobile != null &&
              profile.userGeneralInfo.mobile != '') {
            if (regExpNumber.hasMatch(profile.userGeneralInfo.mobile) != true) {
              checkerTel = false;
              message = "pets_label_verifyphone".tr();
            }
          }

          if (profile.userGeneralInfo.userEmergencyContact.isNotEmpty) {
            i = 0;
            while (i < profile.userGeneralInfo.userEmergencyContact.length) {
              if (profile.userGeneralInfo.userEmergencyContact[i].firstName ==
                      '' &&
                  profile.userGeneralInfo.userEmergencyContact[i].lastName ==
                      '' &&
                  profile.userGeneralInfo.userEmergencyContact[i].mail == '' &&
                  profile.userGeneralInfo.userEmergencyContact[i].mail2 == '' &&
                  profile.userGeneralInfo.userEmergencyContact[i].mobile ==
                      '') {
                nombrebolckAlsoContact--;
                profile.userGeneralInfo.userEmergencyContact.removeAt(i);
              } else {
                i++;
              }
            }
            i = 0;
            while (i < profile.userGeneralInfo.userEmergencyContact.length) {
              if (profile.userGeneralInfo.userEmergencyContact[i].firstName !=
                      null &&
                  profile.userGeneralInfo.userEmergencyContact[i].firstName !=
                      '') {
                if (regExpName.hasMatch(profile
                        .userGeneralInfo.userEmergencyContact[i].firstName) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namealsocontact".tr() + ' ${i + 1}';
                }
              }
              if (profile.userGeneralInfo.userEmergencyContact[i].mail ==
                      null ||
                  profile.userGeneralInfo.userEmergencyContact[i].mail == '') {
                checkerEmail1 = false;
                message =
                    "pets_label_primarymailalsocontact2".tr() + ' ${i + 1}';
              } else {
                if (regExpEmail.hasMatch(
                        profile.userGeneralInfo.userEmergencyContact[i].mail) !=
                    true) {
                  checkerEmail1 = false;
                  message =
                      "pets_label_primarymailalsocontact2".tr() + ' ${i + 1}';
                }
              }
              if (profile.userGeneralInfo.userEmergencyContact[i].mail2 !=
                      null &&
                  profile.userGeneralInfo.userEmergencyContact[i].mail2 != '') {
                if (regExpEmail.hasMatch(profile
                        .userGeneralInfo.userEmergencyContact[i].mail2) !=
                    true) {
                  checkerEmail2 = false;
                  message =
                      "pets_label_secondarymailalsocontact2".tr() + ' ${i + 1}';
                }
              }
              if (profile.userGeneralInfo.userEmergencyContact[i].mobile !=
                      null &&
                  profile.userGeneralInfo.userEmergencyContact[i].mobile !=
                      '') {
                if (regExpNumber.hasMatch(profile
                        .userGeneralInfo.userEmergencyContact[i].mobile) !=
                    true) {
                  checkerTel = false;
                  message = "pets_label_phonealsocontact2".tr() + ' ${i + 1}';
                }
              }
              i++;
            }
          }

          if (profile.medicalRecord.userEmergencyContact.isNotEmpty) {
            i = 0;
            while (i < profile.medicalRecord.userEmergencyContact.length) {
              if (profile.medicalRecord.userEmergencyContact[i].firstName ==
                      '' &&
                  profile.medicalRecord.userEmergencyContact[i].lastName ==
                      '' &&
                  profile.medicalRecord.userEmergencyContact[i].mail == '' &&
                  profile.medicalRecord.userEmergencyContact[i].mail2 == '' &&
                  profile.medicalRecord.userEmergencyContact[i].mobile == '') {
                nombrebolckEmergencyContact--;
                profile.medicalRecord.userEmergencyContact.removeAt(i);
              } else {
                i++;
              }
            }
            i = 0;
            while (i < profile.medicalRecord.userEmergencyContact.length) {
              if (profile.medicalRecord.userEmergencyContact[i].firstName !=
                      null &&
                  profile.medicalRecord.userEmergencyContact[i].firstName !=
                      '') {
                if (regExpName.hasMatch(profile
                        .medicalRecord.userEmergencyContact[i].firstName) !=
                    true) {
                  checkerFirstName = false;
                  message =
                      "pets_label_nameemergencycontact".tr() + ' ${i + 1}';
                }
              }
              if (profile.medicalRecord.userEmergencyContact[i].mail == null ||
                  profile.medicalRecord.userEmergencyContact[i].mail == '') {
                checkerEmail1 = false;
                message =
                    "pets_label_primarymailemergencycontact".tr() + ' ${i + 1}';
              } else {
                if (regExpEmail.hasMatch(
                        profile.medicalRecord.userEmergencyContact[i].mail) !=
                    true) {
                  checkerEmail1 = false;
                  message = "pets_label_primarymailemergencycontact".tr() +
                      ' ${i + 1}';
                }
              }

              if (profile.medicalRecord.userEmergencyContact[i].mail2 != null &&
                  profile.medicalRecord.userEmergencyContact[i].mail2 != '') {
                if (regExpEmail.hasMatch(
                        profile.medicalRecord.userEmergencyContact[i].mail2) !=
                    true) {
                  checkerEmail2 = false;
                  message = "pets_label_secondarymailemergencycontact".tr() +
                      ' ${i + 1}';
                }
              }

              if (profile.medicalRecord.userEmergencyContact[i].mobile !=
                      null &&
                  profile.medicalRecord.userEmergencyContact[i].mobile != '') {
                if (regExpNumber.hasMatch(
                        profile.medicalRecord.userEmergencyContact[i].mobile) !=
                    true) {
                  checkerTel = false;
                  message =
                      "pets_label_phoneemergencycontact".tr() + ' ${i + 1}';
                }
              }

              i++;
            }
          }

          if (profile.medicalRecord.physicianContact.isNotEmpty) {
            i = 0;
            while (i < profile.medicalRecord.physicianContact.length) {
              if (profile.medicalRecord.physicianContact[i].firstName == '' &&
                  profile.medicalRecord.physicianContact[i].lastName == '' &&
                  profile.medicalRecord.physicianContact[i].mail == '' &&
                  profile.medicalRecord.physicianContact[i].mail2 == '' &&
                  profile.medicalRecord.physicianContact[i].mobile == '') {
                profile.medicalRecord.physicianContact.removeAt(i);
                userMedicalPhysicianEmergencyContacts.removeAt(i);
                nombrebolckPhysicianContact--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i < profile.medicalRecord.physicianContact.length) {
              if (profile.medicalRecord.physicianContact[i].firstName != null &&
                  profile.medicalRecord.physicianContact[i].firstName != '') {
                if (regExpName.hasMatch(
                        profile.medicalRecord.physicianContact[i].firstName) !=
                    true) {
                  checkerFirstName = false;
                  message =
                      "pets_label_namephysiciancontact".tr() + ' ${i + 1}';
                }
              }
              if (profile.medicalRecord.physicianContact[i].mail == null ||
                  profile.medicalRecord.physicianContact[i].mail == '') {
                checkerEmail1 = false;
                message =
                    "pets_label_primarymailphysiciancontact".tr() + ' ${i + 1}';
              } else {
                if (regExpEmail.hasMatch(
                        profile.medicalRecord.physicianContact[i].mail) !=
                    true) {
                  checkerEmail1 = false;
                  message = "pets_label_primarymailphysiciancontact".tr() +
                      ' ${i + 1}';
                }
              }

              if (profile.medicalRecord.physicianContact[i].mail2 != null &&
                  profile.medicalRecord.physicianContact[i].mail2 != '') {
                if (regExpEmail.hasMatch(
                        profile.medicalRecord.physicianContact[i].mail2) !=
                    true) {
                  checkerEmail2 = false;
                  message = "pets_label_secondaryymailphysiciancontact".tr() +
                      " ${i + 1}";
                }
              }

              if (profile.medicalRecord.physicianContact[i].mobile != null &&
                  profile.medicalRecord.physicianContact[i].mobile != '') {
                if (regExpNumber.hasMatch(
                        profile.medicalRecord.physicianContact[i].mobile) !=
                    true) {
                  checkerTel = false;
                  message =
                      "pets_label_phonephysiciancontact".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.medicalRecord.insuranceInfo.isNotEmpty) {
            i = 0;
            while (i < profile.medicalRecord.insuranceInfo.length) {
              if (profile.medicalRecord.insuranceInfo[i]
                          .insuranceCampanyName ==
                      '' &&
                  profile.medicalRecord.insuranceInfo[i]
                          .additionalInformations ==
                      '' &&
                  profile.medicalRecord.insuranceInfo[i].documents.length ==
                      0 &&
                  profile.medicalRecord.insuranceInfo[i].reminders.length ==
                      0) {
                userInsuranceInfo.removeAt(i);
                profile.medicalRecord.insuranceInfo.removeAt(i);
                nombrebolckInsurance--;
              } else {
                i++;
              }
            }

            i = 0;
            while (i < profile.medicalRecord.insuranceInfo.length) {
              if (profile.medicalRecord.insuranceInfo[i].insuranceCampanyName ==
                      null ||
                  profile.medicalRecord.insuranceInfo[i].insuranceCampanyName ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameinsuranceinfo".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .medicalRecord.insuranceInfo[i].insuranceCampanyName) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameinsuranceinfo".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.medicalRecord.miscilanious.isNotEmpty) {
            i = 0;
            while (i < profile.medicalRecord.miscilanious.length) {
              if (profile.medicalRecord.miscilanious[i].label == '' &&
                  profile.medicalRecord.miscilanious[i].description == '' &&
                  profile.medicalRecord.miscilanious[i].documents.length == 0 &&
                  profile.medicalRecord.miscilanious[i].reminders.length == 0) {
                profile.medicalRecord.miscilanious.removeAt(i);
                userMiscelaneous.removeAt(i);
                nombrebolckMiscelaneous--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i < profile.medicalRecord.miscilanious.length) {
              if (profile.medicalRecord.miscilanious[i].label == null ||
                  profile.medicalRecord.miscilanious[i].label == '') {
                checkerFirstName = false;
                message = "pets_label_namemiscilanious".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(
                        profile.medicalRecord.miscilanious[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namemiscilanious".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.medicalRecord.otherMedicalRecordInfo.isNotEmpty) {
            i = 0;
            while (i < profile.medicalRecord.otherMedicalRecordInfo.length) {
              if (profile.medicalRecord.otherMedicalRecordInfo[i].label == '' &&
                  profile.medicalRecord.otherMedicalRecordInfo[i].description ==
                      '' &&
                  profile.medicalRecord.otherMedicalRecordInfo[i].documents
                          .length ==
                      0 &&
                  profile.medicalRecord.otherMedicalRecordInfo[i].reminder
                          .length ==
                      0) {
                profile.medicalRecord.otherMedicalRecordInfo.removeAt(i);
                nombrebolckOther--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i < profile.medicalRecord.otherMedicalRecordInfo.length) {
              if (profile.medicalRecord.otherMedicalRecordInfo[i].label ==
                      null ||
                  profile.medicalRecord.otherMedicalRecordInfo[i].label == '') {
                checkerFirstName = false;
                message = "pets_label_nameotherinfo".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile
                        .medicalRecord.otherMedicalRecordInfo[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameotherinfo".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.medicalRecord.medicalDiseaces.infectionDisaces.blocks
              .isNotEmpty) {
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.infectionDisaces.blocks
                    .length) {
              if (profile.medicalRecord.medicalDiseaces.infectionDisaces
                          .blocks[i].label ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.infectionDisaces
                          .blocks[i].description ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.infectionDisaces
                          .blocks[i].documents.length ==
                      0 &&
                  profile.medicalRecord.medicalDiseaces.infectionDisaces
                          .blocks[i].reminders.length ==
                      0) {
                profile.medicalRecord.medicalDiseaces.infectionDisaces.blocks
                    .removeAt(i);
                userMedicalDiseacesInfectionDisaces.removeAt(i);
                nombrebolckInfectiousDesease--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.infectionDisaces.blocks
                    .length) {
              if (profile.medicalRecord.medicalDiseaces.infectionDisaces
                          .blocks[i].label ==
                      null ||
                  profile.medicalRecord.medicalDiseaces.infectionDisaces
                          .blocks[i].label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameinfectiondiseace".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile.medicalRecord.medicalDiseaces
                        .infectionDisaces.blocks[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message =
                      "pets_label_nameinfectiondiseace".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile
              .medicalRecord.medicalDiseaces.allergies.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.allergies.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.allergies.blocks[i]
                          .label ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.allergies.blocks[i]
                          .description ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.allergies.blocks[i]
                          .documents.length ==
                      0 &&
                  profile.medicalRecord.medicalDiseaces.allergies.blocks[i]
                          .reminders.length ==
                      0) {
                profile.medicalRecord.medicalDiseaces.allergies.blocks
                    .removeAt(i);
                userMedicalDiseacesAllergies.removeAt(i);
                nombrebolckAllergies--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.allergies.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.allergies.blocks[i]
                          .label ==
                      null ||
                  profile.medicalRecord.medicalDiseaces.allergies.blocks[i]
                          .label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameallergie".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile.medicalRecord.medicalDiseaces
                        .allergies.blocks[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameallergie".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile
              .medicalRecord.medicalDiseaces.implants.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.implants.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.implants.blocks[i]
                          .label ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.implants.blocks[i]
                          .description ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.implants.blocks[i]
                          .documents.length ==
                      0 &&
                  profile.medicalRecord.medicalDiseaces.implants.blocks[i]
                          .reminders.length ==
                      0) {
                profile.medicalRecord.medicalDiseaces.implants.blocks
                    .removeAt(i);
                userMedicalDiseacesImplants.removeAt(i);
                nombrebolckImplant--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.implants.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.implants.blocks[i]
                          .label ==
                      null ||
                  profile.medicalRecord.medicalDiseaces.implants.blocks[i]
                          .label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameimplants".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile.medicalRecord.medicalDiseaces
                        .implants.blocks[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameimplants".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile
              .medicalRecord.medicalDiseaces.renalKenedy.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile
                    .medicalRecord.medicalDiseaces.renalKenedy.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.renalKenedy.blocks[i]
                          .label ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.renalKenedy.blocks[i]
                          .description ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.renalKenedy.blocks[i]
                          .documents.length ==
                      0 &&
                  profile.medicalRecord.medicalDiseaces.renalKenedy.blocks[i]
                          .reminders.length ==
                      0) {
                profile.medicalRecord.medicalDiseaces.renalKenedy.blocks
                    .removeAt(i);
                userMedicalDiseacesRenal.removeAt(i);
                nombrebolckRenal--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile
                    .medicalRecord.medicalDiseaces.renalKenedy.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.renalKenedy.blocks[i]
                          .label ==
                      null ||
                  profile.medicalRecord.medicalDiseaces.renalKenedy.blocks[i]
                          .label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namerenalkenedy".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile.medicalRecord.medicalDiseaces
                        .renalKenedy.blocks[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namerenalkenedy".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.medicalRecord.medicalDiseaces.cardiac.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.cardiac.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.cardiac.blocks[i]
                          .label ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.cardiac.blocks[i]
                          .description ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.cardiac.blocks[i]
                          .documents.length ==
                      0 &&
                  profile.medicalRecord.medicalDiseaces.cardiac.blocks[i]
                          .reminders.length ==
                      0) {
                profile.medicalRecord.medicalDiseaces.cardiac.blocks
                    .removeAt(i);
                userMedicalDiseacesCardiac.removeAt(i);
                nombrebolckCardiac--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.cardiac.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.cardiac.blocks[i]
                          .label ==
                      null ||
                  profile.medicalRecord.medicalDiseaces.cardiac.blocks[i]
                          .label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namecardiac".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile.medicalRecord.medicalDiseaces
                        .cardiac.blocks[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namecardiac".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile
              .medicalRecord.medicalDiseaces.psychiatric.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile
                    .medicalRecord.medicalDiseaces.psychiatric.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.psychiatric.blocks[i]
                          .label ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.psychiatric.blocks[i]
                          .description ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.psychiatric.blocks[i]
                          .documents.length ==
                      0 &&
                  profile.medicalRecord.medicalDiseaces.psychiatric.blocks[i]
                          .reminders.length ==
                      0) {
                profile.medicalRecord.medicalDiseaces.psychiatric.blocks
                    .removeAt(i);
                userMedicalDiseacesPsychiatric.removeAt(i);
                nombrebolckPsychiatric--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile
                    .medicalRecord.medicalDiseaces.psychiatric.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.psychiatric.blocks[i]
                          .label ==
                      null ||
                  profile.medicalRecord.medicalDiseaces.psychiatric.blocks[i]
                          .label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namepsychiatric".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile.medicalRecord.medicalDiseaces
                        .psychiatric.blocks[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namepsychiatric".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile
              .medicalRecord.medicalDiseaces.neuroligic.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile
                    .medicalRecord.medicalDiseaces.neuroligic.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.neuroligic.blocks[i]
                          .label ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.neuroligic.blocks[i]
                          .description ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.neuroligic.blocks[i]
                          .documents.length ==
                      0 &&
                  profile.medicalRecord.medicalDiseaces.neuroligic.blocks[i]
                          .reminders.length ==
                      0) {
                profile.medicalRecord.medicalDiseaces.neuroligic.blocks
                    .removeAt(i);
                nombrebolckNeurologic--;
                userMedicalDiseacesNeurologic.removeAt(i);
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile
                    .medicalRecord.medicalDiseaces.neuroligic.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.neuroligic.blocks[i]
                          .label ==
                      null ||
                  profile.medicalRecord.medicalDiseaces.neuroligic.blocks[i]
                          .label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameneurologic".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile.medicalRecord.medicalDiseaces
                        .neuroligic.blocks[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameneurologic".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile
              .medicalRecord.medicalDiseaces.plumonary.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.plumonary.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.plumonary.blocks[i]
                          .label ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.plumonary.blocks[i]
                          .description ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.plumonary.blocks[i]
                          .documents.length ==
                      0 &&
                  profile.medicalRecord.medicalDiseaces.plumonary.blocks[i]
                          .reminders.length ==
                      0) {
                profile.medicalRecord.medicalDiseaces.plumonary.blocks
                    .removeAt(i);
                userMedicalDiseacesPlumonary.removeAt(i);
                nombrebolckPulmonary--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.plumonary.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.plumonary.blocks[i]
                          .label ==
                      null ||
                  profile.medicalRecord.medicalDiseaces.plumonary.blocks[i]
                          .label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_nameplumonary".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile.medicalRecord.medicalDiseaces
                        .plumonary.blocks[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_nameplumonary".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile
              .medicalRecord.medicalDiseaces.medication.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile
                    .medicalRecord.medicalDiseaces.medication.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.medication.blocks[i]
                          .label ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.medication.blocks[i]
                          .description ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.medication.blocks[i]
                          .documents.length ==
                      0 &&
                  profile.medicalRecord.medicalDiseaces.medication.blocks[i]
                          .reminders.length ==
                      0) {
                profile.medicalRecord.medicalDiseaces.medication.blocks
                    .removeAt(i);
                userMedicalDiseacesMedication.removeAt(i);
                nombrebolckMedication--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile
                    .medicalRecord.medicalDiseaces.medication.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.medication.blocks[i]
                          .label ==
                      null ||
                  profile.medicalRecord.medicalDiseaces.medication.blocks[i]
                          .label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namemedication".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile.medicalRecord.medicalDiseaces
                        .medication.blocks[i].label) !=
                    true) {
                  checkerFirstName = false;
                  message = "pets_label_namemedication".tr() + " ${i + 1}";
                }
              }

              i++;
            }
          }

          if (profile.medicalRecord.medicalDiseaces.cancer.blocks.isNotEmpty) {
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.cancer.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.cancer.blocks[i]
                          .label ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.cancer.blocks[i]
                          .description ==
                      '' &&
                  profile.medicalRecord.medicalDiseaces.cancer.blocks[i]
                          .documents.length ==
                      0 &&
                  profile.medicalRecord.medicalDiseaces.cancer.blocks[i]
                          .reminders.length ==
                      0) {
                profile.medicalRecord.medicalDiseaces.cancer.blocks.removeAt(i);
                userMedicalDiseacesCancer.removeAt(i);
                nombrebolckCancer--;
              } else {
                i++;
              }
            }
            i = 0;
            while (i <
                profile.medicalRecord.medicalDiseaces.cancer.blocks.length) {
              if (profile.medicalRecord.medicalDiseaces.cancer.blocks[i]
                          .label ==
                      null ||
                  profile.medicalRecord.medicalDiseaces.cancer.blocks[i]
                          .label ==
                      '') {
                checkerFirstName = false;
                message = "pets_label_namecancer".tr() + " ${i + 1}";
              } else {
                if (regExpName.hasMatch(profile.medicalRecord.medicalDiseaces
                        .cancer.blocks[i].label) !=
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
          profile.userGeneralInfo.update = false;
          profile.parameters.location = 'profile';
          dispatchEditProfile(profile);
        }
      },
    );
  }

  _deleteButton(Profile profile) {
    return MyButton(
      title: "editprofil_medical_btn_deleteuser".tr(),
      height: 46.0,
      titleSize: 14,
      cornerRadius: 8,
      fontWeight: FontWeight.w600,
      titleColor: Color(0xffEC1C40),
      btnBgColor: ColorConstant.boxColor,
      onPressed: () {
        dispatchDeleteProfile(profile);
      },
      miniWidth: null,
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
              border: alsoInfo || _alsoInfoStatus(profile)
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
              color: alsoInfo || _alsoInfoStatus(profile)
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
                      child: SvgPicture.asset('Assets/Images/alsoContact.svg',
                          color: alsoInfo || _alsoInfoStatus(profile)
                              ? ColorConstant.whiteTextColor
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
                                color: alsoInfo || _alsoInfoStatus(profile)
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
                  bottomLeft: Radius.circular(0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(0))),
          child: InkWell(
              child: Container(
            height: 49,
            decoration: BoxDecoration(
                border: Border.all(width: 0, color: ColorConstant.boxColor),
                color: ColorConstant.boxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(0))),
            child: Padding(
              padding: EdgeInsets.only(top: 1, bottom: 1),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 11, right: 21, bottom: 5),
                    child: MyText(
                        value: "pets_label_contact".tr(),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: ColorConstant.textColor),
                  ),
                  // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),

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
                              .userGeneralInfo.userEmergencyContact.length,
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
                                                profile.userGeneralInfo.update =
                                                    true;

                                                profile.userGeneralInfo
                                                    .userEmergencyContact
                                                    .removeAt(index);
                                                profile.medicalRecord
                                                    .userEmergencyContact
                                                    .removeAt(index);

                                                nombrebolckAlsoContact = profile
                                                    .userGeneralInfo
                                                    .userEmergencyContact
                                                    .length;

                                                addBlock.removeAt(index);
                                                if (profile
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
                                  key: Key(profile.userGeneralInfo
                                      .userEmergencyContact[index].firstName),
                                  emergencyContactMedical: profile.medicalRecord
                                      .userEmergencyContact[index],
                                  userEmergencyContact: profile.userGeneralInfo
                                      .userEmergencyContact[index],
                                  update: profile.userGeneralInfo.update,
                                  dropdownValue: true,
                                  addblock: addBlock[index],
                                  listAddblock: addBlock,
                                  index: index,
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
                        profile.userGeneralInfo.userEmergencyContact.length == 0
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
                                          profile.userGeneralInfo.update = true;
                                          addBlock.add(true);
                                          addBlockEmergency.add(true);
                                          UserEmergencyContact alsoContG =
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
                                          UserEmergencyContact alsoContM =
                                              UserEmergencyContact(
                                            id: 0,
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

                                          profile.userGeneralInfo
                                              .userEmergencyContact
                                              .add(alsoContG);
                                          profile.medicalRecord
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
                                              textColor:
                                                  ColorConstant.pinkColor,
                                              child: MyText(
                                                  value:
                                                      "editprofil_general_btn_addnew"
                                                          .tr(),
                                                  color:
                                                      ColorConstant.pinkColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              onPressed:
                                                  nombrebolckAlsoContact <
                                                          nbblock
                                                      ? () {
                                                          profile
                                                              .userGeneralInfo
                                                              .update = true;
                                                          setState(() {
                                                            nombrebolckAlsoContact++;
                                                            for (int i = 0;
                                                                i <
                                                                    addBlock
                                                                        .length;
                                                                i++) {
                                                              if (addBlock[i] ==
                                                                  true) {
                                                                addBlock[i] =
                                                                    false;
                                                              }
                                                            }
                                                            addBlockEmergency
                                                                .add(true);
                                                            addBlock.add(true);

                                                            UserEmergencyContact
                                                                alsoContG =
                                                                UserEmergencyContact(
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
                                                                .userEmergencyContact
                                                                .add(alsoContG);
                                                            profile
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
                                              textColor:
                                                  ColorConstant.pinkColor,
                                              child: MyText(
                                                  value:
                                                      "editprofil_general_btn_delete"
                                                          .tr(),
                                                  color:
                                                      ColorConstant.pinkColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              onPressed: profile
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color:
                                                        ColorConstant.pinkColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              border: advancedSettings || _ThankYouStatus(profile)
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
              color: advancedSettings || _ThankYouStatus(profile)
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
                  _scrollController.jumpTo(150);
                  memebrs = false;
                  medicInfo = false;
                  persInfo = false;
                  medicalTag = false;
                  viewExport = false;
                  emegInfo = false;
                  alsoInfo = false;
                  contact = false;
                  thankyou = false;
                  userRights = false;
                });
              },
              child: Container(
                height: 49,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11, right: 21),
                      child: SvgPicture.asset('Assets/Images/setting.svg',
                          color: advancedSettings || _ThankYouStatus(profile)
                              ? null
                              : ColorConstant.textBlockVide),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: MyText(
                              value: "pets_label_settings".tr(),

                              // fontWeight: FontWeight.w400,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color:
                                  advancedSettings || _ThankYouStatus(profile)
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
                        _LockSreeen(),
                        SizedBox(height: 12),
                        _thankyou(profile),
                        SizedBox(height: 12),
                        _user_rights(profile),
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
              //  lockSreen ? ColorConstant.pinkColor :
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
                        // lockSreen
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
              color: thankyou || _ThankYouStatus(profile)
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
                        value: "editprofil_general_bloctitle_thankyoumsg".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: thankyou || _ThankYouStatus(profile)
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
                                  .clamp(1.0, 1.1),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                              initialValue:
                                  profile.userGeneralInfo.custumMessage,
                              maxLines: 2,
                              keyboardType: TextInputType.text,
                              focusNode: _thankYouFocus,
                              textInputAction: TextInputAction.done,
                              maxLength: 90,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 1.0, color: Colors.black),
                                border: InputBorder.none,
                              ),
/* buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) => null, */
                              onChanged: (value) {
                                profile.userGeneralInfo.update = true;

                                profile.userGeneralInfo.custumMessage = value;
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

  _user_rights(Profile profile) {
    bool roleAdmin = widget.profile.userGeneralInfo.role == 2 ? true : false;
    bool roleMem = widget.profile.userGeneralInfo.role == 3 ? true : false;
    bool roleChild = widget.profile.userGeneralInfo.role == 4 ? true : false;
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
                  bottomLeft: Radius.circular(userRights ? 0 : 5.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  userRights = !userRights;
                  thankyou = false;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    color: ColorConstant.boxColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(userRights ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 12.5),
                    ),
                    MyText(
                        value: "editprofil_label_userrights".tr(),
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
                        Column(
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
                                child: maxNombreAdmin == true &&
                                        profile.userGeneralInfo.role != 2
                                    ? Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 11,
                                                            right: 21),
                                                    child: MyText(
                                                        value:
                                                            "editprofil_label_administrator"
                                                                .tr(),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: ColorConstant
                                                            .greyTextColor),
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
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 11,
                                                            right: 21),
                                                    child: MyText(
                                                        value:
                                                            "editprofil_label_administrator"
                                                                .tr(),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: isMember
                                                            ? ColorConstant
                                                                .greyTextColor
                                                            : ColorConstant
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

                                          isMember
                                              ? Container()
                                              : CustomSwitch(
                                                  key: Key(profile
                                                      .userGeneralInfo.role
                                                      .toString()),
                                                  activeColor:
                                                      Color(0xff34C759),
                                                  value: roleAdmin,
                                                  onChanged: (value) {
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

                                                    profile.userGeneralInfo
                                                        .update = true;

                                                    setState(() {
                                                      if (value == true) {
                                                        setState(() {
                                                          profile
                                                              .userGeneralInfo
                                                              .role = 2;
                                                          profile.userGeneralInfo
                                                                  .roleLabel =
                                                              'Administrator';
                                                          roleChild = false;
                                                          roleMember = false;
                                                        });
                                                        setState(() {
                                                          print(roleChild);
                                                        });
                                                      } else {
                                                        setState(() {});
                                                      }
                                                    });

                                                    setState(() {});
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
                                              padding: const EdgeInsets.only(
                                                  left: 11, right: 21),
                                              child: MyText(
                                                  value:
                                                      "editprofil_label_member"
                                                          .tr(),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color:
                                                      ColorConstant.textColor),

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
                                      key: Key(profile.userGeneralInfo.role
                                          .toString()),
                                      activeColor: Color(0xff34C759),
                                      value: roleMember,
                                      onChanged: (value) {
                                        profile.userGeneralInfo.update = true;

                                        setState(() {
                                          if (value == true) {
                                            setState(() {
                                              profile.userGeneralInfo.role = 3;
                                              profile.userGeneralInfo
                                                  .roleLabel = 'Member';
                                              if (maxNombreAdmin == true) {
                                                maxNombreAdmin = false;
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
                                                padding: const EdgeInsets.only(
                                                    left: 11, right: 21),
                                                child: MyText(
                                                  value:
                                                      "editprofil_label_child"
                                                          .tr(),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: ColorConstant
                                                      .greyTextColor,
                                                )
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
                                    // CustomSwitch(
                                    //   key: Key(profile.userGeneralInfo.role
                                    //       .toString()),
                                    //   activeColor: Color(0xff34C759),
                                    //   value: roleChild,
                                    //   onChanged: (value) {
                                    //     profile.userGeneralInfo.update = true;

                                    //     setState(() {
                                    //       if (value == true) {
                                    //         setState(() {
                                    //           profile.userGeneralInfo.role = 4;
                                    //           profile.userGeneralInfo
                                    //                   .roleLabel =
                                    //               'Child / Vulnerable';
                                    //           if (maxNombreAdmin == true) {
                                    //             maxNombreAdmin = false;
                                    //           }
                                    //         });
                                    //       } else {
                                    //         setState(() {});
                                    //       }
                                    //     });
                                    //   },
                                    // ),
                                    SizedBox(
                                      width: 14,
                                    )
                                  ],
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

  _Adminsitrator(Profile profile, roleAdmin, roleMem, roleChild) {
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
                              value: "editprofil_label_administrator".tr(),
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
                  key: Key(profile.userGeneralInfo.role.toString()),
                  activeColor: Color(0xff34C759),
                  value: roleAdmin,
                  onChanged: (value) {
                    setState(() {
                      roleAdmin = true;
                      roleMem = false;
                      roleChild = false;
                      if (value = true) {
                        profile.userGeneralInfo.role = 2;
                      }

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

  _MembersUser(Profile profile, roleAdmin, roleMem, roleChild) {
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
                              value: "editprofil_label_member".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant.darkGray),

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
                  key: Key(profile.userGeneralInfo.role.toString()),
                  activeColor: Color(0xff34C759),
                  value: false,
                  // onChanged: (value) {
                  //   setState(() {
                  //     roleMem=true;
                  //       roleAdmin=false;
                  //     roleChild=false;
                  //    if (value=true){
                  //      profile.userGeneralInfo.role=3;
                  //    }

                  //     _switchIncludePhone = value;
                  //   });
                  // },
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

  _Child(Profile profile, roleAdmin, roleMem, roleChild) {
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
                              value: "editprofil_label_child".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant.darkGray),

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
                  key: Key(profile.userGeneralInfo.role.toString()),
                  activeColor: Color(0xff34C759),
                  value: false,
                  // onChanged: (value) {
                  //   setState(() {
                  //     roleChild=true;
                  //      roleAdmin=false;
                  //     roleMem=false;
                  //     if (value=true){
                  //      profile.userGeneralInfo.role=4;
                  //    }

                  //   _switchIncludePhone = value;
                  // });
                  // },
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

  //
  // family members
  _Memebrs(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              border: contact || _GenerlInfoStatus(profile)
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
              color: memebrs || _FamilyMmebreStatus(profile)
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
                  _scrollController.jumpTo(200);

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
                      child: SvgPicture.asset('Assets/Images/familyMember.svg',
                          color: memebrs || _FamilyMmebreStatus(profile)
                              ? ColorConstant.whiteTextColor
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
                                color: memebrs || _FamilyMmebreStatus(profile)
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
                        _userList(profile),
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

  _userList(Profile profile) {
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
                          value: 'editprofil_label_addmember'.tr(),
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
              Container(
                height: 300,
                child: GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 0.0,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.35)),
                  itemCount: subUsersList.length + 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Row(
                        children: [
                          if (index == 0)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  memebrs = false;
                                });
                                Navigator.of(context)
                                    .push(Scan4Dialog(profile));
                              },
                              child: Container(
                                width: screenWidth * 0.245,
                                height: screenHeight * 0.16,
                                decoration: BoxDecoration(
                                    color: ColorConstant.lightGrey,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(1.0, 4.0),
                                        //  spreadRadius: 7.0,
                                        blurRadius: 5.0,
                                      ),
                                    ]),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset("Assets/Images/add.png",
                                          color: ColorConstant.pinkColor,
                                          height: 40.86,
                                          width: 40.86),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      MyText(
                                          value: "objecttag_btn_addnew".tr(),
                                          fontSize: 10,
                                          color: ColorConstant.pinkColor,
                                          fontWeight: FontWeight.w600),
                                      //Container(height: 15,width: 15,color:Colors.green),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if (index != 0)
                            Expanded(
                              child: Container(
                                width: screenWidth * 0.25,
                                height: screenHeight * 0.16,
                                decoration: BoxDecoration(
                                    color: profile
                                            .userGeneralInfo.linkedMedicalRecord
                                            .contains(
                                      subUsersList[index - 1]
                                          .userGeneralInfo
                                          .idMember,
                                    )
                                        ? ColorConstant.pinkColor
                                        : ColorConstant.lightGrey,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(1.0, 4.0),
                                        //  spreadRadius: 7.0,
                                        blurRadius: 5.0,
                                      ),
                                    ]),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        profile.userGeneralInfo
                                                .linkedMedicalRecord
                                                .contains(
                                          subUsersList[index - 1]
                                              .userGeneralInfo
                                              .idMember,
                                        )
                                            ? Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  screenWidth * 0.02,
                                                  screenHeight * 0.008,
                                                  screenWidth * 0.02,
                                                  0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Image.asset(
                                                      "Assets/Images/Medical-Icon.png",
                                                      height: 11,
                                                      width: 11,
                                                    ),
                                                    Image.asset(
                                                      "Assets/Images/Icon-awesome-link.png",
                                                      height: 11,
                                                      width: 11,
                                                    ),
                                                  ],
                                                ))
                                            : Container(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: screenHeight * 0.01,
                                          ),
                                          child: Container(
                                            height: (screenWidth * 16.2) / 100,
                                            width: (screenWidth * 16.2) / 100,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3.0),
                                              boxShadow: [
                                                new BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2.0,
                                                  spreadRadius: 0.01,
                                                ),
                                              ],
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      subUsersList[index - 1]
                                                          .userGeneralInfo
                                                          .profilePictureUrl),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: MyText(
                                            value: subUsersList[index - 1]
                                                    .userGeneralInfo
                                                    .firstName ??
                                                '' +
                                                    ' ' +
                                                    subUsersList[index - 1]
                                                        .userGeneralInfo
                                                        .lastName ??
                                                '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            color: profile.userGeneralInfo
                                                    .linkedMedicalRecord
                                                    .contains(
                                              subUsersList[index - 1]
                                                  .userGeneralInfo
                                                  .idMember,
                                            )
                                                ? ColorConstant.lightGrey
                                                : ColorConstant.pinkColor,
                                            fontSize: 7,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        profile.userGeneralInfo
                                                .linkedMedicalRecord
                                                .contains(
                                          subUsersList[index - 1]
                                              .userGeneralInfo
                                              .idMember,
                                        )
                                            ? SizedBox(
                                                height: screenHeight * 0.03,
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                    subUsersList[index - 1]
                                                .userGeneralInfo
                                                .roleLabel ==
                                            'Administrator'
                                        ? Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 15,
                                              width: screenWidth * 0.25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(8.0),
                                                    bottomLeft:
                                                        Radius.circular(8.0),
                                                  ),
                                                  color: profile.userGeneralInfo
                                                          .linkedMedicalRecord
                                                          .contains(
                                                    subUsersList[index - 1]
                                                        .userGeneralInfo
                                                        .idMember,
                                                  )
                                                      ? ColorConstant
                                                          .whiteTextColor
                                                      : ColorConstant
                                                          .pinkColor),
                                              child: MyText(
                                                value: subUsersList[index - 1]
                                                    .userGeneralInfo
                                                    .roleLabel,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                color: profile.userGeneralInfo
                                                        .linkedMedicalRecord
                                                        .contains(
                                                  subUsersList[index - 1]
                                                      .userGeneralInfo
                                                      .idMember,
                                                )
                                                    ? ColorConstant.pinkColor
                                                    : ColorConstant
                                                        .whiteTextColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 8,
                                              ),
                                            ))
                                        : Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                                height: 14,
                                                width: screenWidth * 1.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8.0)),
                                                ),
                                                child: MyText(
                                                  value: subUsersList[index - 1]
                                                          .userGeneralInfo
                                                          .roleLabel ??
                                                      ' ',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color:
                                                      ColorConstant.pinkColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 8,
                                                )),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                color: medicalTag || _medicalTagStatus(profile)
                    ? ColorConstant.primaryColor
                    : ColorConstant.colorBlockVide,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Container(
                height: 49,
                padding: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                  color: medicalTag || _medicalTagStatus(profile)
                      ? ColorConstant.separatedColor
                      : ColorConstant.boxColor,
                ),
                child: Container(
                  height: 49,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    color: medicalTag || _medicalTagStatus(profile)
                        ? ColorConstant.pinkColor
                        : ColorConstant.colorBlockVide,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _scrollController.jumpTo(200);

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
                                  const EdgeInsets.only(left: 0, right: 21),
                              child: Image.asset("Assets/Images/Medicalb.png",
                                  height: 32,
                                  width: 31,
                                  color:
                                      medicalTag || _medicalTagStatus(profile)
                                          ? null
                                          : ColorConstant.textBlockVide),
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
                                              _medicalTagStatus(profile)
                                          ? ColorConstant.whiteTextColor
                                          : ColorConstant.textBlockVide,
                                    ),
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
                                padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
                                child: Container(
                                  height: 42,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 42,
                                        width: 42,
                                        decoration: BoxDecoration(
                                          color:
                                              ColorConstant.imgBackgroundColor,
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
                                                value: "Code: " +
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
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Stack(
                                                  children: [
                                                    CustomSwitch(
                                                      key: Key(
                                                          userMedicalTags[index]
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
                                                          userMedicalTags[index]
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
                                                          const EdgeInsets.only(
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
                                          userMedicalTags[index]
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
                                                  fontWeight: FontWeight.w500),
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
                      ],
                    ),
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
                color: persInfo || _PersonalInformationStatus(profile)
                    ? ColorConstant.primaryColor
                    : ColorConstant.colorBlockVide,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Container(
                height: 49,
                padding: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(color: ColorConstant.separatedColor),
                child: Container(
                  height: 49,
                  decoration: BoxDecoration(
                    color: persInfo || _PersonalInformationStatus(profile)
                        ? ColorConstant.pinkColor
                        : ColorConstant.colorBlockVide,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _scrollController.jumpTo(260);
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
                          gender = false;
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
                                        _PersonalInformationStatus(profile)
                                    ? null
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
                                                  profile)
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
              gender = false;
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
                  color: gender || _GenderStatus(profile)
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
                          color: gender || _GenderStatus(profile)
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
                                  color: gender || _GenderStatus(profile)
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

                                        profile.medicalRecord.idGender =
                                            newVal['id'];
                                      });
                                    },
                                    isExpanded: true,
                                    value: genderData,
                                    hint: MyText(
                                        value: profile.medicalRecord.idGender !=
                                                null
                                            ? profile.parameters.genderList[
                                                profile.medicalRecord.idGender -
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
              color:
                  insuranceInformation || _InsuranceInformationStatus(profile)
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
                gender = false;
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
                            color: _InsuranceInformationStatus(profile) ||
                                    insuranceInformation
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
                                color: _InsuranceInformationStatus(profile) ||
                                        insuranceInformation
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
                          color: ColorConstant.primaryColor,
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
                                                  profile.userGeneralInfo
                                                      .update = true;

                                                  userInsuranceInfo
                                                      .removeAt(index);

                                                  profile.medicalRecord
                                                      .insuranceInfo
                                                      .removeAt(index);
                                                  addBlockInsurance
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
                                    documents:
                                        userInsuranceInfo[index].documents,
                                    index: index,
                                    // text: bloodController,
                                    visibileInsurance: _visiInsurance,
                                    addblockInsurance: addBlockInsurance,
                                    update: profile.userGeneralInfo.update),
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
                                          profile.userGeneralInfo.update = true;
                                          addBlockInsurance.add(true);
                                          InsuranceInfo insuranceInfo =
                                              InsuranceInfo(
                                                  active: 1,
                                                  additionalInformations: '',
                                                  insuranceCampanyName: '',
                                                  documents: [],
                                                  reminders: []);
                                          userInsuranceInfo.add(insuranceInfo);

                                          profile.medicalRecord.insuranceInfo
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
                                              textColor:
                                                  ColorConstant.pinkColor,
                                              child: MyText(
                                                  value:
                                                      "editprofil_general_btn_addnew"
                                                          .tr(),
                                                  fontSize: 14,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w500),
                                              onPressed: nombrebolckInsurance <
                                                      nbblock
                                                  ? () {
                                                      profile.userGeneralInfo
                                                          .update = true;

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

                                                        profile.medicalRecord
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
                                              textColor:
                                                  ColorConstant.primaryColor,
                                              child: MyText(
                                                  value:
                                                      "editprofil_general_btn_delete"
                                                          .tr(),
                                                  fontSize: 14,
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w500),
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    fontSize: 14,
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                color: height || _WeightHeightStatus(profile)
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
                  gender = false;
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
                        color: height || _WeightHeightStatus(profile)
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
                                    'editprofil_medical_subtitle_weightandheight'
                                        .tr(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: height || _WeightHeightStatus(profile)
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
                                        // key:GlobalKey(),

                                        width: 35,
                                        keyboardType: TextInputType.number,
                                        focusNode: feetFocus,
                                        inputType: TextInputType.number,
                                        maxline: 1,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        initialValue: profile.medicalRecord
                                                    .heightweight.heightFt !=
                                                null
                                            ? profile.medicalRecord.heightweight
                                                .heightFt
                                                .toString()
                                            : '',
                                        onChanged: (value) {
                                          widget.profile.userGeneralInfo
                                              .update = true;

                                          widget
                                              .profile
                                              .medicalRecord
                                              .heightweight
                                              .heightFt = double.parse(value);

                                          profile.medicalRecord.heightweight
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
                                        // key:GlobalKey(),

                                        width: 35,
                                        keyboardType: TextInputType.number,
                                        focusNode: inchFocus,
                                        maxline: 1,

                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        title: '',
                                        initialValue: profile.medicalRecord
                                                    .heightweight.heightInch !=
                                                null
                                            ? profile.medicalRecord.heightweight
                                                .heightInch
                                                .toString()
                                            : '',

                                        onChanged: (value) {
                                          widget.profile.userGeneralInfo
                                              .update = true;
                                          profile.medicalRecord.heightweight
                                              .heightInch = double.parse(value);

                                          profile.medicalRecord.heightweight
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
                                        // key:GlobalKey(),
                                        width: 44,
                                        keyboardType: TextInputType.number,
                                        focusNode: cmFocus,
                                        maxline: 1,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        title: '',
                                        // textController: cmController,
                                        initialValue: profile.medicalRecord
                                                    .heightweight.heightCm !=
                                                null
                                            ? profile.medicalRecord.heightweight
                                                .heightCm
                                                .toString()
                                            : '',
                                        onChanged: (value) {
                                          widget.profile.userGeneralInfo
                                              .update = true;
                                          profile.medicalRecord.heightweight
                                              .heightCm = double.parse(value);

                                          double inc = profile.medicalRecord
                                                  .heightweight.heightCm /
                                              2.54;
                                          profile.medicalRecord.heightweight
                                                  .heightFt =
                                              (inc / 12).floorToDouble();
                                          profile.medicalRecord.heightweight
                                                  .heightInch =
                                              inc -
                                                  (12 *
                                                      profile
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
                                              color: ColorConstant.textColor)),
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
                                          //  key:GlobalKey(),

                                          width: 44,
                                          keyboardType: TextInputType.number,
                                          focusNode: lbsFocus,
                                          maxline: 1,
                                          editTextBgColor:
                                              ColorConstant.textfieldColor,
                                          hintTextColor: Colors.white54,
                                          title: '',
                                          initialValue: profile.medicalRecord
                                                      .heightweight.weightLbs !=
                                                  null
                                              ? profile.medicalRecord
                                                  .heightweight.weightLbs
                                                  .toString()
                                              : '',
                                          inputType: TextInputType.number,
                                          onChanged: (value) {
                                            widget.profile.userGeneralInfo
                                                .update = true;

                                            profile.medicalRecord.heightweight
                                                    .weightLbs =
                                                double.parse(value);

                                            double kg =
                                                double.parse(value) * 0.4536;
                                            print(kg);

                                            profile.medicalRecord.heightweight
                                                .weightKg = profile
                                                    .medicalRecord
                                                    .heightweight
                                                    .weightLbs *
                                                0.4536;
                                          }),
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
                                        // key:GlobalKey(),

                                        width: 44,
                                        keyboardType: TextInputType.number,
                                        focusNode: kgFocus,
                                        maxline: 1,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,

                                        // textController: kgController,
                                        initialValue: profile.medicalRecord
                                                    .heightweight.weightKg !=
                                                null
                                            ? profile.medicalRecord.heightweight
                                                .weightKg
                                                .toString()
                                            : ' ',
                                        onChanged: (value) {
                                          widget.profile.userGeneralInfo
                                              .update = true;
                                          profile.medicalRecord.heightweight
                                              .weightKg = double.parse(value);

                                          double lbs =
                                              double.parse(value) * 2.2046;

                                          profile.medicalRecord.heightweight
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
              color: language || _LanguageSpookenStatus(profile)
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
                  gender = false;
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
                        color: language || _LanguageSpookenStatus(profile)
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
                                color:
                                    language || _LanguageSpookenStatus(profile)
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
                          initialValue: profile.medicalRecord.spokenLanguages !=
                                  null
                              ? profile.medicalRecord.spokenLanguages.toString()
                              : '',
                          inputType: TextInputType.text,
                          keyboardType: TextInputType.text,
                          editTextBgColor: ColorConstant.textfieldColor,
                          hintTextColor: Colors.white54,
                          maxline: 5,
                          onChanged: (value) {
                            widget.profile.userGeneralInfo.update = true;
                            profile.medicalRecord.spokenLanguages = value;
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
              color: eye || _EyeColorStatus(profile)
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
                gender = false;
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
                        color: eye || _EyeColorStatus(profile)
                            ? ColorConstant.primaryColor
                            : ColorConstant.darkGray,
                      ),
                    ),
                    MyText(
                        value: "editprofil_medical_subtitle_eyecolor".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: eye || _EyeColorStatus(profile)
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
                                      widget.profile.userGeneralInfo.update =
                                          true;
                                      setState(() {
                                        profile.medicalRecord.idEyeColor =
                                            newVal['id'];
                                      });
                                    },
                                    isExpanded: true,
                                    value: eyeData,
                                    hint: MyText(
                                        value: profile
                                                    .medicalRecord.idEyeColor !=
                                                null
                                            ? profile.parameters.eyeColorList[
                                                profile.medicalRecord
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
              color: religion || _ReligionStatus(profile)
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
                gender = false;
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
                      color: religion || _ReligionStatus(profile)
                          ? ColorConstant.primaryColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "editprofil_medical_subtitle_religion".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: religion || _ReligionStatus(profile)
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
                          initialValue: profile.medicalRecord.religionLabel,
                          inputType: TextInputType.text,
//                                  textAlign: TextAlign.start,
                          maxline: 1,
                          focusNode: petsHomeFocus,

                          editTextBgColor: ColorConstant.textfieldColor,
                          hintTextColor: Colors.white54,
                          title: '',
                          onChanged: (value) {
                            profile.userGeneralInfo.update = true;
                            profile.medicalRecord.religionLabel = value;
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
              color: distinctiveSigns || _DistinctiveSigneStatus(profile)
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
                  gender = false;
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
                        color:
                            distinctiveSigns || _DistinctiveSigneStatus(profile)
                                ? ColorConstant.primaryColor
                                : ColorConstant.darkGray,
                      ),
                    ),
                    MyText(
                        value: "editprofil_medical_subtitle_signs".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color:
                            distinctiveSigns || _DistinctiveSigneStatus(profile)
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
                            initialValue: profile.medicalRecord.distitnctSign,

                            inputType: TextInputType.multiline,
//                                  textAlign: TextAlign.start,
                            focusNode: distinctiveSignsFocus,
                            editTextBgColor: ColorConstant.textfieldColor,
                            hintTextColor: Colors.white54,
                            title: '',
                            maxline: 5,
                            onChanged: (value) {
                              widget.profile.userGeneralInfo.update = true;
                              profile.medicalRecord.distitnctSign = value;
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
              color: dob || _birthdayStatus(profile)
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
                gender = false;
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
                      color: dob || _birthdayStatus(profile)
                          ? ColorConstant.primaryColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "editprofil_medical_subtitle_birth".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: dob || _birthdayStatus(profile)
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
                        )
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
              color: maritalStatus || _MaritalStatusStatus(profile)
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
                gender = false;
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
                      color: maritalStatus || _MaritalStatusStatus(profile)
                          ? ColorConstant.primaryColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "editprofil_medical_subtitle_status".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: maritalStatus || _MaritalStatusStatus(profile)
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
                                      items: profile
                                          .parameters.materialStatusList
                                          .map(
                                            (e) => DropdownMenuItem(
                                              child: MyText(
                                                  value:
                                                      e['marital_status_label'],
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ColorConstant.textColor),
                                              value: e,
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          profile.medicalRecord
                                              .idMaritalStatus = newVal['id'];
                                        });
                                      },
                                      isExpanded: true,
                                      value: maritalData,
                                      hint: MyText(
                                          value: profile.medicalRecord
                                                      .idMaritalStatus !=
                                                  null
                                              ? profile.parameters
                                                  .materialStatusList[profile
                                                      .medicalRecord
                                                      .idMaritalStatus -
                                                  1]['marital_status_label']
                                              : '',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: ColorConstant.darkGray)),
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
              color: petsHome || _PetStatus(profile)
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
                gender = false;
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
                      color: petsHome || _PetStatus(profile)
                          ? ColorConstant.primaryColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "editprofil_medical_subtitle_pet".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: petsHome || _PetStatus(profile)
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
                          initialValue: profile.medicalRecord.petAtHome,
                          inputType: TextInputType.text,
//                                  textAlign: TextAlign.start,
                          maxline: 1,
                          focusNode: petsHomeFocus,

                          editTextBgColor: ColorConstant.textfieldColor,
                          hintTextColor: Colors.white54,
                          title: '',
                          onChanged: (value) {
                            widget.profile.userGeneralInfo.update = true;
                            profile.medicalRecord.petAtHome = value;
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
              color: miscelaneous || _MiscelaneousStatus(profile)
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
                gender = false;
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
                      color: miscelaneous || _MiscelaneousStatus(profile)
                          ? ColorConstant.primaryColor
                          : ColorConstant.darkGray,
                    ),
                  ),
                  MyText(
                      value: "editprofil_medical_subtitle_miscelaneous".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: miscelaneous || _MiscelaneousStatus(profile)
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
                                                widget.profile.userGeneralInfo
                                                    .update = true;
                                                userMiscelaneous
                                                    .removeAt(index);
                                                profile
                                                    .medicalRecord.miscilanious
                                                    .removeAt(index);
                                                addBlockMisc.removeAt(index);

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
                                    miscilanious: userMiscelaneous[index],
                                    attachment: true,
                                    alarm: true,
                                    // text: miscelaneousController,
                                    switchValue:
                                        userMiscelaneous[index].allow == 1
                                            ? true
                                            : false,
                                    dropdownValue: true,
                                    addblockMisc: addBlockMisc,
                                    update:
                                        widget.profile.userGeneralInfo.update,
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
                                          widget.profile.userGeneralInfo
                                              .update = true;
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

                                          profile.medicalRecord.miscilanious
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
                                              textColor:
                                                  ColorConstant.pinkColor,
                                              child: MyText(
                                                  value:
                                                      "editprofil_general_btn_addnew"
                                                          .tr(),
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              onPressed:
                                                  nombrebolckMiscelaneous <
                                                          nbblock
                                                      ? () {
                                                          widget
                                                              .profile
                                                              .userGeneralInfo
                                                              .update = true;
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
                                              textColor:
                                                  ColorConstant.primaryColor,
                                              child: MyText(
                                                  value:
                                                      "editprofil_general_btn_delete"
                                                          .tr(),
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                color: _EmgInfoStatus(profile) || emegInfo
                    ? ColorConstant.primaryColor
                    : ColorConstant.colorBlockVide,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Container(
                height: 49,
                padding: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                  color: _EmgInfoStatus(profile) || emegInfo
                      ? ColorConstant.separatedColor
                      : ColorConstant.boxColor,
                ),
                child: Container(
                  height: 49,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    color: _EmgInfoStatus(profile) || emegInfo
                        ? ColorConstant.pinkColor
                        : ColorConstant.colorBlockVide,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _scrollController.jumpTo(320);
                          emegInfo = !emegInfo;
                          medicInfo = false;
                          medicalTag = false;
                          viewExport = false;
                          persInfo = false;
                          memebrs = false;
                          advancedSettings = false;
                          alsoInfo = false;
                          contact = false;
                          emergencyContacts = false;
                          physicianContacts = false;
                        });
                      },
                      child: Container(
                        height: 49,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 0, right: 21),
                              child: SvgPicture.asset(
                                'Assets/Images/emergencyMedical.svg',
                                color: _EmgInfoStatus(profile) || emegInfo
                                    ? null
                                    : ColorConstant.textBlockVide,
                              ),
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
                                        color:
                                            _EmgInfoStatus(profile) || emegInfo
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
                        _emergencyContacts(profile),
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
              color: emergencyContacts || _EmergencyContactsStatus(profile)
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
                                        _EmergencyContactsStatus(profile)
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
                          itemCount:
                              profile.medicalRecord.userEmergencyContact.length,
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
                                              profile.userGeneralInfo.update =
                                                  true;
                                              profile.medicalRecord
                                                  .userEmergencyContact
                                                  .removeAt(index);
                                              addBlockEmergency.removeAt(index);

                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              ExpandableEmergency(
                                  key: Key(profile.medicalRecord
                                      .userEmergencyContact[index].firstName),
                                  userEmergencyContactGeneral: profile
                                      .userGeneralInfo
                                      .userEmergencyContact[index],
                                  userEmergencyContact: profile.medicalRecord
                                      .userEmergencyContact[index],
                                  dropdownValue: true,
                                  index: index,
                                  addBlockEmergency: addBlockEmergency,
                                  update: profile.userGeneralInfo.update,
                                  expandFlag: expandFlag,
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
                                        textColor: ColorConstant.pinkColor,
                                        child: MyText(
                                            value:
                                                "editprofil_general_btn_addnew"
                                                    .tr(),
                                            color: ColorConstant.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        onPressed: nombrebolckAlsoContact <
                                                nbblock
                                            ? () {
                                                setState(() {
                                                  expandFlag = true;
                                                  profile.userGeneralInfo
                                                      .update = true;
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
                                                  addBlock.add(true);
                                                  addBlockEmergency.add(true);
                                                  nombrebolckAlsoContact++;

                                                  UserEmergencyContact
                                                      alsoContG =
                                                      UserEmergencyContact(
                                                    id: 0,
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

                                                  profile.userGeneralInfo
                                                      .userEmergencyContact
                                                      .add(alsoContG);
                                                  profile.medicalRecord
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
              color: physicianContacts || _PhysicianContactsStatus(profile)
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
                                        _PhysicianContactsStatus(profile)
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
                                                userMedicalPhysicianEmergencyContacts
                                                    .removeAt(index);
                                                profile.userGeneralInfo.update =
                                                    true;

                                                profile.medicalRecord
                                                    .physicianContact
                                                    .removeAt(index);
                                                addBlockPhysician
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
                                    addBlockPhysician: addBlockPhysician,
                                    physicianContact:
                                        userMedicalPhysicianEmergencyContacts[
                                            index],
                                    index: index,
                                    update: profile.userGeneralInfo.update,
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
                                title: "+ " 'Add New Physician Emergency',
                                height: 36.0,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckPhysicianContact < nbblock
                                    ? () {
                                        setState(() {
                                          nombrebolckPhysicianContact++;
                                          profile.userGeneralInfo.update = true;
                                          addBlockPhysician.add(true);
                                          PhysicianContact physicienContact =
                                              PhysicianContact(
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

                                          profile.medicalRecord.physicianContact
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
                                              textColor:
                                                  ColorConstant.pinkColor,
                                              child: MyText(
                                                  value:
                                                      "editprofil_general_btn_addnew"
                                                          .tr(),
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              onPressed:
                                                  nombrebolckPhysicianContact <
                                                          nbblock
                                                      ? () {
                                                          setState(() {
                                                            nombrebolckPhysicianContact++;
                                                            profile
                                                                .userGeneralInfo
                                                                .update = true;
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
                                              textColor:
                                                  ColorConstant.primaryColor,
                                              child: MyText(
                                                  value:
                                                      "editprofil_general_btn_delete"
                                                          .tr(),
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                color: medicInfo || _MedicalInformationStatus(profile)
                    ? ColorConstant.primaryColor
                    : ColorConstant.colorBlockVide,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Container(
                height: 49,
                padding: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                  color: medicInfo || _MedicalInformationStatus(profile)
                      ? ColorConstant.separatedColor
                      : ColorConstant.boxColor,
                ),
                child: Container(
                  height: 49,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                      color: medicInfo || _MedicalInformationStatus(profile)
                          ? ColorConstant.pinkColor
                          : ColorConstant.colorBlockVide),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          medicInfo = !medicInfo;
                          _scrollController.jumpTo(380);
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
                                  const EdgeInsets.only(left: 0, right: 21),
                              child: SvgPicture.asset(
                                'Assets/Images/medicalInfo.svg',
                                color: medicInfo ||
                                        _MedicalInformationStatus(profile)
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
                                          "listingtags_title_medicalinfo".tr(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: medicInfo ||
                                              _MedicalInformationStatus(profile)
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
              color: _infectiousdiseases || _infectionDisacesStatus(profile)
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
                                    _infectionDisacesStatus(profile)
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
                                              profile.userGeneralInfo.update =
                                                  true;

                                              userMedicalDiseacesInfectionDisaces
                                                  .removeAt(index);
                                              profile
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .infectionDisaces
                                                  .blocks
                                                  .removeAt(index);
                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                              addBlockInfec.removeAt(index);
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
                                  diseace: userMedicalDiseacesInfectionDisaces[
                                      index],
                                  title: userMedicalDiseacesInfectionDisaces[
                                          index]
                                      .label,
                                  desc: userMedicalDiseacesInfectionDisaces[
                                          index]
                                      .description,
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
                                  update: profile.userGeneralInfo.update,
                                  reminders:
                                      userMedicalDiseacesInfectionDisaces[index]
                                          .reminders,
                                  text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  addBlockDiseace: addBlockInfec,
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
                                title: "+ Add New Infectious Desease  ",
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckInfectiousDesease <
                                        nbblock
                                    ? () {
                                        setState(() {
                                          profile.userGeneralInfo.update = true;
                                          addBlockInfec.add(true);
                                          nombrebolckInfectiousDesease++;
                                          Blocks infectiousDeases = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesInfectionDisaces
                                              .add(infectiousDeases);

                                          widget
                                              .profile
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
                                                        profile.userGeneralInfo
                                                            .update = true;
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
                                                        nombrebolckInfectiousDesease++;
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

                                                        widget
                                                            .profile
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              color: _allergies || _allergiesStatus(profile)
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
                            color: _allergies || _allergiesStatus(profile)
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
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .allergies
                                                  .blocks
                                                  .removeAt(index);
                                              addBlockAllerg.removeAt(index);
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
                                  update: profile.userGeneralInfo.update,
                                  diseace: userMedicalDiseacesAllergies[index],
                                  title:
                                      userMedicalDiseacesAllergies[index].label,
                                  desc: userMedicalDiseacesAllergies[index]
                                      .description,
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
                                  addBlockDiseace: addBlockAllerg,
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
                                title: "+ Add New Allergies   ",
                                height: 36,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: ColorConstant.primaryColor,
                                cornerRadius: 5.0,
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckAllergies < nbblock
                                    ? () {
                                        nombrebolckAllergies++;
                                        addBlockAllerg.add(true);
                                        setState(() {
                                          Blocks allergies = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesAllergies
                                              .add(allergies);
                                          widget.profile.medicalRecord
                                              .medicalDiseaces.allergies.blocks
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
                                                  for (int i = 0;
                                                      i < addBlockAllerg.length;
                                                      i++) {
                                                    if (addBlockAllerg[i] ==
                                                        true) {
                                                      addBlockAllerg[i] = false;
                                                    }
                                                  }

                                                  addBlockAllerg.add(true);
                                                  setState(() {
                                                    Blocks allergies = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesAllergies
                                                        .add(allergies);
                                                    widget
                                                        .profile
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
                                              textColor:
                                                  ColorConstant.primaryColor,
                                              child: MyText(
                                                  value:
                                                      "editprofil_general_btn_delete"
                                                          .tr(),
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              color: _dnr || _DnrStatus(profile)
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
                          color: _dnr || _DnrStatus(profile)
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
                              Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.30)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                ExpandableDnrView(
                                  profile: profile,
                                  update: profile.userGeneralInfo.update,
                                  index: index,
                                  // text: bloodController,
                                  resuscitateInfo:
                                      profile.medicalRecord.resuscitate,
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
              color: _implants || _implantsStatus(profile)
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
                            color: _implants || _implantsStatus(profile)
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
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .implants
                                                  .blocks
                                                  .removeAt(index);
                                              addBlockImpl.removeAt(index);
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
                                  update: profile.userGeneralInfo.update,
                                  index: index,
                                  type: 'Implants',
                                  diseace: userMedicalDiseacesImplants[index],
                                  title:
                                      userMedicalDiseacesImplants[index].label,
                                  desc: userMedicalDiseacesImplants[index]
                                      .description,
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
                                  addBlockDiseace: addBlockImpl,
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
                                          widget.profile.medicalRecord
                                              .medicalDiseaces.implants.blocks
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
                                                      nombrebolckImplant++;
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
                                                      Blocks implants = Blocks(
                                                          description: '',
                                                          label: '',
                                                          documents: [],
                                                          reminders: []);
                                                      userMedicalDiseacesImplants
                                                          .add(implants);
                                                      widget
                                                          .profile
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
                                              textColor:
                                                  ColorConstant.primaryColor,
                                              child: MyText(
                                                  value:
                                                      "editprofil_general_btn_delete"
                                                          .tr(),
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              color: _renalKidney || _RenalkendyStatus(profile)
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
                            color: _renalKidney || _RenalkendyStatus(profile)
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
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .renalKenedy
                                                  .blocks
                                                  .removeAt(index);
                                              addBlockRenal.removeAt(index);

                                              // medicalRecord.medicalDiseaces.allergies.removeAt(index);
                                              nombrebolckRenal =
                                                  userMedicalDiseacesRenal
                                                      .length;
                                              print(addBlockRenal);
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
                                  update: profile.userGeneralInfo.update,
                                  index: index,
                                  type: 'renalKenedy',
                                  diseace: userMedicalDiseacesRenal[index],
                                  title: userMedicalDiseacesRenal[index].label,
                                  desc: userMedicalDiseacesRenal[index]
                                      .description,
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
                                  addBlockDiseace: addBlockRenal,
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

                                          profile.medicalRecord.medicalDiseaces
                                              .renalKenedy.blocks
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
                                                    nombrebolckRenal++;
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

                                                    Blocks renal = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesRenal
                                                        .add(renal);

                                                    profile
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              color: cardiac || _CardiacStatus(profile)
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
                            color: cardiac || _CardiacStatus(profile)
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
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .cardiac
                                                  .blocks
                                                  .removeAt(index);
                                              addBlockCardiac.removeAt(index);
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
                                  update: profile.userGeneralInfo.update,
                                  index: index,
                                  type: 'cardiac',
                                  diseace: userMedicalDiseacesCardiac[index],
                                  title:
                                      userMedicalDiseacesCardiac[index].label,
                                  desc: userMedicalDiseacesCardiac[index]
                                      .description,
                                  attachment: userMedicalDiseacesCardiac[index]
                                              .documents
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  addBlockDiseace: addBlockCardiac,
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
                                          widget.profile.medicalRecord
                                              .medicalDiseaces.cardiac.blocks
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
                                                    nombrebolckCardiac++;
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
                                                    Blocks cardiac = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesCardiac
                                                        .add(cardiac);
                                                    widget
                                                        .profile
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
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              color: _psychiatric || _PsychiatricStatus(profile)
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
                            color: _psychiatric || _PsychiatricStatus(profile)
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
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .psychiatric
                                                  .blocks
                                                  .removeAt(index);
                                              addBlockPsy.removeAt(index);
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
                                  index: index,
                                  update: profile.userGeneralInfo.update,
                                  type: 'psychiatric',
                                  diseace:
                                      userMedicalDiseacesPsychiatric[index],
                                  title:
                                      userMedicalDiseacesPsychiatric[index]
                                          .label,
                                  desc:
                                      userMedicalDiseacesPsychiatric[index]
                                          .description,
                                  addBlockDiseace: addBlockPsy,
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
                                          nombrebolckPsychiatric++;
                                          addBlockPsy.add(true);
                                          Blocks psychiatric = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesPsychiatric
                                              .add(psychiatric);

                                          widget
                                              .profile
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

                                                    widget
                                                        .profile
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              color: _neurologic || _NeurologicStatus(profile)
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
                            color: _neurologic || _NeurologicStatus(profile)
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
                                              addBlockNeuro.removeAt(index);
                                              profile
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
                                  update: profile.userGeneralInfo.update,
                                  index: index,
                                  type: 'neuroligic',
                                  diseace: userMedicalDiseacesNeurologic[index],
                                  addBlockDiseace: addBlockNeuro,
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

                                          widget.profile.medicalRecord
                                              .medicalDiseaces.neuroligic.blocks
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
                                                    nombrebolckNeurologic++;
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
                                                    Blocks neuroligic = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesNeurologic
                                                        .add(neuroligic);

                                                    widget
                                                        .profile
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              color: _pulmonary || _PulmonaryStatus(profile)
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
                            color: _pulmonary || _PulmonaryStatus(profile)
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
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .plumonary
                                                  .blocks
                                                  .removeAt(index);
                                              addBlockPulmo.removeAt(index);
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
                                  update: profile.userGeneralInfo.update,
                                  index: index,
                                  type: 'plumonary',
                                  diseace: userMedicalDiseacesPlumonary[index],
                                  title:
                                      userMedicalDiseacesPlumonary[index].label,
                                  desc: userMedicalDiseacesPlumonary[index]
                                      .description,
                                  addBlockDiseace: addBlockPulmo,
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
                                          nombrebolckPulmonary++;
                                          addBlockPulmo.add(true);
                                          Blocks plumonary = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesPlumonary
                                              .add(plumonary);

                                          widget.profile.medicalRecord
                                              .medicalDiseaces.plumonary.blocks
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
                                                    nombrebolckPulmonary++;
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
                                                    Blocks plumonary = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesPlumonary
                                                        .add(plumonary);

                                                    widget
                                                        .profile
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              color: _medication || _MedicationStatus(profile)
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
                            color: _medication || _MedicationStatus(profile)
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
                                                  .medicalRecord
                                                  .medicalDiseaces
                                                  .medication
                                                  .blocks
                                                  .removeAt(index);
                                              addBlockMedica.removeAt(index);
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
                                  update: profile.userGeneralInfo.update,
                                  type: 'medication',
                                  diseace: userMedicalDiseacesMedication[index],
                                  title: userMedicalDiseacesMedication[index]
                                      .label,
                                  desc: userMedicalDiseacesMedication[index]
                                      .description,
                                  addBlockDiseace: addBlockMedica,
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

                                          widget.profile.medicalRecord
                                              .medicalDiseaces.medication.blocks
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
                                                    nombrebolckMedication++;
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
                                                    Blocks medication = Blocks(
                                                        description: '',
                                                        label: '',
                                                        documents: [],
                                                        reminders: []);
                                                    userMedicalDiseacesMedication
                                                        .add(medication);

                                                    widget
                                                        .profile
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              color: _cancer || _CancerStatus(profile)
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
                            color: _cancer || _CancerStatus(profile)
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
                                              addBlockCancer.removeAt(index);
                                              profile.medicalRecord
                                                  .medicalDiseaces.cancer.blocks
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
                                  update: profile.userGeneralInfo.update,
                                  type: 'cancer',
                                  addBlockDiseace: addBlockCancer,
                                  diseace: userMedicalDiseacesCancer[index],
                                  title: userMedicalDiseacesCancer[index].label,
                                  desc: userMedicalDiseacesCancer[index]
                                      .description,
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
                                          nombrebolckCancer++;
                                          addBlockCancer.add(true);
                                          Blocks cancer = Blocks(
                                              description: '',
                                              label: '',
                                              documents: [],
                                              reminders: []);
                                          userMedicalDiseacesCancer.add(cancer);

                                          widget.profile.medicalRecord
                                              .medicalDiseaces.cancer.blocks
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

                                                    widget
                                                        .profile
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
                                                textColor:
                                                    ColorConstant.pinkColor,
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              color: blood || _BoooldStatus(profile)
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
                            color: blood || _BoooldStatus(profile)
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
                                      profile.userGeneralInfo.update = true;

                                      profile.medicalRecord.bloodInfo
                                          .idBloodType = newVal['id'];
                                    });
                                  },
                                  isExpanded: true,
                                  value: bloodData,
                                  hint: profile.medicalRecord.bloodInfo
                                              .idBloodType !=
                                          null
                                      ? MyText(
                                          value: profile.parameters.bloodList[
                                              profile.medicalRecord.bloodInfo
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
                                            profile.userGeneralInfo.update =
                                                true;

                                            widget
                                                .profile
                                                .medicalRecord
                                                .bloodInfo
                                                .bloodSystolic = newVal;
                                            systolicData = newVal;
                                          });
                                        },
                                        isExpanded: true,
                                        value: systolicData,
                                        hint: MyText(
                                            value: profile.medicalRecord
                                                    .bloodInfo.bloodSystolic ??
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
                                            profile.userGeneralInfo.update =
                                                true;

                                            widget
                                                .profile
                                                .medicalRecord
                                                .bloodInfo
                                                .bloodDiastolic = newVal;
                                            diastolicData = newVal;
                                          });
                                        },
                                        isExpanded: true,
                                        value: diastolicData,
                                        hint: MyText(
                                            value: profile.medicalRecord
                                                    .bloodInfo.bloodDiastolic ??
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
                                                  userMedicalBloodDiabates
                                                      .removeAt(index);
                                                  profile.userGeneralInfo
                                                      .update = true;
                                                  profile.medicalRecord
                                                      .bloodInfo.diabates
                                                      .removeAt(index);
                                                  addBlockBlood.removeAt(index);
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
                                  addBlockBlood: addBlockBlood,
                                  update: profile.userGeneralInfo.update,

                                  index: index,
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
                                              public: 1,
                                              active: 1,
                                              diabeteDescription: '',
                                              diabeteLabel: '',
                                              documents: [],
                                              reminder: []);
                                          userMedicalBloodDiabates
                                              .add(diabates);
                                          profile
                                              .medicalRecord.bloodInfo.diabates
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
                                                                public: 1,
                                                                active: 1,
                                                                diabeteDescription:
                                                                    '',
                                                                diabeteLabel:
                                                                    '',
                                                                documents: [],
                                                                reminder: []);
                                                        userMedicalBloodDiabates
                                                            .add(diabates);
                                                        profile.medicalRecord
                                                            .bloodInfo.diabates
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
                                                textColor: Color(0xffEC1C40),
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              color: organDonor || _OrganDonarStatus(profile)
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
                            color: organDonor || _OrganDonarStatus(profile)
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                      // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
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
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.30)),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                ExpandableDonorView(
                                  profile: profile,
                                  update: profile.userGeneralInfo.update,
                                  index: index,
                                  // text: bloodController,
                                  donorinfo: profile.medicalRecord.organDonar,
                                  switchValue: true,
                                  attachment: profile.medicalRecord.organDonar
                                              .documents !=
                                          0
                                      ? true
                                      : false,
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
              color: other || _otherStatus(profile)
                  ? ColorConstant.primaryColor
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
                          color: other || _otherStatus(profile)
                              ? null
                              : ColorConstant.darkGray,
                        ) /**/
                        // child: Image.asset("Assets/Images/phone-no.png",height: 32,width: 32,),
                        ),
                    MyText(
                        value: "editprofil_medical_label_other".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: other || _otherStatus(profile)
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
                              .medicalRecord.otherMedicalRecordInfo.length,
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
                                                  profile.userGeneralInfo
                                                      .update = true;
                                                  addBlockOther.removeAt(index);
                                                  profile.medicalRecord
                                                      .otherMedicalRecordInfo
                                                      .removeAt(index);
                                                  nombrebolckOther = profile
                                                      .medicalRecord
                                                      .otherMedicalRecordInfo
                                                      .length;
                                                  if (profile
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
                                    update: profile.userGeneralInfo.update,
                                    other: profile.medicalRecord
                                        .otherMedicalRecordInfo[index],
                                    title: profile.medicalRecord
                                        .otherMedicalRecordInfo[index].label,
                                    desc: profile
                                        .medicalRecord
                                        .otherMedicalRecordInfo[index]
                                        .description,
                                    addBlockOther: addBlockOther,
                                    attachments: profile
                                        .medicalRecord
                                        .otherMedicalRecordInfo[index]
                                        .documents,
                                    reminders: profile.medicalRecord
                                        .otherMedicalRecordInfo[index].reminder,
                                    switchValue: widget
                                                .profile
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
                        profile.medicalRecord.otherMedicalRecordInfo.length == 0
                            ? MyButton(
                                title: "editprofil_general_btn_addnew".tr() +
                                    "editprofil_medical_label_other".tr(),
                                height: 36.0,
                                titleSize: 14,
                                fontWeight: FontWeight.w500,
                                titleColor: Color(0xffEC1C40),
                                btnBgColor: Colors.white,
                                onPressed: nombrebolckOther < nbblock
                                    ? () {
                                        setState(() {
                                          profile.userGeneralInfo.update = true;
                                          addBlockOther.add(true);
                                          nombrebolckOther++;
                                          OtherMedicalRecordInfo
                                              otherMedicalRecordInfo =
                                              OtherMedicalRecordInfo(
                                                  active: 1,
                                                  allow: 1,
                                                  description: "",
                                                  label: '',
                                                  documents: [],
                                                  reminder: []);
                                          profile.medicalRecord
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
                                                    profile.userGeneralInfo
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
                                                    setState(() {
                                                      nombrebolckOther++;
                                                      OtherMedicalRecordInfo
                                                          otherMedicalRecordInfo =
                                                          OtherMedicalRecordInfo(
                                                              allow: 1,
                                                              active: 1,
                                                              description: "",
                                                              label: '',
                                                              documents: [],
                                                              reminder: []);
                                                      profile.medicalRecord
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
                                              textColor:
                                                  ColorConstant.primaryColor,
                                              child: MyText(
                                                  value:
                                                      "editprofil_general_btn_delete"
                                                          .tr(),
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
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
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
  _ViewExport(Profile profile, Profile oldProfile) {
    return Column(
      children: <Widget>[
        Container(
            height: 49,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: ColorConstant.primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Container(
                height: 49,
                padding: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                  color: ColorConstant.separatedColor,
                ),
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
                    color: ColorConstant.pinkColor,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _scrollController.jumpTo(420);

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
                                  const EdgeInsets.only(left: 0, right: 21),
                              child: SvgPicture.asset(
                                'Assets/Images/viewExport.svg',
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
                        _generalAndMedical(profile, oldProfile),
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

  static showOverlayUpdate(BuildContext context, String headerMessage,
      String message, Profile newProfile, int index, Profile profile) {
    Navigator.of(context)
        .push(AlertDialogueUpdate(headerMessage, message, index, profile));
  }

  _generalAndMedical(Profile profile, Profile oldProfile) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                if (profile.userGeneralInfo.update == false) {
                  dispatchViewProfile(profile);
                } else {
                  showOverlayUpdate(
                      context,
                      "messages_label_confirmationleave".tr(),
                      "messages_label_confirmationdesc".tr(),
                      profile,
                      1,
                      oldProfile);
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
                  // _printRecord = !_printRecord;PublicPopup;PrintPopup
                  Navigator.of(context).push(PrintPopup(profile));
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
                  //  _emailRecord = !_emailRecord;
                });
                Navigator.of(context).push(SendPopup(profile));
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
                      color: ColorConstant.textColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dispatchEditProfile(Profile profile) {
    profile.parameters.location = 'profile';
    BlocProvider.of<ProfileBloc>(context).dispatch(
      EditProfileEvent(
        profile: profile,
      ),
    );
  }

  void dispatchDeleteProfile(Profile profile) {}

  void dispatchViewProfile(Profile profile) {
    BlocProvider.of<ProfileBloc>(context).dispatch(
      GoToViewProfileEvent(
        profile: profile,
      ),
    );
  }

  void dispatchGoToHelp(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/helpProvider',
      arguments: profile,
    );
  }

  void dispatchGoToHome(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/homeProvider',
      arguments: profile,
    );
  }

  bool _GenerlInfoStatus(Profile profile) {
    if ((profile.userGeneralInfo.mail == null ||
            profile.userGeneralInfo.mail == "") &&
        (profile.userGeneralInfo.mail2 == null ||
            profile.userGeneralInfo.mail2 == "") &&
        (profile.userGeneralInfo.mobile == null ||
            profile.userGeneralInfo.mobile == "") &&
        (profile.userGeneralInfo.codePhone == null ||
            profile.userGeneralInfo.codePhone == "") &&
        (profile.userGeneralInfo.preferenceUser.allowShareEmails.value ==
            "0") &&
        (profile.userGeneralInfo.preferenceUser.includeMobile.value == "0") &&
        (profile.userGeneralInfo.preferenceUser.allowSharePicture.value ==
            "0") &&
        (profile.userGeneralInfo.preferenceUser.allowShareName.value == "0")) {
      return false;
    }
    return true;
  }

  bool _alsoInfoStatus(Profile profile) {
    bool ok = false;
    for (int i = 0;
        i < profile.userGeneralInfo.userEmergencyContact.length;
        i++) {
      if ((profile.userGeneralInfo.userEmergencyContact[i].firstName != "" &&
              profile.userGeneralInfo.userEmergencyContact[i].firstName !=
                  null) ||
          (profile.userGeneralInfo.userEmergencyContact[i].mail != "" &&
              profile.userGeneralInfo.userEmergencyContact[i].mail != null)) {
        ok = true;
      }
    }
    if (profile.userGeneralInfo.userEmergencyContact.length != 0 && ok) {
      return true;
    }

    return false;
  }

  bool _FamilyMmebreStatus(Profile profile) {
    if (profile.userGeneralInfo.subUsers.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool _ThankYouStatus(Profile profile) {
    if (profile.userGeneralInfo.custumMessage == null ||
        profile.userGeneralInfo.custumMessage == "") {
      return false;
    }
    return true;
  }

  bool _InsuranceInformationStatus(Profile profile) {
    bool ok = false;
    for (int i = 0; i < profile.medicalRecord.insuranceInfo.length; i++) {
      if ((profile.medicalRecord.insuranceInfo[i].insuranceCampanyName !=
                  null &&
              profile.medicalRecord.insuranceInfo[i].insuranceCampanyName !=
                  "") ||
          (profile.medicalRecord.insuranceInfo[i].additionalInformations !=
                  null &&
              profile.medicalRecord.insuranceInfo[i].additionalInformations !=
                  "")) {
        ok = true;
      }
    }
    if (profile.medicalRecord.insuranceInfo.length != 0 && ok) {
      return true;
    }
    return false;
  }

  bool _WeightHeightStatus(Profile profile) {
    if ((profile.medicalRecord.heightweight.heightFt != 0 &&
            profile.medicalRecord.heightweight.heightFt != null) ||
        (profile.medicalRecord.heightweight.heightInch != 0 &&
            profile.medicalRecord.heightweight.heightInch != null) ||
        (profile.medicalRecord.heightweight.heightCm != 0 &&
            profile.medicalRecord.heightweight.heightCm != null) ||
        (profile.medicalRecord.heightweight.weightLbs != 0 &&
            profile.medicalRecord.heightweight.weightLbs != null) ||
        (profile.medicalRecord.heightweight.weightKg != 0 &&
            profile.medicalRecord.heightweight.weightKg != null)) {
      return true;
    }
    return false;
  }

  bool _LanguageSpookenStatus(Profile profile) {
    if (profile.medicalRecord.spokenLanguages != null &&
        profile.medicalRecord.spokenLanguages != "") {
      return true;
    }
    return false;
  }

  bool _EyeColorStatus(Profile profile) {
    if (profile.medicalRecord.idEyeColor != null) {
      return true;
    }
    return false;
  }

  bool _DistinctiveSigneStatus(Profile profile) {
    if (profile.medicalRecord.distitnctSign != null &&
        profile.medicalRecord.distitnctSign != "") {
      return true;
    }
    return false;
  }

  bool _MaritalStatusStatus(Profile profile) {
    if (profile.medicalRecord.idMaritalStatus != null) {
      return true;
    }
    return false;
  }

  bool _GenderStatus(Profile profile) {
    if (profile.medicalRecord.idGender != null) {
      return true;
    }
    return false;
  }

  bool _ReligionStatus(Profile profile) {
    if (profile.medicalRecord.religionLabel != null &&
        profile.medicalRecord.religionLabel != "") {
      return true;
    }
    return false;
  }

  bool _PetStatus(Profile profile) {
    if (profile.medicalRecord.petAtHome != null &&
        profile.medicalRecord.petAtHome != "") {
      return true;
    }
    return false;
  }

  bool _MiscelaneousStatus(Profile profile) {
    bool ok = false;
    for (int i = 0; i < profile.medicalRecord.miscilanious.length; i++) {
      if ((profile.medicalRecord.miscilanious[i].label != null &&
              profile.medicalRecord.miscilanious[i].label != "") ||
          (profile.medicalRecord.miscilanious[i].description != null &&
              profile.medicalRecord.miscilanious[i].description != "")) {
        ok = true;
      }
    }
    if (profile.medicalRecord.miscilanious.length != 0 && ok) {
      return true;
    }
    return false;
  }

  bool _birthdayStatus(Profile profile) {
    if (profile.userGeneralInfo.birthInfo.day != null ||
        profile.userGeneralInfo.birthInfo.year != null ||
        profile.userGeneralInfo.birthInfo.month != null) {
      return true;
    }
    return false;
  }

  bool _PersonalInformationStatus(Profile profile) {
    if (_MiscelaneousStatus(profile) ||
        _PetStatus(profile) ||
        _ReligionStatus(profile) ||
        _GenderStatus(profile) ||
        _MaritalStatusStatus(profile) ||
        _DistinctiveSigneStatus(profile) ||
        _EyeColorStatus(profile) ||
        _LanguageSpookenStatus(profile) ||
        _WeightHeightStatus(profile) ||
        _InsuranceInformationStatus(profile) ||
        _birthdayStatus(profile)) {
      return true;
    }
    return false;
  }

  bool _EmergencyContactsStatus(Profile profile) {
    bool ok = false;
    for (int i = 0;
        i < profile.medicalRecord.userEmergencyContact.length;
        i++) {
      if ((profile.medicalRecord.userEmergencyContact[i].firstName != "" &&
              profile.medicalRecord.userEmergencyContact[i].firstName !=
                  null) ||
          (profile.medicalRecord.userEmergencyContact[i].mail != "" &&
              profile.medicalRecord.userEmergencyContact[i].mail != null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.userEmergencyContact.length != 0 && ok) {
      return true;
    }

    return false;
  }

  bool _medicalTagStatus(Profile profile) {
    if (widget.profile.userGeneralInfo.userTags.medicalTag.length != 0) {
      return true;
    }

    return false;
  }

  bool _PhysicianContactsStatus(Profile profile) {
    bool ok = false;
    for (int i = 0; i < profile.medicalRecord.physicianContact.length; i++) {
      if ((profile.medicalRecord.physicianContact[i].lastName != "" &&
              profile.medicalRecord.physicianContact[i].lastName != null) ||
          (profile.medicalRecord.physicianContact[i].mail != "" &&
              profile.medicalRecord.physicianContact[i].mail != null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.physicianContact.length != 0 && ok) {
      return true;
    }

    return false;
  }

  bool _EmgInfoStatus(Profile profile) {
    if (_PhysicianContactsStatus(profile) ||
        _EmergencyContactsStatus(profile)) {
      return true;
    }
    return false;
  }

  bool _BoooldStatus(Profile profile) {
    if (profile.medicalRecord.bloodInfo.idBloodType != null ||
        profile.medicalRecord.bloodInfo.bloodSystolic != null ||
        profile.medicalRecord.bloodInfo.bloodDiastolic != null) {
      return true;
    }
    return false;
  }

  bool _CancerStatus(Profile profile) {
    bool ok = false;
    for (int i = 0;
        i < profile.medicalRecord.medicalDiseaces.cancer.blocks.length;
        i++) {
      if ((profile.medicalRecord.medicalDiseaces.cancer.blocks[i].label != "" &&
              profile.medicalRecord.medicalDiseaces.cancer.blocks[i].label !=
                  null) ||
          (profile.medicalRecord.medicalDiseaces.cancer.blocks[i].description !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.cancer.blocks[i]
                      .description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.medicalDiseaces.cancer.blocks.isNotEmpty && ok) {
      return true;
    }
    return false;
  }

  bool _MedicationStatus(Profile profile) {
    bool ok = false;
    for (int i = 0;
        i < profile.medicalRecord.medicalDiseaces.medication.blocks.length;
        i++) {
      if ((profile.medicalRecord.medicalDiseaces.medication.blocks[i].label !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.medication.blocks[i]
                      .label !=
                  null) ||
          (profile.medicalRecord.medicalDiseaces.medication.blocks[i]
                      .description !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.medication.blocks[i]
                      .description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.medicalDiseaces.medication.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _PulmonaryStatus(Profile profile) {
    bool ok = false;
    for (int i = 0;
        i < profile.medicalRecord.medicalDiseaces.plumonary.blocks.length;
        i++) {
      if ((profile.medicalRecord.medicalDiseaces.plumonary.blocks[i].label !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.plumonary.blocks[i].label !=
                  null) ||
          (profile.medicalRecord.medicalDiseaces.plumonary.blocks[i]
                      .description !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.plumonary.blocks[i]
                      .description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.medicalDiseaces.plumonary.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _NeurologicStatus(Profile profile) {
    bool ok = false;
    for (int i = 0;
        i < profile.medicalRecord.medicalDiseaces.neuroligic.blocks.length;
        i++) {
      if ((profile.medicalRecord.medicalDiseaces.neuroligic.blocks[i].label !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.neuroligic.blocks[i]
                      .label !=
                  null) ||
          (profile.medicalRecord.medicalDiseaces.neuroligic.blocks[i]
                      .description !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.neuroligic.blocks[i]
                      .description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.medicalDiseaces.neuroligic.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _PsychiatricStatus(Profile profile) {
    bool ok = false;
    for (int i = 0;
        i < profile.medicalRecord.medicalDiseaces.psychiatric.blocks.length;
        i++) {
      if ((profile.medicalRecord.medicalDiseaces.psychiatric.blocks[i].label !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.psychiatric.blocks[i]
                      .label !=
                  null) ||
          (profile.medicalRecord.medicalDiseaces.psychiatric.blocks[i]
                      .description !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.psychiatric.blocks[i]
                      .description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.medicalDiseaces.psychiatric.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _CardiacStatus(Profile profile) {
    bool ok = false;
    for (int i = 0;
        i < profile.medicalRecord.medicalDiseaces.cardiac.blocks.length;
        i++) {
      if ((profile.medicalRecord.medicalDiseaces.cardiac.blocks[i].label !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.cardiac.blocks[i].label !=
                  null) ||
          (profile.medicalRecord.medicalDiseaces.cardiac.blocks[i]
                      .description !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.cardiac.blocks[i]
                      .description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.medicalDiseaces.cardiac.blocks.isNotEmpty && ok) {
      return true;
    }
    return false;
  }

  bool _RenalkendyStatus(Profile profile) {
    bool ok = false;
    for (int i = 0;
        i < profile.medicalRecord.medicalDiseaces.renalKenedy.blocks.length;
        i++) {
      if ((profile.medicalRecord.medicalDiseaces.renalKenedy.blocks[i].label !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.renalKenedy.blocks[i]
                      .label !=
                  null) ||
          (profile.medicalRecord.medicalDiseaces.renalKenedy.blocks[i]
                      .description !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.renalKenedy.blocks[i]
                      .description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.medicalDiseaces.renalKenedy.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _implantsStatus(Profile profile) {
    bool ok = false;
    for (int i = 0;
        i < profile.medicalRecord.medicalDiseaces.implants.blocks.length;
        i++) {
      if ((profile.medicalRecord.medicalDiseaces.implants.blocks[i].label !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.implants.blocks[i].label !=
                  null) ||
          (profile.medicalRecord.medicalDiseaces.implants.blocks[i]
                      .description !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.implants.blocks[i]
                      .description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.medicalDiseaces.implants.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _allergiesStatus(Profile profile) {
    bool ok = false;

    for (int i = 0;
        i < profile.medicalRecord.medicalDiseaces.allergies.blocks.length;
        i++) {
      if ((profile.medicalRecord.medicalDiseaces.allergies.blocks[i].label !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.allergies.blocks[i].label !=
                  null) ||
          (profile.medicalRecord.medicalDiseaces.allergies.blocks[i]
                      .description !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.allergies.blocks[i]
                      .description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.medicalDiseaces.allergies.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _infectionDisacesStatus(Profile profile) {
    bool ok = false;

    for (int i = 0;
        i <
            profile
                .medicalRecord.medicalDiseaces.infectionDisaces.blocks.length;
        i++) {
      if ((profile.medicalRecord.medicalDiseaces.infectionDisaces.blocks[i]
                      .label !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.infectionDisaces.blocks[i]
                      .label !=
                  null) ||
          (profile.medicalRecord.medicalDiseaces.infectionDisaces.blocks[i]
                      .description !=
                  "" &&
              profile.medicalRecord.medicalDiseaces.infectionDisaces.blocks[i]
                      .description !=
                  null)) {
        ok = true;
      }
    }
    if (profile
            .medicalRecord.medicalDiseaces.infectionDisaces.blocks.isNotEmpty &&
        ok) {
      return true;
    }
    return false;
  }

  bool _OrganDonarStatus(Profile profile) {
    if (profile.medicalRecord.organDonar.donar != 0 &&
        profile.medicalRecord.organDonar.donar != null) {
      return true;
    }
    return false;
  }

  bool _DnrStatus(Profile profile) {
    if (profile.medicalRecord.resuscitate.allow != 0 &&
        profile.medicalRecord.resuscitate.allow != null) {
      return true;
    }
    return false;
  }

  bool _otherStatus(Profile profile) {
    bool ok = false;

    for (int i = 0;
        i < profile.medicalRecord.otherMedicalRecordInfo.length;
        i++) {
      if ((profile.medicalRecord.otherMedicalRecordInfo[i].label != "" &&
              profile.medicalRecord.otherMedicalRecordInfo[i].label != null) ||
          (profile.medicalRecord.otherMedicalRecordInfo[i].description != "" &&
              profile.medicalRecord.otherMedicalRecordInfo[i].description !=
                  null)) {
        ok = true;
      }
    }
    if (profile.medicalRecord.otherMedicalRecordInfo.isNotEmpty && ok) {
      return true;
    }
    return false;
  }

  bool _MedicalInformationStatus(Profile profile) {
    if (_otherStatus(profile) ||
        _DnrStatus(profile) ||
        _OrganDonarStatus(profile) ||
        _infectionDisacesStatus(profile) ||
        _allergiesStatus(profile) ||
        _implantsStatus(profile) ||
        _RenalkendyStatus(profile) ||
        _CardiacStatus(profile) ||
        _PsychiatricStatus(profile) ||
        _NeurologicStatus(profile) ||
        _PulmonaryStatus(profile) ||
        _MedicationStatus(profile) ||
        _CancerStatus(profile) ||
        _BoooldStatus(profile)) {
      return true;
    }
    return false;
  }
}
