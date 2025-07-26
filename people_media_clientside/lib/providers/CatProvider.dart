// This code is create by M23W7502_ThetPaingOo
import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:people_media/models/Cat.dart';
import 'package:people_media/utils/Routes.dart';

import '../utils/Vary.dart';

class CatProvider extends ChangeNotifier {
  bool _isInvokded = false;
  bool _isLoading = false;
  List<Cat> _cats = [];

  bool get isLoading => _isLoading;
  List<Cat> get cats => _cats;

  Future<bool> getAll() async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;

    Uri uri = Uri.parse("$API_URL/cats");
    try {
      final response = await http.get(uri, headers: Vary.header);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data.toString());
        var lisy = data["result"] as List;
        _cats = lisy.map((e) => Cat.fromJson(e)).toList();
        isSuccess = true;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    } finally {
      print("Done!");
    }
    return isSuccess;
  }

  Future<bool> update(id, name, desc) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;

    Uri uri = Uri.parse("$CAT_URL/plain/$id");

    var json = jsonEncode({"name": name, "desc": desc});

    try {
      final response = await http.patch(uri, body: json, headers: Vary.header);
      if (response.statusCode == 200) {
        isSuccess = true;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    } finally {
      await getAll();
      print("Done");
    }
    return isSuccess;
  }

  Future<bool> delete(id) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;

    Uri uri = Uri.parse("$CAT_URL/$id");

    try {
      final response = await http.delete(uri, headers: Vary.header);
      if (response.statusCode == 200) {
        isSuccess = true;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    } finally {
      await getAll();
      print("Done");
    }
    return isSuccess;
  }

  void invoke() {
    if (!_isInvokded) {
      _isInvokded = true;
      getAll();
    }
  }
}
