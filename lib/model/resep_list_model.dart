/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myResepListModelNode = ResepListModel.fromJson(map);
*/
class Result {
  String? title;
  String? thumb;
  String? key;
  String? times;
  String? serving;
  String? difficulty;

  Result(
      {this.title,
      this.thumb,
      this.key,
      this.times,
      this.serving,
      this.difficulty});

  Result.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumb = json['thumb'];
    key = json['key'];
    times = json['times'];
    serving = json['serving'];
    difficulty = json['difficulty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['thumb'] = thumb;
    data['key'] = key;
    data['times'] = times;
    data['serving'] = serving;
    data['difficulty'] = difficulty;
    return data;
  }
}

class ResepListModel {
  String? method;
  bool? status;
  List<Result?>? results;

  ResepListModel({this.method, this.status, this.results});

  ResepListModel.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    status = json['status'];
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['method'] = method;
    data['status'] = status;
    data['results'] =
        results != null ? results!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
