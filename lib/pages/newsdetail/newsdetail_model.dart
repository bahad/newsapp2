import 'package:newsapp2/core/base/base_model.dart';

class NewsDetailModel extends IBaseModel {
  Result? result;

  NewsDetailModel({this.result});

  NewsDetailModel.fromJson(Map<dynamic, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }

  @override
  fromJson(json) {
    return NewsDetailModel.fromJson(json);
  }
}

class Result {
  String? head;
  String? date;
  String? image;
  String? yazar;
  String? abstract;
  String? videoUrl;
  List<Contents>? contents;

  Result(
      {this.head,
      this.date,
      this.image,
      this.yazar,
      this.abstract,
      this.videoUrl,
      this.contents});

  Result.fromJson(Map<String, dynamic> json) {
    head = json['head'];
    date = json['date'];
    image = json['image'];
    yazar = json['yazar'];
    abstract = json['abstract'];
    videoUrl = json['videoUrl'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['head'] = head;
    data['date'] = date;
    data['image'] = image;
    data['yazar'] = yazar;
    data['abstract'] = abstract;
    data['videoUrl'] = videoUrl;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contents {
  String? paragraph;

  Contents({this.paragraph});

  Contents.fromJson(Map<String, dynamic> json) {
    paragraph = json['paragraph'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paragraph'] = paragraph;
    return data;
  }
}
