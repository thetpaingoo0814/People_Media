import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:people_media/models/User.dart';
import 'package:people_media/utils/Routes.dart';
import 'package:http/http.dart' as http;
import 'package:people_media/utils/Vary.dart';

class Userprovider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isHidePass = true;
  String _name = "tester";
  String _displayName = "";
  String _phone = "";
  String _password = "123123";
  String _error = "";
  String token = "";
  late User _user;

  String get name => _name;
  String get displayName => _displayName;
  String get phone => _phone;
  String get password => _password;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isHidePass => _isHidePass;
  User get user => _user;

  Future<bool> getMe() async {
    Uri uri = Uri.parse("$API_URL/me");
    try {
      final response = await http.get(uri, headers: Vary.header);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var userStr = data["result"];
        _user = User.fromJson(userStr);
        notifyListeners();
      }
    } catch (e) {
      // print(e.toString());
    } finally {
      notifyListeners();
    }
    return true;
  }

  Future<bool> login() async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    var json = jsonEncode({"name": _name, "password": _password});

    Uri uri = Uri.parse("$API_URL/login");
    try {
      final response = await http.post(uri, body: json, headers: Vary.header);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        token = data["result"];
        Vary.token = data["result"];
        _isLoading = false;
        isSuccess = true;
        Vary.header = {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        };
        await getMe();
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        final data = jsonDecode(response.body);
        _error = data["msg"];
      }
    } finally {
      notifyListeners();
    }
    return isSuccess;
  }

  Future<bool> register() async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    var json = jsonEncode({
      "name": _name,
      "displayName": _displayName,
      "password": _password,
      "phone": _phone,
    });

    Uri uri = Uri.parse("$API_URL/register");
    try {
      final response = await http.post(uri, body: json, headers: Vary.header);
      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        _isLoading = false;
        isSuccess = true;
        notifyListeners();
      } else {
        final data = jsonDecode(response.body);
        _error = data["msg"];
      }
    } finally {
      notifyListeners();
    }
    return isSuccess;
  }

  Future<bool> editName() async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    var json = jsonEncode({"name": name});
    Uri uri = Uri.parse("$USER_URL/changeName");
    try {
      final response = await http.post(uri, body: json, headers: Vary.header);
      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        isSuccess = true;
        await getMe();
        notifyListeners();
      } else {
        final data = jsonDecode(response.body);
        _error = data["msg"] ?? "Name change Fail!";
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return isSuccess;
  }

  Future<bool> editPassword() async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    var json = jsonEncode({"password": password});
    Uri uri = Uri.parse("$USER_URL/changePassword");
    try {
      final response = await http.post(uri, body: json, headers: Vary.header);
      if (response.statusCode == 200) {
        isSuccess = true;
        await getMe();
        notifyListeners();
      } else {
        final data = jsonDecode(response.body);
        _error = data["msg"] ?? "Password change Fail!";
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return isSuccess;
  }

  nameChange(name) {
    _name = name;
    notifyListeners();
  }

  displayNameChange(displayName) {
    _displayName = displayName;
    notifyListeners();
  }

  phoneChange(phone) {
    _phone = phone;
    notifyListeners();
  }

  passwordChange(password) {
    _password = password;
    notifyListeners();
  }

  toggleShow() {
    _isHidePass = !_isHidePass;
    notifyListeners();
  }
}
