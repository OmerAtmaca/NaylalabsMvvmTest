class StoriesModel {
  List<Data>? data;
  int? statusCode;
  List? errors;
  int? count;

  StoriesModel({data, statusCode, errors, count});

  StoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    if (json['errors'] != null) {
      errors = [];
      json['errors'].forEach((v) {
        errors!.add(StoriesModel.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = statusCode;
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Data {
  String? sId;
  String? videoUrl;
  String? thumbnail;
  String? caption;
  String? title;
  User? user;
  String? createdAt;
  int? likeCount;
  int? commentCount;
  bool? isLiked;
  bool? isCommented;
  int? viewCount;

  Data(
      {sId,
      videoUrl,
      thumbnail,
      caption,
      title,
      user,
      createdAt,
      likeCount,
      commentCount,
      isLiked,
      isCommented,
      viewCount});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    videoUrl = json['videoUrl'];
    thumbnail = json['thumbnail'];
    caption = json['caption'];
    title = json['title'];
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    isLiked = json['isLiked'];
    isCommented = json['isCommented'];
    viewCount = json['viewCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['videoUrl'] = videoUrl;
    data['thumbnail'] = thumbnail;
    data['caption'] = caption;
    data['title'] = title;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['createdAt'] = createdAt;
    data['likeCount'] = likeCount;
    data['commentCount'] = commentCount;
    data['isLiked'] = isLiked;
    data['isCommented'] = isCommented;
    data['viewCount'] = viewCount;
    return data;
  }
}

class User {
  int? followerCount;
  int? starPointCount;
  String? sId;
  String? email;
  String? fullName;
  String? industry;
  String? location;
  String? professionalCategory;
  String? profilePic;
  String? username;
  String? company;
  String? title;
  bool? isFollowing;

  User(
      {followerCount,
      starPointCount,
      sId,
      email,
      fullName,
      industry,
      location,
      professionalCategory,
      profilePic,
      username,
      company,
      title,
      isFollowing});

  User.fromJson(Map<String, dynamic> json) {
    followerCount = json['followerCount'];
    starPointCount = json['starPointCount'];
    sId = json['_id'];
    email = json['email'];
    fullName = json['fullName'];
    industry = json['industry'];
    location = json['location'];
    professionalCategory = json['professionalCategory'];
    profilePic = json['profilePic'];
    username = json['username'];
    company = json['company'];
    title = json['title'];
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['followerCount'] = followerCount;
    data['starPointCount'] = starPointCount;
    data['_id'] = sId;
    data['email'] = email;
    data['fullName'] = fullName;
    data['industry'] = industry;
    data['location'] = location;
    data['professionalCategory'] = professionalCategory;
    data['profilePic'] = profilePic;
    data['username'] = username;
    data['company'] = company;
    data['title'] = title;
    data['isFollowing'] = isFollowing;
    return data;
  }
}