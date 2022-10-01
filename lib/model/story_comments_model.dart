class StoryComment {
  List<CommentData>? data;
  int? statusCode;
  List? errors;
  int? count;

  StoryComment({data, statusCode, errors, count});

  StoryComment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CommentData>[];
      json['data'].forEach((v) {
        data!.add( CommentData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    if (json['errors'] != null) {
      errors = [];
      json['errors'].forEach((v) {
        errors!.add( StoryComment.fromJson(v));
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

class CommentData {
  int? likeCount;
  List<String>? likes;
  String? sId;
  String? content;
  CommentUser? user;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isLiked;

  CommentData(
      {likeCount,
      likes,
      sId,
      content,
      user,
      createdAt,
      updatedAt,
      iV,
      isLiked});

  CommentData.fromJson(Map<String, dynamic> json) {
    likeCount = json['likeCount'];
    likes = json['likes'].cast<String>();
    sId = json['_id'];
    content = json['content'];
    user = json['user'] != null ?  CommentUser.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['likeCount'] = likeCount;
    data['likes'] = likes;
    data['_id'] = sId;
    data['content'] = content;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['isLiked'] = isLiked;
    return data;
  }
}

class CommentUser {
  int? followerCount;
  int? starPointCount;
  String? sId;
  String? email;
  String? fullName;
  String? industry;
  String? professionalCategory;
  String? profilePic;
  String? username;
  String? company;
  String? location;
  String? title;

  CommentUser(
      {followerCount,
      starPointCount,
      sId,
      email,
      fullName,
      industry,
      professionalCategory,
      profilePic,
      username,
      company,
      location,
      title});

  CommentUser.fromJson(Map<String, dynamic> json) {
    followerCount = json['followerCount'];
    starPointCount = json['starPointCount'];
    sId = json['_id'];
    email = json['email'];
    fullName = json['fullName'];
    industry = json['industry'];
    professionalCategory = json['professionalCategory'];
    profilePic = json['profilePic'];
    username = json['username'];
    company = json['company'];
    location = json['location'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['followerCount'] = followerCount;
    data['starPointCount'] = starPointCount;
    data['_id'] = sId;
    data['email'] = email;
    data['fullName'] = fullName;
    data['industry'] = industry;
    data['professionalCategory'] = professionalCategory;
    data['profilePic'] = profilePic;
    data['username'] = username;
    data['company'] = company;
    data['location'] = location;
    data['title'] = title;
    return data;
  }
}