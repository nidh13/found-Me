class Discussions {
  List<DiscussionsMessage> listMessage;
  String queueId;

  Discussions({this.listMessage, this.queueId});

  Discussions.fromJson(Map<String, dynamic> json) {
    if (json['list_message'] != null) {
      listMessage = new List<DiscussionsMessage>();
      json['list_message'].forEach((v) {
        listMessage.add(new DiscussionsMessage.fromJson(v));
      });
    }
    queueId = json['queue_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listMessage != null) {
      data['list_message'] = this.listMessage.map((v) => v.toJson()).toList();
    }
    data['queue_id'] = this.queueId;
    return data;
  }
}

class DiscussionsMessage {
  String sN;
  String message;
  String messageOwner;
  List<String> nameOfDisscussion;
  int nbUnread;
  List<String> recievers;
  String sendTimeMessage;
  String tagLabel;

  DiscussionsMessage(
      {this.sN,
      this.message,
      this.messageOwner,
      this.nameOfDisscussion,
      this.nbUnread,
      this.recievers,
      this.sendTimeMessage,
      this.tagLabel});

  DiscussionsMessage.fromJson(Map<String, dynamic> json) {
    sN = json['SN'];
    message = json['message'];
    messageOwner = json['message_owner'];
    nameOfDisscussion = json['name_of_disscussion'].cast<String>();
    nbUnread = json['nb_unread'];
    recievers = json['recievers'].cast<String>();
    sendTimeMessage = json['send_time_message'];
    tagLabel = json['tag_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SN'] = this.sN;
    data['message'] = this.message;
    data['message_owner'] = this.messageOwner;
    data['name_of_disscussion'] = this.nameOfDisscussion;
    data['nb_unread'] = this.nbUnread;
    data['recievers'] = this.recievers;
    data['send_time_message'] = this.sendTimeMessage;
    data['tag_label'] = this.tagLabel;
    return data;
  }
}

class SpecificDiscussion {
  int nombreMessages;
  String queueId;
  List<SpecificMessage> specificMessage;

  SpecificDiscussion({this.nombreMessages, this.queueId, this.specificMessage});

