import 'dart:convert';
import 'dart:math';

import 'package:siapchef/model/detail_resep_model.dart';
import 'package:siapchef/model/kategori_model.dart';
import 'package:http/http.dart' as http;
import 'package:siapchef/model/resep_list_model.dart';

class Repository {
  final String URL_BASE = "https://masak-apa-tomorisakura.vercel.app/api/";

  Future<KategoriModel> getKategori() async {
    var res = await http.get(Uri.parse(URL_BASE + "category/recipes"));
    if (res.statusCode == 200) {
      return KategoriModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(res.statusCode.toString());
    }
  }

  Future<ResepListModel> getHomeResep(query) async {
    String url = "";
    if (query.toString().isEmpty) {
      url = "recipes/" + Random().nextInt(999999).toString();
    } else {
      url = "category/recipes/$query/" + Random().nextInt(999999).toString();
    }
    var res = await http.get(Uri.parse(URL_BASE + url));
    if (res.statusCode == 200) {
      return ResepListModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(res.statusCode.toString());
    }
  }

  Future<DetailResepModel> getDetailResep(key) async {
    var res = await http.get(Uri.parse(URL_BASE + "recipe/$key"));
    if (res.statusCode == 200) {
      return DetailResepModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(res.statusCode.toString());
    }
  }

  //search/?q=ikan
  Future<ResepListModel> getSearchResep(query) async {
    String url = "search/?q=$query";
    print(URL_BASE + url);
    var res = await http.get(Uri.parse(URL_BASE + url));
    if (res.statusCode == 200) {
      return ResepListModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(res.statusCode.toString());
    }
  }
}
