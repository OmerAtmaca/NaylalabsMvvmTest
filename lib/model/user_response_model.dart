class UserResponseModel {
  LoginData? data;
  int? statusCode;
  List? errors;
  int? count;

  UserResponseModel({data, statusCode, errors, count});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  LoginData.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    if (json['errors'] != null) {
      errors = [];
      json['errors'].forEach((v) {
        errors!.add( UserResponseModel.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = statusCode;
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class LoginData {
  bool? isAdmin;
  String? linkedin;
  String? tiktok;
  String? website;
  String? instagram;
  String? youtube;
  String? twitter;
  bool? isPhoneVerified;
  bool? isEmailVerified;
  bool? isProfileCompleted;
  int? postCount;
  int? storyCount;
  int? followerCount;
  int? followeeCount;
  int? starPointCount;
  List<String>? details;
  bool? shouldSendPushNotification;
  bool? shouldSendEmailAndSms;
  int? videoQAStarCounter;
  List<String>? skills;
  List? identify;
  String? sId;
  String? email;
  String? type;
  String? createdAt;
  String? referralCode;
  String? birthday;
  String? fullName;
  String? gender;
  String? industry;
  String? location;
  String? professionalCategory;
  String? profilePic;
  String? username;
  String? company;
  bool? isUnderrepresented;
  String? title;
  String? token;

  LoginData(
      {isAdmin,
      linkedin,
      tiktok,
      website,
      instagram,
      youtube,
      twitter,
      isPhoneVerified,
      isEmailVerified,
      isProfileCompleted,
      postCount,
      storyCount,
      followerCount,
      followeeCount,
      starPointCount,
      details,
      shouldSendPushNotification,
      shouldSendEmailAndSms,
      videoQAStarCounter,
      skills,
      identify,
      sId,
      email,
      type,
      createdAt,
      referralCode,
      birthday,
      fullName,
      gender,
      industry,
      location,
      professionalCategory,
      profilePic,
      username,
      company,
      isUnderrepresented,
      title,
      token
      });

  LoginData.fromJson(Map<String, dynamic> json) {
    isAdmin = json['isAdmin'];
    linkedin = json['linkedin'];
    tiktok = json['tiktok'];
    website = json['website'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    twitter = json['twitter'];
    isPhoneVerified = json['isPhoneVerified'];
    isEmailVerified = json['isEmailVerified'];
    isProfileCompleted = json['isProfileCompleted'];
    postCount = json['postCount'];
    storyCount = json['storyCount'];
    followerCount = json['followerCount'];
    followeeCount = json['followeeCount'];
    starPointCount = json['starPointCount'];
    details = json['details'].cast<String>();
    shouldSendPushNotification = json['shouldSendPushNotification'];
    shouldSendEmailAndSms = json['shouldSendEmailAndSms'];
    videoQAStarCounter = json['videoQAStarCounter'];
    skills = json['skills'].cast<String>();
    if (json['identify'] != null) {
      identify = [];
      json['identify'].forEach((v) {
        identify!.add( UserResponseModel.fromJson(v));
      });
    }
    sId = json['_id'];
    email = json['email'];
    type = json['type'];
    createdAt = json['createdAt'];
    referralCode = json['referralCode'];
    birthday = json['birthday'];
    fullName = json['fullName'];
    gender = json['gender'];
    industry = json['industry'];
    location = json['location'];
    professionalCategory = json['professionalCategory'];
    profilePic = json['profilePic'];
    username = json['username'];
    company = json['company'];
    isUnderrepresented = json['isUnderrepresented'];
    title = json['title'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAdmin'] = isAdmin;
    data['linkedin'] = linkedin;
    data['tiktok'] = tiktok;
    data['website'] = website;
    data['instagram'] = instagram;
    data['youtube'] = youtube;
    data['twitter'] = twitter;
    data['isPhoneVerified'] = isPhoneVerified;
    data['isEmailVerified'] = isEmailVerified;
    data['isProfileCompleted'] = isProfileCompleted;
    data['postCount'] = postCount;
    data['storyCount'] = storyCount;
    data['followerCount'] = followerCount;
    data['followeeCount'] = followeeCount;
    data['starPointCount'] = starPointCount;
    data['details'] = details;
    data['shouldSendPushNotification'] = shouldSendPushNotification;
    data['shouldSendEmailAndSms'] = shouldSendEmailAndSms;
    data['videoQAStarCounter'] = videoQAStarCounter;
    data['skills'] = skills;
    if (identify != null) {
      data['identify'] = identify!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['email'] = email;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['referralCode'] = referralCode;
    data['birthday'] = birthday;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['industry'] = industry;
    data['location'] = location;
    data['professionalCategory'] = professionalCategory;
    data['profilePic'] = profilePic;
    data['username'] = username;
    data['company'] = company;
    data['isUnderrepresented'] = isUnderrepresented;
    data['title'] = title;
    data['token'] = token;
    return data;
  }
}