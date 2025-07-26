// This code is create by M23W7502_ThetPaingOo
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:people_media/models/Tag.dart';
import "package:http/http.dart" as http;
import '../utils/Routes.dart';
import '../utils/Vary.dart';

class TagProvider extends ChangeNotifier {
  bool _isInvokded = false;
  bool _isLoading = false;
  List<Tag> _tags = [];

  bool get isLoading => _isLoading;
  List<Tag> get tags => _tags;

  Future<bool> getAll() async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;

    Uri uri = Uri.parse("$API_URL/tags");
    try {
      final response = await http.get(uri, headers: Vary.header);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data.toString());
        var lisy = data["result"] as List;
        _tags = lisy.map((e) => Tag.fromJson(e)).toList();
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

  Future<bool> addTag(name) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;

    Uri uri = Uri.parse(TAG_URL);

    var json = jsonEncode({"name": name});

    try {
      final response = await http.post(uri, body: json, headers: Vary.header);
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

  Future<bool> update(id, name) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;

    Uri uri = Uri.parse("$TAG_URL/$id");

    var json = jsonEncode({"name": name});

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

    Uri uri = Uri.parse("$TAG_URL/$id");

    try {
      final response = await http.delete(uri, headers: Vary.header);
      if (response.statusCode == 200) {
        isSuccess = true;
      } else {
        print("Ressssss ${response.body}");
      }
      print(response.body);
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
