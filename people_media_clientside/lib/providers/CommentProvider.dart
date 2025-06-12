import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:people_media/utils/Routes.dart';
import 'package:http/http.dart' as http;

import '../models/Comment.dart';
import '../utils/Vary.dart';

class CommentProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Comment> _comments = [];
  bool get isLoading => _isLoading;
  List<Comment> get comments => _comments;

  Future<bool> getComments(id) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;
    String url = "$API_URL/cmmt/$id";
    Uri uri = Uri.parse(url);

    try {
      final response = await http.get(uri, headers: Vary.header);
      if (response.statusCode == 200) {
        List lisy = jsonDecode(response.body)["result"] as List;
        _comments = lisy.map((e) => Comment.fromJson(e)).toList();
        isSuccess = true;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    } finally {
      print("Done");
    }

    return isSuccess;
  }

  Future<bool> addComment(postId, content) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;
    String url = "$API_URL/cmmt/plain";
    Uri uri = Uri.parse(url);

    var json = jsonEncode({"postId": postId, "content": content});
    try {
      final response = await http.post(uri, body: json, headers: Vary.header);
      if (response.statusCode == 200) {
        isSuccess = true;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    } finally {
      print("Done");
    }

    return isSuccess;
  }

  Future<bool> addPostLike(id) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;
    String url = "$API_URL/post/like/$id";
    Uri uri = Uri.parse(url);

    try {
      final response = await http.get(uri, headers: Vary.header);
      if (response.statusCode == 200) {
        isSuccess = true;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    } finally {
      print("Done");
    }

    return isSuccess;
  }
}
