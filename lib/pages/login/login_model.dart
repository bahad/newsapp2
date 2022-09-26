import 'package:newsapp2/core/base/base_model.dart';

class LoginModel extends IBaseModel {
  String? message;
  String? token;
  User? user;

  LoginModel({this.message, this.token, this.user});

  LoginModel.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  @override
  fromJson(json) {
    return LoginModel.fromJson(json);
  }
}

class User {
  String? userId;
  String? username;
  String? password;
  String? fullname;
  String? email;
  String? phone;
  Media? media;
  bool? isBanned;
  bool? isApproved;
  int? level;
  Badges? badges;
  int? createdAt;
  List<Followers>? followers;
  Geometry? geometry;

  User(
      {this.userId,
      this.username,
      this.password,
      this.fullname,
      this.email,
      this.phone,
      this.media,
      this.isBanned,
      this.isApproved,
      this.level,
      this.badges,
      this.createdAt,
      this.followers,
      this.geometry});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    password = json['password'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    media = json['media'] != null ? Media.fromJson(json['media']) : null;
    isBanned = json['isBanned'];
    isApproved = json['isApproved'];
    level = json['level'];
    badges = json['badges'] != null ? Badges.fromJson(json['badges']) : null;
    createdAt = json['createdAt'];
    if (json['followers'] != null) {
      followers = <Followers>[];
      json['followers'].forEach((v) {
        followers!.add(Followers.fromJson(v));
      });
    }
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['username'] = username;
    data['password'] = password;
    data['fullname'] = fullname;
    data['email'] = email;
    data['phone'] = phone;
    if (media != null) {
      data['media'] = media!.toJson();
    }
    data['isBanned'] = isBanned;
    data['isApproved'] = isApproved;
    data['level'] = level;
    if (badges != null) {
      data['badges'] = badges!.toJson();
    }
    data['createdAt'] = createdAt;
    if (followers != null) {
      data['followers'] = followers!.map((v) => v.toJson()).toList();
    }
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    return data;
  }
}

class Media {
  String? facebook;
  String? twitter;
  String? instagram;

  Media({this.facebook, this.twitter, this.instagram});

  Media.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['instagram'] = instagram;
    return data;
  }
}

class Badges {
  bool? yorumcu;
  bool? yazar;
  bool? populer;
  bool? onecikan;
  bool? sevilen;
  bool? sporsever;
  bool? ekonomist;

  Badges(
      {this.yorumcu,
      this.yazar,
      this.populer,
      this.onecikan,
      this.sevilen,
      this.sporsever,
      this.ekonomist});

  Badges.fromJson(Map<String, dynamic> json) {
    yorumcu = json['yorumcu'];
    yazar = json['yazar'];
    populer = json['populer'];
    onecikan = json['onecikan'];
    sevilen = json['sevilen'];
    sporsever = json['sporsever'];
    ekonomist = json['ekonomist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['yorumcu'] = yorumcu;
    data['yazar'] = yazar;
    data['populer'] = populer;
    data['onecikan'] = onecikan;
    data['sevilen'] = sevilen;
    data['sporsever'] = sporsever;
    data['ekonomist'] = ekonomist;
    return data;
  }
}

class Followers {
  String? userId;
  String? username;
  String? sId;

  Followers({this.userId, this.username, this.sId});

  Followers.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['username'] = username;
    data['_id'] = sId;
    return data;
  }
}

class Geometry {
  String? lat;
  String? long;

  Geometry({this.lat, this.long});

  Geometry.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
