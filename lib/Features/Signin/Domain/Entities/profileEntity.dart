import 'dart:io';
import 'package:neopolis/Features/Messages/Domain/Entities/message.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile {
  UserGeneralInfo userGeneralInfo;
  MedicalRecord medicalRecord;
  Parameters parameters;

  Profile({this.userGeneralInfo, this.medicalRecord, this.parameters});

  Profile.fromJson(Map<String, dynamic> json) {
    userGeneralInfo = json['user_general_info'] != null
        ? new UserGeneralInfo.fromJson(json['user_general_info'])
        : null;

    medicalRecord = json['medical_record'] != null
        ? new MedicalRecord.fromJson(json['medical_record'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.userGeneralInfo != null) {
      data['user_general_info'] = this.userGeneralInfo.toJson();
    }

    if (this.medicalRecord != null) {
      data['medical_record'] = this.medicalRecord.toJson();
    }

    return data;
  }
}

class Parameters {
  List<Map<String, dynamic>> eyeColorList;
  List<Map<String, dynamic>> bloodList;
  List<Map<String, dynamic>> genderList;
  List<Map<String, dynamic>> materialStatusList;
  List<Map<String, dynamic>> tagTypesList;
  List<Map<String, dynamic>> roleUser;
  List<Map<String, dynamic>> petTypesList;
  List<Map<String, dynamic>> themeColor;

  String viewTag;
  int filterType;
  String filterDescriptionSn;
  String filterIdMembre;
  Map<String, dynamic> faq;
  File file;
  String fileUrl;
  String location;
  int locationIndex;
  Map<String, dynamic> homeParameters;
  List<String> discussionMails;
  Discussions discussions;
  String discussionName;
  SpecificDiscussion specificDiscussion;
  SpecificMessage specificMessage;
  bool done;
  String serial;
  List<dynamic> result;
  bool statuscheck;
  String typecheck;
  int indexu;
  int indext;
  bool newPet;
  bool newUser;
  Map<String, dynamic> locales;

  Parameters({
    this.eyeColorList,
    this.bloodList,
    this.genderList,
    this.materialStatusList,
    this.faq,
    this.file,
    this.fileUrl,
    this.locationIndex,
    this.roleUser,
    this.petTypesList,
    this.homeParameters,
    this.discussions,
    this.viewTag,
    this.discussionMails,
    this.specificDiscussion,
    this.serial,
    this.result,
    this.themeColor,
    this.statuscheck,
    this.typecheck,
    this.indexu,
    this.indext,
    this.newPet,
    this.newUser,
    this.locales,
  });
}

class UserGeneralInfo {
  bool update;
  String color;
  String duplicate;
  String switchTag;
  int currentColor;
  String sn;
  GoogleSignIn googleSign;
  FacebookLogin facebookSignIn;
  String masterTag;
  String idUser;
  String idSubUser;
  String idSession;
  String message;
  String type;
  String idMember;
  int active;
  Address address;
  String birthDate;
  String currencyLabel;
  String custumMessage;
  String expirePassword;
  String firstName;
  String lastName;
  String lastUpdatePwd;
  String mail;
  String mail2;
  String mobile;
  String mobile2;
  String codePhone;
  int idCodePhone;
  PreferenceUser preferenceUser;
  String profilePictureUrl;
  int idProfilePicture;
  String reward;
  String religion;
  int role;
  String roleLabel;
  String tel;
  String tel2;
  List<UserEmergencyContact> userEmergencyContact;
  String userIdLanguage;
  List<Profile> subUsers;
  List<dynamic> linkedMedicalRecord;
  String gender;
  UserTags userTags;
  Currency currency;
  List<PetsInfos> petsInfos;
  RemindersList remindersList;
  TagsList tagsList;
  NewTags newTags;
  ZulipAcces zulipAcces;
  Notifications notificationlist;
  BirthDateInfo birthInfo;

  UserGeneralInfo({
    this.googleSign,
    this.facebookSignIn,
    this.color,
    this.update,
    this.idUser,
    this.duplicate,
    this.switchTag,
    this.sn,
    this.currentColor,
    this.masterTag,
    this.idSubUser,
    this.idSession,
    this.message,
    this.type,
    this.birthInfo,
    this.idMember,
    this.religion,
    this.active,
    this.address,
    this.birthDate,
    this.currencyLabel,
    this.idProfilePicture,
    this.custumMessage,
    this.expirePassword,
    this.firstName,
    this.lastName,
    this.lastUpdatePwd,
    this.mail,
    this.mail2,
    this.mobile,
    this.mobile2,
    this.codePhone,
    this.idCodePhone,
    this.preferenceUser,
    this.profilePictureUrl,
    this.reward,
    this.role,
    this.roleLabel,
    this.tel,
    this.tel2,
    this.userEmergencyContact,
    this.userIdLanguage,
    this.subUsers,
    this.linkedMedicalRecord,
    this.gender,
    this.userTags,
    this.currency,
    this.petsInfos,
    this.remindersList,
    this.tagsList,
    this.newTags,
    this.zulipAcces,
    this.notificationlist,
  });