  SpecificDiscussion.fromJson(Map<String, dynamic> json) {
    nombreMessages = json['nombre_messages'];
    queueId = json['queue_id'];
    if (json['specific_message'] != null) {
      specificMessage = new List<SpecificMessage>();
      json['specific_message'].forEach((v) {
        specificMessage.add(new SpecificMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre_messages'] = this.nombreMessages;
    data['queue_id'] = this.queueId;
    if (this.specificMessage != null) {
      data['specific_message'] =
          this.specificMessage.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecificMessage {
  int idMesage;
  String message;
  String messageOwnerEmail;
  String messageOwnerName;
  String sendTimeMessage;
  bool isFile;
  bool isLink;

  SpecificMessage({
    this.idMesage,
    this.message,
    this.messageOwnerEmail,
    this.messageOwnerName,
    this.sendTimeMessage,
    this.isFile,
    this.isLink,
  });

  SpecificMessage.fromJson(Map<String, dynamic> json) {
    idMesage = json['id_mesage'];
    message = json['message'];
    messageOwnerEmail = json['message_owner_email'];
    messageOwnerName = json['message_owner_name'];
    sendTimeMessage = json['send_time_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_mesage'] = this.idMesage;
    data['message'] = this.message;
    data['message_owner_email'] = this.messageOwnerEmail;
    data['message_owner_name'] = this.messageOwnerName;
    data['send_time_message'] = this.sendTimeMessage;
    return data;
  }
}

class NewMessage {
  List<Events> events;
  String msg;
  String queueId;
  String result;

  NewMessage({this.events, this.msg, this.queueId, this.result});

  NewMessage.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = new List<Events>();
      json['events'].forEach((v) {
        events.add(new Events.fromJson(v));
      });
    }
    msg = json['msg'];
    queueId = json['queue_id'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['queue_id'] = this.queueId;
    data['result'] = this.result;
    return data;
  }
}

class Events {
  String op;
  int id;
  Message message;
  String type;
  Recipients sender;

  Events({
    this.id,
    this.message,
    this.sender,
    this.type,
    this.op,
  });

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
    type = json['type'];
    op = json['op'];
    sender =
        json['sender'] != null ? new Recipients.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.message != null) {
      data['message'] = this.message.toJson();
    }
    data['type'] = this.type;
    data['op'] = this.op;
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    return data;
  }
}

class Recipients {
  String email;
  int userId;

  Recipients({this.email, this.userId});

  Recipients.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['user_id'] = this.userId;
    return data;
  }
}

class Message {
  String avatarUrl;
  String client;
  String content;
  String contentType;
  List<DisplayRecipient> displayRecipient;
  int id;
  bool isMeMessage;
  int recipientId;
  String senderEmail;
  String senderFullName;
  int senderId;
  String senderRealmStr;
  String senderShortName;
  String subject;
  int timestamp;
  String type;

  Message(
      {this.avatarUrl,
      this.client,
      this.content,
      this.contentType,
      this.displayRecipient,
      this.id,
      this.isMeMessage,
      this.recipientId,
      this.senderEmail,
      this.senderFullName,
      this.senderId,
      this.senderRealmStr,
      this.senderShortName,
      this.subject,
      this.timestamp,
      this.type});

  Message.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatar_url'];
    client = json['client'];
    content = json['content'];
    contentType = json['content_type'];
    if (json['display_recipient'] != null) {
      displayRecipient = new List<DisplayRecipient>();
      json['display_recipient'].forEach((v) {
        displayRecipient.add(new DisplayRecipient.fromJson(v));
      });
    }
    id = json['id'];
    isMeMessage = json['is_me_message'];

    recipientId = json['recipient_id'];
    senderEmail = json['sender_email'];
    senderFullName = json['sender_full_name'];
    senderId = json['sender_id'];
    senderRealmStr = json['sender_realm_str'];
    senderShortName = json['sender_short_name'];
    subject = json['subject'];

    timestamp = json['timestamp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar_url'] = this.avatarUrl;
    data['client'] = this.client;
    data['content'] = this.content;
    data['content_type'] = this.contentType;
    if (this.displayRecipient != null) {
      data['display_recipient'] =
          this.displayRecipient.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['is_me_message'] = this.isMeMessage;

    data['recipient_id'] = this.recipientId;
    data['sender_email'] = this.senderEmail;
    data['sender_full_name'] = this.senderFullName;
    data['sender_id'] = this.senderId;
    data['sender_realm_str'] = this.senderRealmStr;
    data['sender_short_name'] = this.senderShortName;
    data['subject'] = this.subject;

    data['timestamp'] = this.timestamp;
    data['type'] = this.type;
    return data;
  }
}

class DisplayRecipient {
  String email;
  String fullName;
  int id;
  bool isMirrorDummy;
  String shortName;

  DisplayRecipient(
      {this.email, this.fullName, this.id, this.isMirrorDummy, this.shortName});

  DisplayRecipient.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['full_name'];
    id = json['id'];
    isMirrorDummy = json['is_mirror_dummy'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['id'] = this.id;
    data['is_mirror_dummy'] = this.isMirrorDummy;
    data['short_name'] = this.shortName;
    return data;
  }
}

class Meeting {
  String getJoinMeetingUrl;
  GetMeetingInfo getMeetingInfo;

  Meeting({this.getJoinMeetingUrl, this.getMeetingInfo});

  Meeting.fromJson(Map<String, dynamic> json) {
    getJoinMeetingUrl = json['get_join_meeting_url'];
    getMeetingInfo = json['get_meeting_info'] != null
        ? new GetMeetingInfo.fromJson(json['get_meeting_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['get_join_meeting_url'] = this.getJoinMeetingUrl;
    if (this.getMeetingInfo != null) {
      data['get_meeting_info'] = this.getMeetingInfo.toJson();
    }
    return data;
  }
}

class GetMeetingInfo {
  Xml xml;

  GetMeetingInfo({this.xml});

  GetMeetingInfo.fromJson(Map<String, dynamic> json) {
    xml = json['xml'] != null ? new Xml.fromJson(json['xml']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.xml != null) {
      data['xml'] = this.xml.toJson();
    }
    return data;
  }
}

class Xml {
  String attendeePW;
  String attendees;
  String createDate;
  String createTime;
  String dialNumber;
  String duration;
  String endTime;
  String hasBeenForciblyEnded;
  String hasUserJoined;
  String internalMeetingID;
  String isBreakout;
  String listenerCount;
  String maxUsers;
  String meetingID;
  String meetingName;
  String metadata;
  String moderatorCount;
  String moderatorPW;
  String participantCount;
  String recording;
  String returncode;
  String running;
  String startTime;
  String videoCount;
  String voiceBridge;
  String voiceParticipantCount;

  Xml(
      {this.attendeePW,
      this.attendees,
      this.createDate,
      this.createTime,
      this.dialNumber,
      this.duration,
      this.endTime,
      this.hasBeenForciblyEnded,
      this.hasUserJoined,
      this.internalMeetingID,
      this.isBreakout,
      this.listenerCount,
      this.maxUsers,
      this.meetingID,
      this.meetingName,
      this.metadata,
      this.moderatorCount,
      this.moderatorPW,
      this.participantCount,
      this.recording,
      this.returncode,
      this.running,
      this.startTime,
      this.videoCount,
      this.voiceBridge,
      this.voiceParticipantCount});

  Xml.fromJson(Map<String, dynamic> json) {
    attendeePW = json['attendeePW'];
    attendees = json['attendees'];
    createDate = json['createDate'];
    createTime = json['createTime'];
    dialNumber = json['dialNumber'];
    duration = json['duration'];
    endTime = json['endTime'];
    hasBeenForciblyEnded = json['hasBeenForciblyEnded'];
    hasUserJoined = json['hasUserJoined'];
    internalMeetingID = json['internalMeetingID'];
    isBreakout = json['isBreakout'];
    listenerCount = json['listenerCount'];
    maxUsers = json['maxUsers'];
    meetingID = json['meetingID'];
    meetingName = json['meetingName'];
    metadata = json['metadata'];
    moderatorCount = json['moderatorCount'];
    moderatorPW = json['moderatorPW'];
    participantCount = json['participantCount'];
    recording = json['recording'];
    returncode = json['returncode'];
    running = json['running'];
    startTime = json['startTime'];
    videoCount = json['videoCount'];
    voiceBridge = json['voiceBridge'];
    voiceParticipantCount = json['voiceParticipantCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendeePW'] = this.attendeePW;
    data['attendees'] = this.attendees;
    data['createDate'] = this.createDate;
    data['createTime'] = this.createTime;
    data['dialNumber'] = this.dialNumber;
    data['duration'] = this.duration;
    data['endTime'] = this.endTime;
    data['hasBeenForciblyEnded'] = this.hasBeenForciblyEnded;
    data['hasUserJoined'] = this.hasUserJoined;
    data['internalMeetingID'] = this.internalMeetingID;
    data['isBreakout'] = this.isBreakout;
    data['listenerCount'] = this.listenerCount;
    data['maxUsers'] = this.maxUsers;
    data['meetingID'] = this.meetingID;
    data['meetingName'] = this.meetingName;
    data['metadata'] = this.metadata;
    data['moderatorCount'] = this.moderatorCount;
    data['moderatorPW'] = this.moderatorPW;
    data['participantCount'] = this.participantCount;
    data['recording'] = this.recording;
    data['returncode'] = this.returncode;
    data['running'] = this.running;
    data['startTime'] = this.startTime;
    data['videoCount'] = this.videoCount;
    data['voiceBridge'] = this.voiceBridge;
    data['voiceParticipantCount'] = this.voiceParticipantCount;
    return data;
  }
}
