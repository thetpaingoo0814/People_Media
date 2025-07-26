// This code is create by M23W7502_ThetPaingOo
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:people_media/models/Post.dart';
import 'package:people_media/utils/Routes.dart';
import 'package:http/http.dart' as http;
import 'package:people_media/utils/Vary.dart';

class PostProvider extends ChangeNotifier {
  bool _isInvoked = false;
  bool _isLoading = false;
  String _catId = "";
  List<Post> _posts = [];
  late Post _post;
  int _index = 0;
  bool get isLoading => _isLoading;
  List<Post> get posts => _posts;
  Post get post => _post;

  Future<bool> getById(id) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;

    String url = "$API_URL/post/byid/$id";
    Uri uri = Uri.parse(url);

    try {
      final response = await http.get(uri, headers: Vary.header);
      if (response.statusCode == 200) {
        var resData = jsonDecode(response.body);
        _post = Post.fromJson(resData["result"]);
        isSuccess = true;
        _isLoading = false;
        notifyListeners();
      } else {
        print("We are error!");
      }
    } finally {}

    return isSuccess;
  }

  Future<bool> getAll() async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;

    String url = "$API_URL/post/$_index";
    Uri uri = Uri.parse(url);

    try {
      final response = await http.get(uri, headers: Vary.header);
      if (response.statusCode == 200) {
        var resData = jsonDecode(response.body);
        var lisy = resData["result"] as List;
        if (lisy.isNotEmpty) {
          List<Post> posy = lisy.map((e) => Post.fromJson(e)).toList();
          _posts.addAll(posy);
        }
        isSuccess = true;
        notifyListeners();
      } else {
        print("We are error!");
      }
    } finally {}

    return isSuccess;
  }

  Future<bool> getByCatId() async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;

    String url = "$API_URL/post/cat/$_catId/$_index";
    Uri uri = Uri.parse(url);
    print("Get By Cat Url $url");
    try {
      final response = await http.get(uri, headers: Vary.header);
      if (response.statusCode == 200) {
        print(response.body);
        var resData = jsonDecode(response.body);
        var lisy = resData["result"] as List;
        if (lisy.isNotEmpty) {
          List<Post> posy = lisy.map((e) => Post.fromJson(e)).toList();
          _posts.addAll(posy);
        }
        isSuccess = true;
        notifyListeners();
      } else {
        print("We are error!");
      }
    } finally {}

    return isSuccess;
  }

  Future<bool> update(id, title, content, category, tag) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;

    String url = "$POST_URL/plane/$id";
    print(url);
    var json = jsonEncode({
      "title": title,
      "content": content,
      "category": category,
      "tag": tag,
    });
    Uri uri = Uri.parse(url);

    try {
      final response = await http.patch(uri, body: json, headers: Vary.header);
      if (response.statusCode == 200) {
        var resData = jsonDecode(response.body);
        isSuccess = true;
        await getAll();
        notifyListeners();
      } else {
        print("We are error!");
      }
    } finally {}

    return isSuccess;
  }

  Future<bool> delete(id) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;

    String url = "$POST_URL/$id";
    Uri uri = Uri.parse(url);

    try {
      final response = await http.delete(uri, headers: Vary.header);
      if (response.statusCode == 200) {
        isSuccess = true;
        await getAll();
        notifyListeners();
      } else {
        print("We are error!");
      }
    } finally {}

    return isSuccess;
  }

  void invoke() {
    if (!_isInvoked) {
      _isInvoked = true;
      getAll();
    }
  }

  void setIndex() {
    _index++;
    getAll();
  }

  void changeCat(id) {
    _index = 0;
    _catId = id;
    _posts = [];
    getByCatId();
  }
}