  UserGeneralInfo.fromJson(Map<String, dynamic> json) {
    idProfilePicture = json['id_picture_profile'];
    message = json['message'];
    idSubUser = json['id'];
    currentColor = json['id_theme_color'];
    active = json['active'];
    idMember = json['id_member'];
    birthInfo = json['birth_date_info'] != null
        ? new BirthDateInfo.fromJson(json['birth_date_info'])
        : null;

    birthInfo = json['birth_date_info'] != null
        ? new BirthDateInfo.fromJson(json['birth_date_info'])
        : null;

    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    birthDate = json['birth_date'];
    currencyLabel = json['currency_label'];
    custumMessage = json['custum_message'];
    expirePassword = json['expire_password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    lastUpdatePwd = json['last_update_pwd'];
    mail = json['mail'];
    mail2 = json['mail2'];
    mobile = json['mobile'];
    mobile2 = json['mobile2'];
    codePhone = json['code_phone'];
    idCodePhone = json['id_phone_code'];
    religion = json['religion_label'];

    preferenceUser = json['preference_user'] != null
        ? new PreferenceUser.fromJson(json['preference_user'])
        : null;
    profilePictureUrl = json['profile_picture_url'];
    reward = json['reward'];
    role = json['role'];
    roleLabel = json['role_label'];
    tel = json['tel'];
    tel2 = json['tel2'];
    if (json['user_emergency_contact'] != null) {
      userEmergencyContact = new List<UserEmergencyContact>();
      json['user_emergency_contact'].forEach((v) {
        userEmergencyContact.add(new UserEmergencyContact.fromJson(v));
      });
    }
    userIdLanguage = json['user_id_language'];
    if (json['sub_users'] != null) {
      subUsers = new List<Profile>();
      json['sub_users'].forEach((v) {
        subUsers.add(new Profile.fromJson(v));
      });
    }
    linkedMedicalRecord = json['linked_medical_record'];
    gender = json['gender'];
    userTags = json['user_tags'] != null
        ? new UserTags.fromJson(json['user_tags'])
        : null;
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    if (json['pets_infos'] != null) {
      petsInfos = new List<PetsInfos>();
      json['pets_infos'].forEach((v) {
        petsInfos.add(new PetsInfos.fromJson(v));
      });
    }
    zulipAcces = json['zulip_acces'] != null
        ? new ZulipAcces.fromJson(json['zulip_acces'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['religion_label'] = this.religion;
    data['id_picture_profile'] = this.idProfilePicture;
    data['id'] = this.idSubUser;
    data['id_theme_color'] = this.currentColor;
    data['active'] = this.active;
    data['id_member'] = this.idMember;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.birthInfo != null) {
      data['birth_date_info'] = this.birthInfo.toJson();
    }

    data['birth_date'] = this.birthDate;
    data['currency_label'] = this.currencyLabel;
    data['custum_message'] = this.custumMessage;
    data['expire_password'] = this.expirePassword;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['last_update_pwd'] = this.lastUpdatePwd;
    data['mail'] = this.mail;
    data['mail2'] = this.mail2;
    data['mobile'] = this.mobile;
    data['mobile2'] = this.mobile2;
    data['code_phone'] = this.codePhone;
    data['id_phone_code'] = this.idCodePhone;
    if (this.preferenceUser != null) {
      data['preference_user'] = this.preferenceUser.toJson();
    }
    data['profile_picture_url'] = this.profilePictureUrl;
    data['reward'] = this.reward;
    data['role'] = this.role;
    data['role_label'] = this.roleLabel;
    data['tel'] = this.tel;
    data['tel2'] = this.tel2;
    if (this.userEmergencyContact != null) {
      data['user_emergency_contact'] =
          this.userEmergencyContact.map((v) => v.toJson()).toList();
    }
    data['user_id_language'] = this.userIdLanguage;
    if (this.subUsers != null) {
      data['sub_users'] = this.subUsers.map((v) => v.toJson()).toList();
    }
    data['linked_medical_record'] = this.linkedMedicalRecord;
    data['gender'] = this.gender;
    if (this.userTags != null) {
      data['user_tags'] = this.userTags.toJson();
    }
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    if (this.petsInfos != null) {
      data['pets_infos'] = this.petsInfos.map((v) => v.toJson()).toList();
    }
    if (this.zulipAcces != null) {
      data['zulip_acces'] = this.zulipAcces.toJson();
    }
    return data;
  }
}

class Address {
  String additionalAdress;
  String countryLabel;
  String cp;
  String depName;
  String geom;
  String latt;
  String lng;
  String regionName;
  String stateLabel;
  String streetName;

  Address(
      {this.additionalAdress,
      this.countryLabel,
      this.cp,
      this.depName,
      this.geom,
      this.latt,
      this.lng,
      this.regionName,
      this.stateLabel,
      this.streetName});

  Address.fromJson(Map<String, dynamic> json) {
    additionalAdress = json['additional_adress'];
    countryLabel = json['country_label'];
    cp = json['cp'];
    depName = json['dep_name'];
    geom = json['geom'];
    latt = json['latt'];
    lng = json['lng'];
    regionName = json['region_name'];
    stateLabel = json['state_label'];
    streetName = json['street_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['additional_adress'] = this.additionalAdress;
    data['country_label'] = this.countryLabel;
    data['cp'] = this.cp;
    data['dep_name'] = this.depName;
    data['geom'] = this.geom;
    data['latt'] = this.latt;
    data['lng'] = this.lng;
    data['region_name'] = this.regionName;
    data['state_label'] = this.stateLabel;
    data['street_name'] = this.streetName;
    return data;
  }
}

class Allow {
  String accesLabelTxt;
  int active;
  String classAndroid;
  String classIos;
  String classWeb;
  int idField;
  String idFieldApp;
  int idFieldModel;
  int idFieldType;
  int idForm;
  String serialization;
  String typeField;
  String value;

  Allow(
      {this.accesLabelTxt,
      this.active,
      this.classAndroid,
      this.classIos,
      this.classWeb,
      this.idField,
      this.idFieldApp,
      this.idFieldModel,
      this.idFieldType,
      this.idForm,
      this.serialization,
      this.typeField,
      this.value});

  Allow.fromJson(Map<String, dynamic> json) {
    accesLabelTxt = json['acces_label_txt'];
    active = json['active'];
    classAndroid = json['class_android'];
    classIos = json['class_ios'];
    classWeb = json['class_web'];
    idField = json['id_field'];
    idFieldApp = json['id_field_app'];
    idFieldModel = json['id_field_model'];
    idFieldType = json['id_field_type'];
    idForm = json['id_form'];
    serialization = json['serialization'];
    typeField = json['type_field'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acces_label_txt'] = this.accesLabelTxt;
    data['active'] = this.active;
    data['class_android'] = this.classAndroid;
    data['class_ios'] = this.classIos;
    data['class_web'] = this.classWeb;
    data['id_field'] = this.idField;
    data['id_field_app'] = this.idFieldApp;
    data['id_field_model'] = this.idFieldModel;
    data['id_field_type'] = this.idFieldType;
    data['id_form'] = this.idForm;
    data['serialization'] = this.serialization;
    data['type_field'] = this.typeField;
    data['value'] = this.value;
    return data;
  }
}

class UserEmergencyContact {
  int active;
  int allowChat;
  int allowMail1;
  int allowMail2;
  int allowMobile;
  String codePhone;
  String codePhoneCountry;
  String firstName;
  int id;
  String lastName;
  String mail;
  String mail2;
  String md5IdEmergencyContact;
  String mobile;
  String relation;
  String tel;
  int idRelation;
  int idPhoneCode;

  UserEmergencyContact(
      {this.active,
      this.allowChat,
      this.allowMail1,
      this.allowMail2,
      this.allowMobile,
      this.codePhone,
      this.codePhoneCountry,
      this.firstName,
      this.id,
      this.lastName,
      this.mail,
      this.mail2,
      this.md5IdEmergencyContact,
      this.mobile,
      this.relation,
      this.idRelation,
      this.tel,
      this.idPhoneCode});

  UserEmergencyContact.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    allowChat = json['allow__chat'];
    allowMail1 = json['allow_mail1'];
    allowMail2 = json['allow_mail2'];
    allowMobile = json['allow_mobile'];
    codePhone = json['code_phone'];
    codePhoneCountry = json['code_phone_country'];
    firstName = json['first_name'];
    id = json['id'];
    idRelation = json['id_relation'];
    lastName = json['last_name'];
    mail = json['mail'];
    mail2 = json['mail2'];
    md5IdEmergencyContact = json['md5_id_emergency_contact'];
    mobile = json['mobile'];
    relation = json['relation'];
    tel = json['tel'];
    idPhoneCode = json['id_phone_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['allow__chat'] = this.allowChat;
    data['allow_mail1'] = this.allowMail1;
    data['allow_mail2'] = this.allowMail2;
    data['allow_mobile'] = this.allowMobile;
    data['code_phone'] = this.codePhone;
    data['code_phone_country'] = this.codePhoneCountry;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['last_name'] = this.lastName;
    data['mail'] = this.mail;
    data['mail2'] = this.mail2;
    data['md5_id_emergency_contact'] = this.md5IdEmergencyContact;
    data['mobile'] = this.mobile;
    data['relation'] = this.relation;
    data['id_relation'] = this.idRelation;
    data['tel'] = this.tel;
    return data;
  }
}

class UserTags {
  List<MedicalTag> medicalTag;
  List<ObjectTag> objectTag;
  List<PetTag> petTag;

  UserTags({this.medicalTag, this.objectTag, this.petTag});

  UserTags.fromJson(Map<String, dynamic> json) {
    if (json['medical_tag'] != null) {
      medicalTag = new List<MedicalTag>();
      json['medical_tag'].forEach((v) {
        medicalTag.add(new MedicalTag.fromJson(v));
      });
    }
    if (json['object_tag'] != null) {
      objectTag = new List<ObjectTag>();
      json['object_tag'].forEach((v) {
        objectTag.add(new ObjectTag.fromJson(v));
      });
    }
    if (json['pet_tag'] != null) {
      petTag = new List<PetTag>();
      json['pet_tag'].forEach((v) {
        petTag.add(new PetTag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicalTag != null) {
      data['medical_tag'] = this.medicalTag.map((v) => v.toJson()).toList();
    }
    if (this.objectTag != null) {
      data['object_tag'] = this.objectTag.map((v) => v.toJson()).toList();
    }
    // if (this.petTag != null) {
    //   data['pet_tag'] = this.petTag.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class MedicalTag {
  Currency currency;
  List<UserEmergencyContact> emergencyContactUser;
  List<OtherInfo> otherInfo;
  PreferenceUser preferenceUser;
  TagInfo tagInfo;
  TagUserInfo tagUserInfo;

  MedicalTag({
    this.currency,
    this.emergencyContactUser,
    this.otherInfo,
    this.preferenceUser,
    this.tagInfo,
    this.tagUserInfo,
  });

  MedicalTag.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    if (json['emergency_contact_user'] != null) {
      emergencyContactUser = new List<UserEmergencyContact>();
      json['emergency_contact_user'].forEach((v) {
        emergencyContactUser.add(new UserEmergencyContact.fromJson(v));
      });
    }
    if (json['other_info'] != null) {
      otherInfo = new List<OtherInfo>();
      json['other_info'].forEach((v) {
        otherInfo.add(new OtherInfo.fromJson(v));
      });
    }
    preferenceUser = json['preference_user'] != null
        ? new PreferenceUser.fromJson(json['preference_user'])
        : null;
    tagInfo = json['tag_info'] != null
        ? new TagInfo.fromJson(json['tag_info'])
        : null;

    tagUserInfo = json['tag_user_info'] != null
        ? new TagUserInfo.fromJson(json['tag_user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    if (this.emergencyContactUser != null) {
      data['emergency_contact_user'] =
          this.emergencyContactUser.map((v) => v.toJson()).toList();
    }
    if (this.otherInfo != null) {
      data['other_info'] = this.otherInfo.map((v) => v.toJson()).toList();
    }
    if (this.preferenceUser != null) {
      data['preference_user'] = this.preferenceUser.toJson();
    }
    if (this.tagInfo != null) {
      data['tag_info'] = this.tagInfo.toJson();
    }
    if (this.tagUserInfo != null) {
      data['tag_user_info'] = this.tagUserInfo.toJson();
    }

    return data;
  }
}

class ObjectTag {
  Currency currency;
  List<UserEmergencyContact> emergencyContactUser;
  List<OtherInfo> otherInfo;
  PreferenceUser preferenceUser;
  TagInfo tagInfo;
  TagUserInfo tagUserInfo;

  ObjectTag({
    this.currency,
    this.emergencyContactUser,
    this.otherInfo,
    this.preferenceUser,
    this.tagInfo,
    this.tagUserInfo,
  });

  ObjectTag.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    if (json['emergency_contact_user'] != null) {
      emergencyContactUser = new List<UserEmergencyContact>();
      json['emergency_contact_user'].forEach((v) {
        emergencyContactUser.add(new UserEmergencyContact.fromJson(v));
      });
    }
    if (json['other_info'] != null) {
      otherInfo = new List<OtherInfo>();
      json['other_info'].forEach((v) {
        otherInfo.add(new OtherInfo.fromJson(v));
      });
    }
    preferenceUser = json['preference_user'] != null
        ? new PreferenceUser.fromJson(json['preference_user'])
        : null;
    tagInfo = json['tag_info'] != null
        ? new TagInfo.fromJson(json['tag_info'])
        : null;

    tagUserInfo = json['tag_user_info'] != null
        ? new TagUserInfo.fromJson(json['tag_user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    if (this.emergencyContactUser != null) {
      data['emergency_contact_user'] =
          this.emergencyContactUser.map((v) => v.toJson()).toList();
    }
    if (this.otherInfo != null) {
      data['other_info'] = this.otherInfo.map((v) => v.toJson()).toList();
    }
    if (this.preferenceUser != null) {
      data['preference_user'] = this.preferenceUser.toJson();
    }
    if (this.tagInfo != null) {
      data['tag_info'] = this.tagInfo.toJson();
    }
    if (this.tagUserInfo != null) {
      data['tag_user_info'] = this.tagUserInfo.toJson();
    }

    return data;
  }
}

class PetTag {
  Currency currency;
  List<UserEmergencyContact> emergencyContactUser;
  List<OtherInfo> otherInfo;
  PreferenceUser preferenceUser;
  TagInfo tagInfo;
  TagUserInfo tagUserInfo;

  PetTag({
    this.currency,
    this.emergencyContactUser,
    this.otherInfo,
    this.preferenceUser,
    this.tagInfo,
    this.tagUserInfo,
  });

  PetTag.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    if (json['emergency_contact_user'] != null) {
      emergencyContactUser = new List<UserEmergencyContact>();
      json['emergency_contact_user'].forEach((v) {
        emergencyContactUser.add(new UserEmergencyContact.fromJson(v));
      });
    }
    if (json['other_info'] != null) {
      otherInfo = new List<OtherInfo>();
      json['other_info'].forEach((v) {
        otherInfo.add(new OtherInfo.fromJson(v));
      });
    }
    preferenceUser = json['preference_user'] != null
        ? new PreferenceUser.fromJson(json['preference_user'])
        : null;
    tagInfo = json['tag_info'] != null
        ? new TagInfo.fromJson(json['tag_info'])
        : null;

    tagUserInfo = json['tag_user_info'] != null
        ? new TagUserInfo.fromJson(json['tag_user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    if (this.emergencyContactUser != null) {
      data['emergency_contact_user'] =
          this.emergencyContactUser.map((v) => v.toJson()).toList();
    }
    if (this.otherInfo != null) {
      data['other_info'] = this.otherInfo.map((v) => v.toJson()).toList();
    }
    if (this.preferenceUser != null) {
      data['preference_user'] = this.preferenceUser.toJson();
    }
    if (this.tagInfo != null) {
      data['tag_info'] = this.tagInfo.toJson();
    }
    if (this.tagUserInfo != null) {
      data['tag_user_info'] = this.tagUserInfo.toJson();
    }

    return data;
  }
}

class TagUserInfo {
  String firstName;
  String idUser;
  String lastName;
  String mail;
  String mail2;
  String mobile;
  String codePhone;

  TagUserInfo(
      {this.firstName,
      this.idUser,
      this.lastName,
      this.mail,
      this.mail2,
      this.mobile,
      this.codePhone});

  TagUserInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    idUser = json['id_user'];
    lastName = json['last_name'];
    mail = json['mail'];
    mail2 = json['mail2'];
    mobile = json['mobile'];
    codePhone = json['phone_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['id_user'] = this.idUser;
    data['last_name'] = this.lastName;
    data['mail'] = this.mail;
    data['mail2'] = this.mail2;
    data['mobile'] = this.mobile;
    data['phone_code'] = this.codePhone;
    return data;
  }
}

class Currency {
  int active;
  int allowCustumField;
  int allowValue;
  String custumField;
  int id;
  int idCurrencyLabel;
  int value;

  Currency(
      {this.active,
      this.allowCustumField,
      this.allowValue,
      this.custumField,
      this.id,
      this.idCurrencyLabel,
      this.value});

  Currency.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    allowCustumField = json['allow_custum_field'];
    allowValue = json['allow_value'];
    custumField = json['custum_field'];
    id = json['id'];
    idCurrencyLabel = json['id_currency_label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['allow_custum_field'] = this.allowCustumField;
    data['allow_value'] = this.allowValue;
    data['custum_field'] = this.custumField;
    data['id'] = this.id;
    data['id_currency_label'] = this.idCurrencyLabel;
    data['value'] = this.value;
    return data;
  }
}

class OtherInfo {
  int allow;
  int active;
  String description;
  List<Documents> documents;
  int id;
  String label;
  List<Reminders> reminders;

  OtherInfo(
      {this.allow,
      this.active,
      this.description,
      this.documents,
      this.id,
      this.label,
      this.reminders});

  OtherInfo.fromJson(Map<String, dynamic> json) {
    allow = json['allow'];
    active = json['active'];
    description = json['description'];
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    id = json['id'];
    label = json['label'];
    if (json['reminders'] != null) {
      reminders = new List<Reminders>();
      json['reminders'].forEach((v) {
        reminders.add(new Reminders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['allow'] = this.allow;
    data['active'] = this.active;
    data['description'] = this.description;
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['label'] = this.label;
    if (this.reminders != null) {
      data['reminders'] = this.reminders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reminders {
  int active;
  String dateCreation;
  int id;
  String lastUpdate;
  String reminderDate;
  String reminderDescription;
  String reminderLabel;
  int status;
  String cible;
  String rappelReminder;
  int rappelId;

  Reminders(
      {this.active,
      this.dateCreation,
      this.id,
      this.lastUpdate,
      this.reminderDate,
      this.reminderDescription,
      this.reminderLabel,
      this.rappelReminder,
      this.cible,
      this.rappelId,
      this.status});

  Reminders.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    cible = json['cible'];

    dateCreation = json['date_creation'];
    id = json['reminder_id'];
    lastUpdate = json['last_update'];
    reminderDate = json['reminder_date'];
    reminderDescription = json['reminder_description'];
    reminderLabel = json['reminder_label'];
    status = json['status'];
    rappelReminder = json['rappel_reminder'];
    rappelId = json['rappel_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['cible'] = this.cible;

    data['date_creation'] = this.dateCreation;
    data['reminder_id'] = this.id;
    data['last_update'] = this.lastUpdate;
    data['reminder_date'] = this.reminderDate;
    data['reminder_description'] = this.reminderDescription;
    data['reminder_label'] = this.reminderLabel;
    data['status'] = this.status;
    data['rappel_reminder'] = this.rappelReminder;
    data['rappel_id'] = this.rappelId;
    return data;
  }
}

class PreferenceTag {
  String accesLabelTxt;
  int active;
  int idField;
  String idFieldApp;
  int value;

  PreferenceTag(
      {this.accesLabelTxt,
      this.active,
      this.idField,
      this.idFieldApp,
      this.value});

  PreferenceTag.fromJson(Map<String, dynamic> json) {
    accesLabelTxt = json['acces_label_txt'];
    active = json['active'];
    idField = json['id_field'];
    idFieldApp = json['id_field_app'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acces_label_txt'] = this.accesLabelTxt;
    data['active'] = this.active;
    data['id_field'] = this.idField;
    data['id_field_app'] = this.idFieldApp;
    data['value'] = this.value;
    return data;
  }
}

class TagInfo {
  int active;
  int archive;
  int emergency;
  int idFinderWebsite;
  String idMember;
  int idPicture;
  int idTag;
  int idTagCategorie;
  int activeEmergency;
  int idType;
  String pictureName;
  String pictureUrl;
  String serialNumber;
  String tagCustumMessage;
  String tagDescription;
  String tagLabel;
  int idPet;

  TagInfo(
      {this.active,
      this.archive,
      this.emergency,
      this.idFinderWebsite,
      this.idMember,
      this.idPicture,
      this.idTag,
      this.activeEmergency,
      this.idTagCategorie,
      this.idType,
      this.pictureName,
      this.pictureUrl,
      this.serialNumber,
      this.tagCustumMessage,
      this.tagDescription,
      this.tagLabel,
      this.idPet});

  TagInfo.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    archive = json['archive'];
    emergency = json['emergency'];
    activeEmergency = json['active_emergency'];
    idFinderWebsite = json['id_finder_website'];
    idMember = json['id_member'];
    idPicture = json['id_picture'];
    idTag = json['id_tag'];
    idTagCategorie = json['id_tag_categorie'];
    idType = json['id_type'];
    pictureName = json['picture_name'];
    pictureUrl = json['picture_url'];
    serialNumber = json['serial_number'];
    tagCustumMessage = json['tag_custum_message'];
    tagDescription = json['tag_description'];
    tagLabel = json['tag_label'];
    idPet = json['id_pet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['archive'] = this.archive;
    data['emergency'] = this.emergency;
    data['id_finder_website'] = this.idFinderWebsite;
    data['id_member'] = this.idMember;
    data['id_picture'] = this.idPicture;
    data['id_tag'] = this.idTag;
    data['id_tag_categorie'] = this.idTagCategorie;
    data['id_type'] = this.idType;
    data['picture_name'] = this.pictureName;
    data['picture_url'] = this.pictureUrl;
    data['serial_number'] = this.serialNumber;
    data['tag_custum_message'] = this.tagCustumMessage;
    data['tag_description'] = this.tagDescription;
    data['tag_label'] = this.tagLabel;
    data['id_pet'] = this.idPet;
    data['active_emergency'] = this.activeEmergency;
    return data;
  }
}

class PreferenceUser {
  Allow allowLiveChat;
  Allow allowShareEmails;
  Allow allowShareName;
  Allow allowSharePhone;
  Allow allowSharePicture;
  Allow includeMail1;
  Allow includeMail2;
  Allow includeMobile;
  Allow shareChildName;
  Allow shareChildPicture;

  PreferenceUser(
      {this.allowLiveChat,
      this.allowShareEmails,
      this.allowShareName,
      this.allowSharePhone,
      this.allowSharePicture,
      this.includeMail1,
      this.includeMail2,
      this.includeMobile,
      this.shareChildName,
      this.shareChildPicture});

  PreferenceUser.fromJson(Map<String, dynamic> json) {
    allowLiveChat = json['allow_live_chat'] != null
        ? new Allow.fromJson(json['allow_live_chat'])
        : null;
    shareChildName = json['include_child_name'] != null
        ? new Allow.fromJson(json['include_child_name'])
        : null;
    allowShareEmails = json['allow_share_emails'] != null
        ? new Allow.fromJson(json['allow_share_emails'])
        : null;
    allowShareName = json['allow_share_name'] != null
        ? new Allow.fromJson(json['allow_share_name'])
        : null;
    allowSharePhone = json['allow_share_phone'] != null
        ? new Allow.fromJson(json['allow_share_phone'])
        : null;
    allowSharePicture = json['allow_share_picture'] != null
        ? new Allow.fromJson(json['allow_share_picture'])
        : null;
    includeMail1 = json['include_mail1'] != null
        ? new Allow.fromJson(json['include_mail1'])
        : null;
    includeMail2 = json['include_mail2'] != null
        ? new Allow.fromJson(json['include_mail2'])
        : null;
    includeMobile = json['include_mobile'] != null
        ? new Allow.fromJson(json['include_mobile'])
        : null;
    shareChildPicture = json['include_child_picture'] != null
        ? new Allow.fromJson(json['include_child_picture'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allowLiveChat != null) {
      data['allow_live_chat'] = this.allowLiveChat.toJson();
    }
    if (this.shareChildPicture != null) {
      data['include_child_picture'] = this.shareChildPicture.toJson();
    }
    if (this.allowShareEmails != null) {
      data['allow_share_emails'] = this.allowShareEmails.toJson();
    }
    if (this.allowShareName != null) {
      data['allow_share_name'] = this.allowShareName.toJson();
    }
    if (this.allowSharePhone != null) {
      data['allow_share_phone'] = this.allowSharePhone.toJson();
    }
    if (this.allowSharePicture != null) {
      data['allow_share_picture'] = this.allowSharePicture.toJson();
    }
    if (this.includeMail1 != null) {
      data['include_mail1'] = this.includeMail1.toJson();
    }
    if (this.includeMail2 != null) {
      data['include_mail2'] = this.includeMail2.toJson();
    }
    if (this.includeMobile != null) {
      data['include_mobile'] = this.includeMobile.toJson();
    }
    if (this.shareChildName != null) {
      data['include_child_name'] = this.shareChildName.toJson();
    }

    return data;
  }
}

class MedicalRecord {
  BloodInfo bloodInfo;
  String distitnctSign;
  OrganDonor organDonar;
  List<UserEmergencyContact> userEmergencyContact;
  Heightweight heightweight;
  int idEyeColor;
  int idGender;
  int idMaritalStatus;
  int idMedicalRecord;
  int idReligion;
  List<InsuranceInfo> insuranceInfo;
  String maritalStatus;
  MedicalDiseaces medicalDiseaces;
  List<Miscilanious> miscilanious;
  Resuscitate resuscitate;
  List<OtherMedicalRecordInfo> otherMedicalRecordInfo;
  String petAtHome;
  List<PhysicianContact> physicianContact;
  String pincode;
  String religionLabel;
  String spokenLanguages;

  MedicalRecord(
      {this.bloodInfo,
      this.distitnctSign,
      this.organDonar,
      this.userEmergencyContact,
      this.heightweight,
      this.idEyeColor,
      this.idGender,
      this.idMaritalStatus,
      this.idMedicalRecord,
      this.idReligion,
      this.insuranceInfo,
      this.maritalStatus,
      this.medicalDiseaces,
      this.miscilanious,
      this.resuscitate,
      this.otherMedicalRecordInfo,
      this.petAtHome,
      this.physicianContact,
      this.pincode,
      this.religionLabel,
      this.spokenLanguages});

  MedicalRecord.fromJson(Map<String, dynamic> json) {
    bloodInfo = json['blood_info'] != null
        ? new BloodInfo.fromJson(json['blood_info'])
        : null;
    distitnctSign = json['distitnct_sign'];
    organDonar = json['organ_donar'] != null
        ? new OrganDonor.fromJson(json['organ_donar'])
        : null;
    if (json['emerency_contact'] != null) {
      userEmergencyContact = new List<UserEmergencyContact>();
      json['emerency_contact'].forEach((v) {
        userEmergencyContact.add(new UserEmergencyContact.fromJson(v));
      });
    }
    heightweight = json['heightweight'] != null
        ? new Heightweight.fromJson(json['heightweight'])
        : null;
    idEyeColor = json['id_eye_color'];
    idGender = json['id_gender'];
    idMaritalStatus = json['id_marital_status'];
    idMedicalRecord = json['id_medical_record'];
    idReligion = json['id_religion'];
    if (json['insurance_info'] != null) {
      insuranceInfo = new List<InsuranceInfo>();
      json['insurance_info'].forEach((v) {
        insuranceInfo.add(new InsuranceInfo.fromJson(v));
      });
    }
    maritalStatus = json['marital_status'];
    medicalDiseaces = json['medical_diseaces'] != null
        ? new MedicalDiseaces.fromJson(json['medical_diseaces'])
        : null;
    if (json['miscilanious'] != null) {
      miscilanious = new List<Miscilanious>();
      json['miscilanious'].forEach((v) {
        miscilanious.add(new Miscilanious.fromJson(v));
      });
    }

    resuscitate = json['resuscitate'] != null
        ? new Resuscitate.fromJson(json['resuscitate'])
        : null;

    if (json['other_medical_record_info'] != null) {
      otherMedicalRecordInfo = new List<OtherMedicalRecordInfo>();
      json['other_medical_record_info'].forEach((v) {
        otherMedicalRecordInfo.add(new OtherMedicalRecordInfo.fromJson(v));
      });
    }
    petAtHome = json['pet_at_home'];
    if (json['physician_contact'] != null) {
      physicianContact = new List<PhysicianContact>();
      json['physician_contact'].forEach((v) {
        physicianContact.add(new PhysicianContact.fromJson(v));
      });
    }
    pincode = json['pincode'];
    religionLabel = json['religion_label'];
    spokenLanguages = json['spoken_languages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bloodInfo != null) {
      data['blood_info'] = this.bloodInfo.toJson();
    }
    data['distitnct_sign'] = this.distitnctSign;
    if (this.organDonar != null) {
      data['organ_donar'] = this.organDonar.toJson();
    }
    if (this.userEmergencyContact != null) {
      data['emerency_contact'] =
          this.userEmergencyContact.map((v) => v.toJson()).toList();
    }
    if (this.heightweight != null) {
      data['heightweight'] = this.heightweight.toJson();
    }
    data['id_eye_color'] = this.idEyeColor;
    data['id_gender'] = this.idGender;
    data['id_marital_status'] = this.idMaritalStatus;
    data['id_medical_record'] = this.idMedicalRecord;
    data['id_religion'] = this.idReligion;
    if (this.insuranceInfo != null) {
      data['insurance_info'] =
          this.insuranceInfo.map((v) => v.toJson()).toList();
    }
    data['marital_status'] = this.maritalStatus;
    if (this.medicalDiseaces != null) {
      data['medical_diseaces'] = this.medicalDiseaces.toJson();
    }
    if (this.miscilanious != null) {
      data['miscilanious'] = this.miscilanious.map((v) => v.toJson()).toList();
    }
    if (this.resuscitate != null) {
      data['resuscitate'] = this.resuscitate.toJson();
    }

    if (this.otherMedicalRecordInfo != null) {
      data['other_medical_record_info'] =
          this.otherMedicalRecordInfo.map((v) => v.toJson()).toList();
    }
    data['pet_at_home'] = this.petAtHome;
    if (this.physicianContact != null) {
      data['physician_contact'] =
          this.physicianContact.map((v) => v.toJson()).toList();
    }
    data['pincode'] = this.pincode;
    data['religion_label'] = this.religionLabel;
    data['spoken_languages'] = this.spokenLanguages;
    return data;
  }
}

class BloodInfo {
  String bloodDiastolic;
  int bloodPressure;
  String bloodSystolic;
  String bloodType;
  List<Diabates> diabates;
  int idBloodType;

  BloodInfo(
      {this.bloodDiastolic,
      this.bloodPressure,
      this.bloodSystolic,
      this.bloodType,
      this.diabates,
      this.idBloodType});

  BloodInfo.fromJson(Map<String, dynamic> json) {
    bloodDiastolic = json['blood_diastolic'];
    bloodPressure = json['blood_pressure'];
    bloodSystolic = json['blood_systolic'];
    bloodType = json['blood_type'];
    if (json['diabates'] != null) {
      diabates = new List<Diabates>();
      json['diabates'].forEach((v) {
        diabates.add(new Diabates.fromJson(v));
      });
    }
    idBloodType = json['id_blood_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blood_diastolic'] = this.bloodDiastolic;
    data['blood_pressure'] = this.bloodPressure;
    data['blood_systolic'] = this.bloodSystolic;
    data['blood_type'] = this.bloodType;
    if (this.diabates != null) {
      data['diabates'] = this.diabates.map((v) => v.toJson()).toList();
    }
    data['id_blood_type'] = this.idBloodType;
    return data;
  }
}

class Diabates {
  int public;
  String diabeteLabel;
  String diabeteDescription;
  List<Documents> documents;
  int id;
  List<Reminders> reminder;
  int active;
  Diabates(
      {this.diabeteLabel,
      this.public,
      this.diabeteDescription,
      this.documents,
      this.id,
      this.reminder,
      this.active});

  Diabates.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    public = json['public'];

    diabeteLabel = json['diabete_label'];
    diabeteDescription = json['diabete_description'];
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    id = json['id'];
    if (json['reminders'] != null) {
      reminder = new List<Reminders>();
      json['reminders'].forEach((v) {
        reminder.add(new Reminders.fromJson(v));
      });
    }
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diabete_description'] = this.diabeteDescription;
    data['active'] = this.active;
    data['diabete_label'] = this.diabeteLabel;
    data['public'] = this.public;

    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    if (this.reminder != null) {
      data['reminders'] = this.reminder.map((v) => v.toJson()).toList();
    }
    data['active'] = this.active;
    return data;
  }
}

class Heightweight {
  int idHeightWeight;
  double heightCm;
  double heightFt;
  double heightInch;
  double weightKg;
  double weightLbs;

  Heightweight(
      {this.idHeightWeight,
      this.heightCm,
      this.heightFt,
      this.heightInch,
      this.weightKg,
      this.weightLbs});

  Heightweight.fromJson(Map<String, dynamic> json) {
    idHeightWeight = json['id_height_weight'];
    heightCm = json['height_cm'];
    heightFt = json['height_ft'];
    heightInch = json['height_inch'];
    weightKg = json['weight_kg'];
    weightLbs = json['weight_lbs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_height_weight'] = this.idHeightWeight;
    data['height_cm'] = this.heightCm;
    data['height_ft'] = this.heightFt;
    data['height_inch'] = this.heightInch;
    data['weight_kg'] = this.weightKg;
    data['weight_lbs'] = this.weightLbs;
    return data;
  }
}

class InsuranceInfo {
  String additionalInformations;
  int active;
  List<Documents> documents;
  int id;
  String insuranceCampanyName;
  List<Reminders> reminders;

  InsuranceInfo(
      {this.additionalInformations,
      this.active,
      this.documents,
      this.id,
      this.insuranceCampanyName,
      this.reminders});

  InsuranceInfo.fromJson(Map<String, dynamic> json) {
    additionalInformations = json['additional_informations'];
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    id = json['id'];
    active = json['active'];

    insuranceCampanyName = json['insurance_campany_name'];
    if (json['reminders'] != null) {
      reminders = new List<Reminders>();
      json['reminders'].forEach((v) {
        reminders.add(new Reminders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['additional_informations'] = this.additionalInformations;
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['active'] = this.active;

    data['insurance_campany_name'] = this.insuranceCampanyName;
    if (this.reminders != null) {
      data['reminders'] = this.reminders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Documents {
  String data;
  String documentName;
  int id;
  String labelDoc;
  int public;
  int active;

  Documents(
      {this.data,
      this.documentName,
      this.id,
      this.labelDoc,
      this.public,
      this.active});

  Documents.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    active = json['active'];
    documentName = json['document_name'];
    id = json['id'];
    labelDoc = json['label_doc'];
    public = json['public'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['active'] = this.active;
    data['document_name'] = this.documentName;
    data['id'] = this.id;
    data['label_doc'] = this.labelDoc;
    data['public'] = this.public;
    return data;
  }
}

class Allergies {
  List<Blocks> blocks;

  Allergies({this.blocks});

  Allergies.fromJson(Map<String, dynamic> json) {
    if (json['blocks'] != null) {
      blocks = new List<Blocks>();
      json['blocks'].forEach((v) {
        blocks.add(new Blocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blocks != null) {
      data['blocks'] = this.blocks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cancer {
  List<Blocks> blocks;

  Cancer({this.blocks});

  Cancer.fromJson(Map<String, dynamic> json) {
    if (json['blocks'] != null) {
      blocks = new List<Blocks>();
      json['blocks'].forEach((v) {
        blocks.add(new Blocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blocks != null) {
      data['blocks'] = this.blocks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blocks {
  int active;
  String description;
  List<Documents> documents;
  int id;
  int idDiseace;
  String label;
  List<Reminders> reminders;

  Blocks(
      {this.description,
      this.documents,
      this.id,
      this.idDiseace,
      this.label,
      this.reminders});

  Blocks.fromJson(Map<String, dynamic> json) {
    active = json['active'];

    description = json['description'];
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    id = json['id'];
    idDiseace = json['id_diseace'];
    label = json['label'];
    if (json['reminders'] != null) {
      reminders = new List<Reminders>();
      json['reminders'].forEach((v) {
        reminders.add(new Reminders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;

    data['description'] = this.description;
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['id_diseace'] = this.idDiseace;
    data['label'] = this.label;
    if (this.reminders != null) {
      data['reminders'] = this.reminders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cardiac {
  List<Blocks> blocks;

  Cardiac({this.blocks});

  Cardiac.fromJson(Map<String, dynamic> json) {
    if (json['blocks'] != null) {
      blocks = new List<Blocks>();
      json['blocks'].forEach((v) {
        blocks.add(new Blocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blocks != null) {
      data['blocks'] = this.blocks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Miscilanious {
  int allow;
  String description;
  List<Documents> documents;
  int id;
  int idMedicalRecord;
  String label;
  List<Reminders> reminders;

  Miscilanious(
      {this.allow,
      this.description,
      this.documents,
      this.id,
      this.idMedicalRecord,
      this.label,
      this.reminders});

  Miscilanious.fromJson(Map<String, dynamic> json) {
    allow = json['allow'];
    description = json['description'];
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    id = json['id'];
    idMedicalRecord = json['id_medical_record'];
    label = json['label'];
    if (json['reminders'] != null) {
      reminders = new List<Reminders>();
      json['reminders'].forEach((v) {
        reminders.add(new Reminders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allow'] = this.allow;
    data['description'] = this.description;
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['id_medical_record'] = this.idMedicalRecord;
    data['label'] = this.label;
    if (this.reminders != null) {
      data['reminders'] = this.reminders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OtherMedicalRecordInfo {
  int active;
  int allow;
  String description;
  List<Documents> documents;
  int id;
  int idMedicalRecord;
  String label;
  List<Reminders> reminder;

  OtherMedicalRecordInfo(
      {this.allow,
      this.active,
      this.description,
      this.documents,
      this.id,
      this.idMedicalRecord,
      this.label,
      this.reminder});

  OtherMedicalRecordInfo.fromJson(Map<String, dynamic> json) {
    allow = json['allow'];
    active = json['active'];

    description = json['description'];
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    id = json['id'];
    idMedicalRecord = json['id_medical_record'];
    label = json['label'];
    if (json['reminders'] != null) {
      reminder = new List<Reminders>();
      json['reminders'].forEach((v) {
        reminder.add(new Reminders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allow'] = this.allow;
    data['active'] = this.active;

    data['description'] = this.description;
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['id_medical_record'] = this.idMedicalRecord;
    data['label'] = this.label;
    if (this.reminder != null) {
      data['reminders'] = this.reminder.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhysicianContact {
  int active;
  int allowContactMail;
  int allowContactMail2;
  int allowContactMobile;
  int allowMobile;
  int allowTel;
  String firstName;
  int id;
  String lastName;
  String mail;
  String mail2;
  String mobile;
  String mobile2;
  String speciality;
  String tel;
  String tel2;

  PhysicianContact(
      {this.allowContactMail,
      this.allowContactMail2,
      this.active,
      this.allowContactMobile,
      this.allowTel,
      this.firstName,
      this.id,
      this.lastName,
      this.mail,
      this.mail2,
      this.mobile,
      this.mobile2,
      this.speciality,
      this.tel,
      this.tel2});

  PhysicianContact.fromJson(Map<String, dynamic> json) {
    allowContactMail = json['allow_contact_mail1'];
    allowContactMail2 = json['allow_contact_mail2'];

    allowContactMobile = json['allow_contact_mobile'];
    allowTel = json['allow_tel'];
    active = json['active'];

    firstName = json['first_name'];
    id = json['id'];
    lastName = json['last_name'];
    mail = json['mail'];
    mail2 = json['mail2'];
    mobile = json['mobile'];
    mobile2 = json['mobile2'];
    speciality = json['speciality'];
    tel = json['tel'];
    tel2 = json['tel2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allow_contact_mail1'] = this.allowContactMail;
    data['allow_contact_mail2'] = this.allowContactMail2;

    data['allow_contact_mobile'] = this.allowContactMobile;
    data['allow_tel'] = this.allowTel;
    data['first_name'] = this.firstName;
    data['active'] = this.active;

    data['id'] = this.id;
    data['last_name'] = this.lastName;
    data['mail'] = this.mail;
    data['mail2'] = this.mail2;
    data['mobile'] = this.mobile;
    data['mobile2'] = this.mobile2;
    data['speciality'] = this.speciality;
    data['tel'] = this.tel;
    data['tel2'] = this.tel2;
    return data;
  }
}

class MedicalDiseaces {
  Allergies allergies;
  Cancer cancer;
  Allergies cardiac;
  Allergies implants;
  Allergies medication;
  Allergies neuroligic;
  Allergies plumonary;
  Allergies psychiatric;
  Allergies renalKenedy;
  Allergies infectionDisaces;

  MedicalDiseaces(
      {this.allergies,
      this.cancer,
      this.cardiac,
      this.implants,
      this.medication,
      this.neuroligic,
      this.plumonary,
      this.psychiatric,
      this.renalKenedy,
      this.infectionDisaces});

  MedicalDiseaces.fromJson(Map<String, dynamic> json) {
    allergies = json['Allergies'] != null
        ? new Allergies.fromJson(json['Allergies'])
        : null;
    cancer =
        json['Cancer'] != null ? new Cancer.fromJson(json['Cancer']) : null;
    cardiac = json['cardiac'] != null
        ? new Allergies.fromJson(json['cardiac'])
        : null;
    implants = json['Implants'] != null
        ? new Allergies.fromJson(json['Implants'])
        : null;
    cardiac = json['cardiac'] != null
        ? new Allergies.fromJson(json['cardiac'])
        : null;
    medication = json['Medication'] != null
        ? new Allergies.fromJson(json['Medication'])
        : null;
    neuroligic = json['Neuroligic'] != null
        ? new Allergies.fromJson(json['Neuroligic'])
        : null;
    plumonary = json['Plumonary'] != null
        ? new Allergies.fromJson(json['Plumonary'])
        : null;
    psychiatric = json['Psychiatric'] != null
        ? new Allergies.fromJson(json['Psychiatric'])
        : null;
    renalKenedy = json['Renal (Kenedy)'] != null
        ? new Allergies.fromJson(json['Renal (Kenedy)'])
        : null;
    infectionDisaces = json['infection disaces'] != null
        ? new Allergies.fromJson(json['infection disaces'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allergies != null) {
      data['Allergies'] = this.allergies.toJson();
    }
    if (this.cancer != null) {
      data['Cancer'] = this.cancer.toJson();
    }
    if (this.cardiac != null) {
      data['cardiac'] = this.cardiac.toJson();
    }
    if (this.implants != null) {
      data['Implants'] = this.implants.toJson();
    }
    if (this.medication != null) {
      data['Medication'] = this.medication.toJson();
    }
    if (this.neuroligic != null) {
      data['Neuroligic'] = this.neuroligic.toJson();
    }
    if (this.plumonary != null) {
      data['Plumonary'] = this.plumonary.toJson();
    }
    if (this.psychiatric != null) {
      data['Psychiatric'] = this.psychiatric.toJson();
    }
    if (this.renalKenedy != null) {
      data['Renal (Kenedy)'] = this.renalKenedy.toJson();
    }
    if (this.infectionDisaces != null) {
      data['infection disaces'] = this.infectionDisaces.toJson();
    }
    return data;
  }
}

class Resuscitate {
  int active;
  int allow;
  String description;
  List<Documents> documents;
  int id;
  int idMedicalRecord;
  String label;

  Resuscitate(
      {this.active,
      this.allow,
      this.description,
      this.documents,
      this.id,
      this.idMedicalRecord,
      this.label});

  Resuscitate.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    allow = json['allow'];
    description = json['description'];
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    id = json['id'];
    idMedicalRecord = json['id_medical_record'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['allow'] = this.allow;
    data['description'] = this.description;
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['id_medical_record'] = this.idMedicalRecord;
    data['label'] = this.label;
    return data;
  }
}

class OrganDonor {
  List<Documents> documents;
  int donar;
  String donarInformation;

  OrganDonor({this.documents, this.donar, this.donarInformation});

  OrganDonor.fromJson(Map<String, dynamic> json) {
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    donar = json['donar'];
    donarInformation = json['donar_information'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    data['donar'] = this.donar;
    data['donar_information'] = this.donarInformation;
    return data;
  }
}

class Pictures {
  String documentName;
  String documentUrl;
  int id;
  int public;
  String type;

  Pictures(
      {this.documentName, this.documentUrl, this.id, this.public, this.type});

  Pictures.fromJson(Map<String, dynamic> json) {
    documentName = json['document_name'];
    documentUrl = json['document_url'];
    id = json['id'];
    public = json['public'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_name'] = this.documentName;
    data['document_url'] = this.documentUrl;
    data['id'] = this.id;
    data['public'] = this.public;
    data['type'] = this.type;
    return data;
  }
}

class SubUsers {
  List<Profile> subUser;

  SubUsers({this.subUser});

  SubUsers.fromJson(Map<String, dynamic> json) {
    if (json['documents'] != null) {
      subUser = new List<Profile>();
      json['documents'].forEach((v) {
        subUser.add(new Profile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.subUser != null) {
      data['reminders'] = this.subUser.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class MemberInfo {
  String firstName;
  String idUser;
  String lastName;
  String mail;
  String mail2;
  String mobile;
  String codePhone;

  MemberInfo(
      {this.firstName,
      this.lastName,
      this.mail,
      this.mail2,
      this.mobile,
      this.codePhone});

  MemberInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    mail = json['mail'];
    mail2 = json['mail2'];
    mobile = json['mobile'];
    codePhone = json['phone_code_string'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mail'] = this.mail;
    data['mail2'] = this.mail2;
    data['mobile'] = this.mobile;
    data['phone_code_string'] = this.codePhone;
    return data;
  }
}

class PetsInfos {
  List<UserEmergencyContact> emergencyContact;
  GeneralInfo generalInfo;
  List<OtherInfo> otherInfo;
  List<Vaccins> vaccins;
  List<PetTag> petTag;
  PreferenceUser preferencePet;
  MemberInfo memberInfo;

  PetsInfos(
      {this.emergencyContact,
      this.generalInfo,
      this.otherInfo,
      this.vaccins,
      this.memberInfo,
      this.preferencePet,
      this.petTag});

  PetsInfos.fromJson(Map<String, dynamic> json) {
    if (json['emergency_contact'] != null) {
      emergencyContact = new List<UserEmergencyContact>();
      json['emergency_contact'].forEach((v) {
        emergencyContact.add(new UserEmergencyContact.fromJson(v));
      });
    }
    if (json['pet_tag'] != null) {
      petTag = new List<PetTag>();
      json['pet_tag'].forEach((v) {
        petTag.add(new PetTag.fromJson(v));
      });
    }
    preferencePet = json['preference_user'] != null
        ? new PreferenceUser.fromJson(json['preference_user'])
        : null;
    memberInfo = json['member_info'] != null
        ? new MemberInfo.fromJson(json['member_info'])
        : null;
    generalInfo = json['general_info'] != null
        ? new GeneralInfo.fromJson(json['general_info'])
        : null;
    if (json['other_info'] != null) {
      otherInfo = new List<OtherInfo>();
      json['other_info'].forEach((v) {
        otherInfo.add(new OtherInfo.fromJson(v));
      });
    }
    if (json['vaccins'] != null) {
      vaccins = new List<Vaccins>();
      json['vaccins'].forEach((v) {
        vaccins.add(new Vaccins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.emergencyContact != null) {
      data['emergency_contact'] =
          this.emergencyContact.map((v) => v.toJson()).toList();
    }
    if (this.petTag != null) {
      data['pet_tag'] = this.petTag.map((v) => v.toJson()).toList();
    }
    if (this.preferencePet != null) {
      data['preference_user'] = this.preferencePet.toJson();
    }
    if (this.generalInfo != null) {
      data['general_info'] = this.generalInfo.toJson();
    }
    if (this.memberInfo != null) {
      data['member_info'] = this.memberInfo.toJson();
    }

    if (this.otherInfo != null) {
      data['other_info'] = this.otherInfo.map((v) => v.toJson()).toList();
    }
    if (this.vaccins != null) {
      data['vaccins'] = this.vaccins.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GeneralInfo {
  int active;
  int idPet;
  int delete;
  String breed;
  String color;
  Currency currency;
  String dateBirth;
  BirthDateInfo birthInfo;

  String diet;
  String distinctsSigns;
  Heightweight heightweight;
  int idGender;
  int idHeightWeight;
  String idMember;
  int idPicture;
  String picturePet;
  int idType;
  Microscopic microscopic;
  String name;
  String thankYouMsg;

  GeneralInfo(
      {this.breed,
      this.idPet,
      this.active,
      this.idPicture,
      this.color,
      this.birthInfo,
      this.currency,
      this.dateBirth,
      this.delete,
      this.picturePet,
      this.diet,
      this.distinctsSigns,
      this.heightweight,
      this.idGender,
      this.idHeightWeight,
      this.idMember,
      this.idType,
      this.microscopic,
      this.name,
      this.thankYouMsg});

  GeneralInfo.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    birthInfo = json['birth_date_info'] != null
        ? new BirthDateInfo.fromJson(json['birth_date_info'])
        : null;

    breed = json['breed'];
    color = json['color'];
    idPet = json['id_pet'];
    delete = json['deleted'];

    idPicture = json['id_picture'];

    picturePet = json['pet_picture_url'];

    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    dateBirth = json['date_birth'];
    diet = json['diet'];
    distinctsSigns = json['distincts_signs'];
    heightweight = json['heightweight'] != null
        ? new Heightweight.fromJson(json['heightweight'])
        : null;
    idGender = json['id_gender'];
    idHeightWeight = json['id_height_weight'];
    idMember = json['id_member'];
    idType = json['id_type'];
    microscopic = json['microscopic'] != null
        ? new Microscopic.fromJson(json['microscopic'])
        : null;
    name = json['name'];
    thankYouMsg = json['thank_you_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breed'] = this.breed;
    data['active'] = this.active;
    data['deleted'] = this.delete;
    if (this.birthInfo != null) {
      data['birth_date_info'] = this.birthInfo.toJson();
    }
    data['id_pet'] = this.idPet;
    data['id_picture'] = this.idPicture;
    data['color'] = this.color;
    data['pet_picture_url'] = this.picturePet;

    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    data['date_birth'] = this.dateBirth;
    data['diet'] = this.diet;
    data['distincts_signs'] = this.distinctsSigns;
    if (this.heightweight != null) {
      data['heightweight'] = this.heightweight.toJson();
    }
    data['id_gender'] = this.idGender;
    data['id_height_weight'] = this.idHeightWeight;
    data['id_member'] = this.idMember;
    data['id_type'] = this.idType;
    if (this.microscopic != null) {
      data['microscopic'] = this.microscopic.toJson();
    }

    data['name'] = this.name;
    data['thank_you_msg'] = this.thankYouMsg;
    return data;
  }
}

class Vaccins {
  int active;
  int allow;
  String description;
  List<Documents> documents;
  int id;
  int idPet;
  String label;
  List<Reminders> reminders;

  Vaccins(
      {this.active,
      this.allow,
      this.description,
      this.documents,
      this.id,
      this.idPet,
      this.label,
      this.reminders});

  Vaccins.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    allow = json['allow'];
    description = json['description'];
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    id = json['id'];
    idPet = json['id_pet'];
    label = json['label'];
    if (json['reminders'] != null) {
      reminders = new List<Reminders>();
      json['reminders'].forEach((v) {
        reminders.add(new Reminders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['allow'] = this.allow;
    data['description'] = this.description;
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['id_pet'] = this.idPet;
    data['label'] = this.label;
    if (this.reminders != null) {
      data['reminders'] = this.reminders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Microscopic {
  int id;
  String michrochipNumber;
  String note;

  Microscopic({this.id, this.michrochipNumber, this.note});

  Microscopic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    michrochipNumber = json['michrochip_number'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['michrochip_number'] = this.michrochipNumber;
    data['note'] = this.note;
    return data;
  }
}

class ObjectRemindersList {
  String firstName;
  int idMember;
  String lastName;
  String pictureProfileUrl;
  List<Reminders> reminders;

  ObjectRemindersList(
      {this.firstName,
      this.idMember,
      this.lastName,
      this.pictureProfileUrl,
      this.reminders});

  ObjectRemindersList.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    idMember = json['id_member'];
    lastName = json['last_name'];
    pictureProfileUrl = json['picture_profile_url'];
    if (json['reminders'] != null) {
      reminders = new List<Reminders>();
      json['reminders'].forEach((v) {
        reminders.add(new Reminders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['id_member'] = this.idMember;
    data['last_name'] = this.lastName;
    data['picture_profile_url'] = this.pictureProfileUrl;
    if (this.reminders != null) {
      data['reminders'] = this.reminders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicalRemindersList {
  String firstName;
  int idMember;
  String lastName;
  String pictureProfileUrl;
  List<Reminders> reminders;

  MedicalRemindersList(
      {this.firstName,
      this.idMember,
      this.lastName,
      this.pictureProfileUrl,
      this.reminders});

  MedicalRemindersList.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    idMember = json['id_member'];
    lastName = json['last_name'];
    pictureProfileUrl = json['picture_profile_url'];
    if (json['reminders'] != null) {
      reminders = new List<Reminders>();
      json['reminders'].forEach((v) {
        reminders.add(new Reminders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['id_member'] = this.idMember;
    data['last_name'] = this.lastName;
    data['picture_profile_url'] = this.pictureProfileUrl;
    if (this.reminders != null) {
      data['reminders'] = this.reminders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PetRemindersList {
  int idPet;
  String petName;
  String pictureProfileUrl;
  List<Reminders> reminders;

  PetRemindersList(
      {this.idPet, this.petName, this.pictureProfileUrl, this.reminders});

  PetRemindersList.fromJson(Map<String, dynamic> json) {
    idPet = json['id_pet'];
    petName = json['pet_name'];
    pictureProfileUrl = json['picture_profile_url'];
    if (json['reminders'] != null) {
      reminders = new List<Reminders>();
      json['reminders'].forEach((v) {
        reminders.add(new Reminders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pet'] = this.idPet;
    data['pet_name'] = this.petName;
    data['picture_profile_url'] = this.pictureProfileUrl;
    if (this.reminders != null) {
      data['reminders'] = this.reminders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RemindersList {
  List<MedicalRemindersList> medicalTag;
  List<ObjectRemindersList> objectTag;
  List<PetRemindersList> petTag;

  RemindersList({this.medicalTag, this.objectTag, this.petTag});

  RemindersList.fromJson(Map<String, dynamic> json) {
    if (json['medical_tag'] != null) {
      medicalTag = new List<MedicalRemindersList>();
      json['medical_tag'].forEach((v) {
        medicalTag.add(new MedicalRemindersList.fromJson(v));
      });
    }
    if (json['object_tag'] != null) {
      objectTag = new List<ObjectRemindersList>();
      json['object_tag'].forEach((v) {
        objectTag.add(new ObjectRemindersList.fromJson(v));
      });
    }
    if (json['pet_tag'] != null) {
      petTag = new List<PetRemindersList>();
      json['pet_tag'].forEach((v) {
        petTag.add(new PetRemindersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicalTag != null) {
      data['medical_tag'] = this.medicalTag.map((v) => v.toJson()).toList();
    }
    if (this.objectTag != null) {
      data['object_tag'] = this.objectTag.map((v) => v.toJson()).toList();
    }
    if (this.petTag != null) {
      data['pet_tag'] = this.petTag.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewTags {
  bool error;
  String message;
  List<NewTag> newTag;
  String op;
  int tagCategorie;

  NewTags({this.error, this.message, this.newTag, this.op, this.tagCategorie});

  NewTags.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['new_tag'] != null) {
      newTag = new List<NewTag>();
      json['new_tag'].forEach((v) {
        newTag.add(new NewTag.fromJson(v));
      });
    }
    op = json['op'];
    tagCategorie = json['tag_categorie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.newTag != null) {
      data['new_tag'] = this.newTag.map((v) => v.toJson()).toList();
    }
    data['op'] = this.op;
    data['tag_categorie'] = this.tagCategorie;
    return data;
  }
}

class NewTag {
  Currency currency;
  List<UserEmergencyContact> emergencyContactUser;
  List<OtherInfo> otherInfo;
  PreferenceUser preferenceUser;
  TagInfo tagInfo;
  TagUserInfo tagUserInfo;

  NewTag(
      {this.currency,
      this.emergencyContactUser,
      this.otherInfo,
      this.preferenceUser,
      this.tagInfo,
      this.tagUserInfo});

  NewTag.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    if (json['emergency_contact_user'] != null) {
      emergencyContactUser = new List<UserEmergencyContact>();
      json['emergency_contact_user'].forEach((v) {
        emergencyContactUser.add(new UserEmergencyContact.fromJson(v));
      });
    }
    if (json['other_info'] != null) {
      otherInfo = new List<OtherInfo>();
      json['other_info'].forEach((v) {
        otherInfo.add(new OtherInfo.fromJson(v));
      });
    }
    preferenceUser = json['preference_user'] != null
        ? new PreferenceUser.fromJson(json['preference_user'])
        : null;
    tagInfo = json['tag_info'] != null
        ? new TagInfo.fromJson(json['tag_info'])
        : null;
    tagUserInfo = json['tag_user_info'] != null
        ? new TagUserInfo.fromJson(json['tag_user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    if (this.emergencyContactUser != null) {
      data['emergency_contact_user'] =
          this.emergencyContactUser.map((v) => v.toJson()).toList();
    }
    if (this.otherInfo != null) {
      data['other_info'] = this.otherInfo.map((v) => v.toJson()).toList();
    }
    if (this.preferenceUser != null) {
      data['preference_user'] = this.preferenceUser.toJson();
    }
    if (this.tagInfo != null) {
      data['tag_info'] = this.tagInfo.toJson();
    }
    if (this.tagUserInfo != null) {
      data['tag_user_info'] = this.tagUserInfo.toJson();
    }
    return data;
  }
}

class ObjectListTag {
  String firstName;
  String idMember;
  Null idPet;
  String lastName;
  String pictureProfileUrl;
  List<Tags> tags;

  ObjectListTag(
      {this.firstName,
      this.idMember,
      this.idPet,
      this.lastName,
      this.pictureProfileUrl,
      this.tags});

  ObjectListTag.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    idMember = json['id_member'];
    idPet = json['id_pet'];
    lastName = json['last_name'];
    pictureProfileUrl = json['picture_profile_url'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['id_member'] = this.idMember;
    data['id_pet'] = this.idPet;
    data['last_name'] = this.lastName;
    data['picture_profile_url'] = this.pictureProfileUrl;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/* class MedicalTagList {
  String firstName;
  int idMember;
  String lastName;
  String pictureProfileUrl;
  List<Tags> medicalTags;

  MedicalTagList(
      {this.firstName,
      this.idMember,
      this.lastName,
      this.pictureProfileUrl,
      this.medicalTags});

  MedicalTagList.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    idMember = json['id_member'];
    lastName = json['last_name'];
    pictureProfileUrl = json['picture_profile_url'];
    if (json['medical_tag'] != null) {
      medicalTags = new List<Tags>();
      json['medical_tag'].forEach((v) {
        medicalTags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['id_member'] = this.idMember;
    data['last_name'] = this.lastName;
    data['picture_profile_url'] = this.pictureProfileUrl;
    if (this.medicalTags != null) {
      data['medical_tag'] = this.medicalTags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
 */

class MedicalListTag {
  String firstName;
  String idMember;
  Null idPet;
  String lastName;
  String pictureProfileUrl;
  List<Tags> tags;

  MedicalListTag(
      {this.firstName,
      this.idMember,
      this.idPet,
      this.lastName,
      this.pictureProfileUrl,
      this.tags});

  MedicalListTag.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    idMember = json['id_member'];
    idPet = json['id_pet'];
    lastName = json['last_name'];
    pictureProfileUrl = json['picture_profile_url'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['id_member'] = this.idMember;
    data['id_pet'] = this.idPet;
    data['last_name'] = this.lastName;
    data['picture_profile_url'] = this.pictureProfileUrl;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TagsList {
  List<MedicalListTag> medicalTag;
  List<ObjectListTag> objectTag;
  List<PetListTag> petTag;

  TagsList({this.medicalTag, this.objectTag, this.petTag});

  TagsList.fromJson(Map<String, dynamic> json) {
    if (json['medical_tag'] != null) {
      medicalTag = new List<MedicalListTag>();
      json['medical_tag'].forEach((v) {
        medicalTag.add(new MedicalListTag.fromJson(v));
      });
    }
    if (json['object_tag'] != null) {
      objectTag = new List<ObjectListTag>();
      json['object_tag'].forEach((v) {
        objectTag.add(new ObjectListTag.fromJson(v));
      });
    }
    if (json['pet_tag'] != null) {
      petTag = new List<PetListTag>();
      json['pet_tag'].forEach((v) {
        petTag.add(new PetListTag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicalTag != null) {
      data['medical_tag'] = this.medicalTag.map((v) => v.toJson()).toList();
    }
    if (this.objectTag != null) {
      data['object_tag'] = this.objectTag.map((v) => v.toJson()).toList();
    }
    if (this.petTag != null) {
      data['pet_tag'] = this.petTag.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  Currency currency;
  List<UserEmergencyContact> emergencyContactUser;
  List<OtherInfo> otherInfo;
  PreferenceUser preferenceUser;
  TagInfo tagInfo;
  TagUserInfo tagUserInfo;

  Tags(
      {this.currency,
      this.emergencyContactUser,
      this.otherInfo,
      this.preferenceUser,
      this.tagInfo,
      this.tagUserInfo});

  Tags.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    if (json['user_emergency_contact'] != null) {
      emergencyContactUser = new List<UserEmergencyContact>();
      json['user_emergency_contact'].forEach((v) {
        emergencyContactUser.add(new UserEmergencyContact.fromJson(v));
      });
    }
    if (json['other_info'] != null) {
      otherInfo = new List<OtherInfo>();
      json['other_info'].forEach((v) {
        otherInfo.add(new OtherInfo.fromJson(v));
      });
    }
    preferenceUser = json['preference_user'] != null
        ? new PreferenceUser.fromJson(json['preference_user'])
        : null;
    tagInfo = json['tag_info'] != null
        ? new TagInfo.fromJson(json['tag_info'])
        : null;
    tagUserInfo = json['tag_user_info'] != null
        ? new TagUserInfo.fromJson(json['tag_user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    if (this.emergencyContactUser != null) {
      data['emergency_contact_user'] =
          this.emergencyContactUser.map((v) => v.toJson()).toList();
    }
    if (this.otherInfo != null) {
      data['other_info'] = this.otherInfo.map((v) => v.toJson()).toList();
    }
    if (this.preferenceUser != null) {
      data['preference_user'] = this.preferenceUser.toJson();
    }
    if (this.tagInfo != null) {
      data['tag_info'] = this.tagInfo.toJson();
    }
    if (this.tagUserInfo != null) {
      data['tag_user_info'] = this.tagUserInfo.toJson();
    }
    return data;
  }
}

class EmergencyContactUser {
  int active;
  int allowChat;
  int allowMail1;
  int allowMail2;
  int allowMobile;
  String codePhone;
  String codePhoneCountry;
  String firstName;
  int id;
  int idCodePhone;
  Null idPicture;
  Null idRelation;
  String lastName;
  String mail;
  String mail2;
  String mobile;
  String tel;

  EmergencyContactUser(
      {this.active,
      this.allowChat,
      this.allowMail1,
      this.allowMail2,
      this.allowMobile,
      this.codePhone,
      this.codePhoneCountry,
      this.firstName,
      this.id,
      this.idCodePhone,
      this.idPicture,
      this.idRelation,
      this.lastName,
      this.mail,
      this.mail2,
      this.mobile,
      this.tel});

  EmergencyContactUser.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    allowChat = json['allow__chat'];
    allowMail1 = json['allow_mail1'];
    allowMail2 = json['allow_mail2'];
    allowMobile = json['allow_mobile'];
    codePhone = json['code_phone'];
    codePhoneCountry = json['code_phone_country'];
    firstName = json['first_name'];
    id = json['id'];
    idCodePhone = json['id_code_phone'];
    idPicture = json['id_picture'];
    idRelation = json['id_relation'];
    lastName = json['last_name'];
    mail = json['mail'];
    mail2 = json['mail2'];
    mobile = json['mobile'];
    tel = json['tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['allow__chat'] = this.allowChat;
    data['allow_mail1'] = this.allowMail1;
    data['allow_mail2'] = this.allowMail2;
    data['allow_mobile'] = this.allowMobile;
    data['code_phone'] = this.codePhone;
    data['code_phone_country'] = this.codePhoneCountry;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['id_code_phone'] = this.idCodePhone;
    data['id_picture'] = this.idPicture;
    data['id_relation'] = this.idRelation;
    data['last_name'] = this.lastName;
    data['mail'] = this.mail;
    data['mail2'] = this.mail2;
    data['mobile'] = this.mobile;
    data['tel'] = this.tel;
    return data;
  }
}

class PetListTag {
  String firstName;
  int idPet;
  String lastName;
  String pictureProfileUrl;
  List<Tags> tags;

  PetListTag(
      {this.firstName,
      this.idPet,
      this.lastName,
      this.pictureProfileUrl,
      this.tags});

  PetListTag.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    idPet = json['id_pet'];
    lastName = json['last_name'];
    pictureProfileUrl = json['picture_profile_url'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['id_pet'] = this.idPet;
    data['last_name'] = this.lastName;
    data['picture_profile_url'] = this.pictureProfileUrl;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ZulipAcces {
  int lastEventId;
  String queueId;
  String zulipApiKey;
  String zulipMail;
  String zulipPwd;

  ZulipAcces(
      {this.lastEventId,
      this.queueId,
      this.zulipApiKey,
      this.zulipMail,
      this.zulipPwd});

  ZulipAcces.fromJson(Map<String, dynamic> json) {
    lastEventId = json['last_event_id'];
    queueId = json['queue_id'];
    zulipApiKey = json['zulip_api_key'];
    zulipMail = json['zulip_mail'];
    zulipPwd = json['zulip_pwd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_event_id'] = this.lastEventId;
    data['queue_id'] = this.queueId;
    data['zulip_api_key'] = this.zulipApiKey;
    data['zulip_mail'] = this.zulipMail;
    data['zulip_pwd'] = this.zulipPwd;
    return data;
  }
}

class Notifications {
  AdminNotification adminNotification;
  AdminNotification whenObjectIsScanned;

  Notifications({this.adminNotification, this.whenObjectIsScanned});

  Notifications.fromJson(Map<String, dynamic> json) {
    adminNotification = json['Admin notification'] != null
        ? new AdminNotification.fromJson(json['Admin notification'])
        : null;

    whenObjectIsScanned = json['When  object is scanned'] != null
        ? new AdminNotification.fromJson(json['When  object is scanned'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.adminNotification != null) {
      data['Admin notification'] = this.adminNotification.toJson();
    }

    if (this.whenObjectIsScanned != null) {
      data['When  object is scanned'] = this.whenObjectIsScanned.toJson();
    }
    return data;
  }
}

class AdminNotification {
  List<Content> content;
  int nbNotification;

  AdminNotification({this.content, this.nbNotification});

  AdminNotification.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
    nbNotification = json['nb_notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['nb_notification'] = this.nbNotification;
    return data;
  }
}

class BirthDateInfo {
  String day;
  String month;
  int year;

  BirthDateInfo({this.day, this.month, this.year});

  BirthDateInfo.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}

class Content {
  int active;
  int archive;
  String serialNumber;
  String tagLabel;
  String dateNotification;
  String idNotifcation;
  int idTagType;
  int idTypeNotification;
  String notificationType;
  int status;
  String text;
  String title;
  String content;
  String url;

  Content(
      {this.active,
      this.archive,
      this.dateNotification,
      this.serialNumber,
      this.tagLabel,
      this.content,
      this.idTagType,
      this.idNotifcation,
      this.idTypeNotification,
      this.notificationType,
      this.status,
      this.text,
      this.title,
      this.url});

  Content.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    serialNumber = json['serial_number'];
    tagLabel = json['tag_label'];
    idTagType = json['id_tag_type'];
    content = json['content'];
    archive = json['archive'];
    dateNotification = json['date_notification'];
    idNotifcation = json['id_notifcation'];
    idTypeNotification = json['id_type_notification'];
    notificationType = json['notification_type'];
    status = json['status'];
    text = json['text'];
    title = json['title'];
    url = json['big_picture_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['archive'] = this.archive;
    data['id_tag_type'] = this.idTagType;
    data['serial_number'] = this.serialNumber;
    data['tag_label'] = this.tagLabel;
    data['content'] = this.content;
    data['date_notification'] = this.dateNotification;
    data['id_notifcation'] = this.idNotifcation;
    data['id_type_notification'] = this.idTypeNotification;
    data['notification_type'] = this.notificationType;
    data['status'] = this.status;
    data['text'] = this.text;
    data['title'] = this.title;
    data['big_picture_url'] = this.url;
    return data;
  }
}
