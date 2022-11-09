class DatabaseModel {
  String? title, url, img;
  DatabaseModel({required this.title, required this.url, required this.img});
  DatabaseModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    img = json['img'];
  }
  Map<String, dynamic> toJson() {
    return {'title': title, 'url': url, 'img': img};
  }
}
