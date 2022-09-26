import 'package:newsapp2/core/base/base_model.dart';

class NewsModel extends IBaseModel {
  int? count;
  List<Result>? result;

  NewsModel({this.count, this.result});

  NewsModel.fromJson(Map<dynamic, dynamic> json) {
    count = json['count'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  fromJson(json) {
    return NewsModel.fromJson(json);
  }
}

class Result {
  String? image;
  String? title;
  String? time;
  String? subtitle;
  String? source;
  String? url;

  Result(
      {this.image,
      this.title,
      this.time,
      this.subtitle,
      this.source,
      this.url});

  Result.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    time = json['time'];
    subtitle = json['subtitle'];
    source = json['source'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    data['time'] = time;
    data['subtitle'] = subtitle;
    data['source'] = source;
    data['url'] = url;
    return data;
  }
}
