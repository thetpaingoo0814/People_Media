import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:people_media/utils/Routes.dart';

class Utilprovider extends ChangeNotifier {
  String local_app_version = "1.0.1";
  bool _isLoading = false;
  bool _showTitle = false;
  String _error = "";
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get showTitle => _showTitle;

  Future<bool> checkAppVersion() async {
    _isLoading = true;
    bool isSameVersion = false;
    notifyListeners();

    String url = "$API_URL/version/$local_app_version";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        bool con = data["con"];
        if (con) {
          isSameVersion = true;
          _showTitle = true;
        } else {
          _error = data["msg"];
        }
      } else {
        _error = "Request Error!";
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return isSameVersion;
  }
}
