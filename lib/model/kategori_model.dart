/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myKategoriModelNode = KategoriModel.fromJson(map);
*/
class Result {
  String? category;
  String? url;
  String? key;

  Result({this.category, this.url, this.key});

  Result.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    url = json['url'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category'] = category;
    data['url'] = url;
    data['key'] = key;
    return data;
  }
}

class KategoriModel {
  String? method;
  bool? status;
  List<Result?>? results;

  KategoriModel({this.method, this.status, this.results});

  KategoriModel.fromJson(Map<String, dynamic> json) {
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
