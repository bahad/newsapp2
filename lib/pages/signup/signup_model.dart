import 'package:newsapp2/core/base/base_model.dart';

class SignupModel extends IBaseModel {
  String? message;
  User? user;

  SignupModel({this.message, this.user});

  SignupModel.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  @override
  fromJson(json) {
    return SignupModel.fromJson(json);
  }
}

class User {
  String? userId;
  String? username;
  String? email;
  String? fullname;
  String? phone;
  Media? media;
  bool? isApproved;
  bool? isBanned;
  Badges? badges;
  int? level;
  int? createdAt;
  List<Followers>? followers;
  Geometry? geometry;

  User(
      {this.userId,
      this.username,
      this.email,
      this.fullname,
      this.phone,
      this.media,
      this.isApproved,
      this.isBanned,
      this.badges,
      this.level,
      this.createdAt,
      this.followers,
      this.geometry});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    email = json['email'];
    fullname = json['fullname'];
    phone = json['phone'];
    media = json['media'] != null ? Media.fromJson(json['media']) : null;
    isApproved = json['isApproved'];
    isBanned = json['isBanned'];
    badges = json['badges'] != null ? Badges.fromJson(json['badges']) : null;
    level = json['level'];
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
    data['email'] = email;
    data['username'] = username;
    data['fullname'] = fullname;
    data['phone'] = phone;
    if (media != null) {
      data['media'] = media!.toJson();
    }
    data['isApproved'] = isApproved;
    data['isBanned'] = isBanned;
    if (badges != null) {
      data['badges'] = badges!.toJson();
    }
    data['level'] = level;
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
